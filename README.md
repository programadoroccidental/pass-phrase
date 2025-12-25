# pass-phrase

A [pass](https://www.passwordstore.org/) extension for generating passphrases.

## Usage

```
Usage:
    pass phrase [--wordlist,-w] [--delimiter,-d] [--clip,-c] [--qrcode,-q] [--in-place,-i | --force,-f] pass-name [phrase-length]
        Generate a new passphrase 

Options:
    -w, --wordlist     Specify a wordlist file
    -d, --delimiter    Specify a word delimiter
    -c, --clip         Put the passphrase on the clipboard
    -q, --qrcode       Display a QR code
	-i, --in-place     Only replace the first line of the password file
    -f, --force        Do not prompt before overwriting
    -v, --version      Show version information
    -h, --help         Print this help message and exit

More information may be found in the pass-phrase(1) man page.
```

## Installation

### From git

```
git clone https://github.com/programadoroccidental/pass-phrase
cd pass-phrase
sudo make install
```

or, to install in the user dir (following the standard XDG base directory paths):

```
$ echo $XDG_DATA_HOME
/home/$USER/.local/share

$ export PASSWORD_STORE_ENABLE_EXTENSIONS=true
$ export PASSWORD_STORE_EXTENSIONS_DIR=$XDG_DATA_HOME/password-store/.extensions

$ PREFIX=$XDG_DATA_HOME \
    LIBDIR=$PREFIX \
    make install
```

### Arch Linux

`pass-phrase` is available in the [Arch User Repository](https://aur.archlinux.org/packages/pass-phrase).

```
paru -S pass-phrase  # or your preferred AUR install method
```
