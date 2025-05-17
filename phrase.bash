#!/usr/bin/env bash

WORDLIST="${PASSWORD_STORE_PHRASE_WORDLIST:-/usr/share/wordlists/eff_large_wordlist.txt}"
PHRASE_LENGTH="${PASSWORD_STORE_PHRASE_LENGTH:-12}"
DELIMITER="${PASSWORD_STORE_PHRASE_DELIMITER:--}"

VERSION="1.2"

cmd_phrase_version() {
	cat <<-_EOF
		$PROGRAM $COMMAND $VERSION - A pass extension to generate passphrases
	_EOF
}

cmd_phrase_usage() {
	cmd_phrase_version
	echo
	cat <<-_EOF
		Usage:
		    $PROGRAM phrase [--wordlist,-w] [--delimiter,-d] [--clip,-c] [--qrcode,-q] [--force,-f] pass-name [phrase-length]
		        Generate a new passphrase 

		Options:
		    -w, --wordlist     Specify a wordlist file
		    -d, --delimiter    Specify a word delimiter
		    -c, --clip         Put the passphrase on the clipboard
		    -q, --qrcode       Display a QR code
		    -f, --force        Do not prompt before overwriting
		    -v, --version      Show version information
		    -h, --help         Print this help message and exit

		More information may be found in the pass-phrase(1) man page.
	_EOF
}

cmd_phrase() {
	local path="$1"
	local length="${2:-$PHRASE_LENGTH}"
	check_sneaky_paths "$path"
	[[ $length =~ ^[0-9]+$ ]] || die "Error: pass-length \"$length\" must be a number."
	[[ $length -gt 0 ]] || die "Error: pass-length must be greater than zero."
	local passfile="$PREFIX/$path.gpg"
	mkdir -p -v "$PREFIX/$(dirname -- "$path")"
	set_gpg_recipients "$(dirname -- "$path")"
	local passfile="$PREFIX/$path.gpg"
	set_git "$passfile"

	[[ $force -eq 0 && -e $passfile ]] && yesno "An entry already exists for $path. Overwrite it?"

	local phrase
	mapfile -t words < <(shuf -n "$length" "$WORDLIST")
	phrase=$(printf "%s$DELIMITER" "${words[@]}")
	phrase=${phrase%"$DELIMITER"}

	echo "$phrase" | $GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" || die "Passphrase encryption aborted."

	message="Add generated passphrase for $path."
	git_add_file "$passfile" "$message" 

	if [[ $clip -eq 1 ]]; then
		clip "$phrase" "$path"
	elif [[ $qrcode -eq 1 ]]; then
		qrcode "$phrase" "$path"
	else
		printf "\e[1mThe generated passphrase for \e[4m%s\e[24m is:\e[0m\n\e[1m\e[93m%s\e[0m\n" "$path" "$phrase"
	fi
}


opts="$($GETOPT -o hw:d:cqfv -l help,clip,delimiter:,qrcode,wordlist:,force,version -n "$PROGRAM $COMMAND" -- "$@")"
err=$?
eval set -- "$opts"
while :; do
	case "$1" in
		-h | --help)
			cmd_phrase_usage
			exit 0
		;;

		-w | --wordlist)
			shift
			WORDLIST="$1"
		;;

		-d | --delimiter)
			shift
			DELIMITER="$1"
		;;

		-c | --clip)
			clip=1
		;;

		-q | --qrcode)
			qrcode=1
		;;

		-f | --force)
			force=1
		;;

		-v | --version)
			cmd_phrase_version
			exit 0
		;;

		--)
			shift 
			break
		;;
	esac
	shift
done


[[ $err -ne 0 || ( $# -ne 2 && $# -ne 1 ) || ( $qrcode -eq 1 && $clip -eq 1 ) ]] && die "Usage: $PROGRAM $COMMAND [--wordlist,-w] [--delimiter,-d] [--clip,-c] [--qrcode,-q] [--force,-f] pass-name [phrase-length]"

cmd_phrase "$@"
