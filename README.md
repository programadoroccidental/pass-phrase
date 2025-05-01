# pass-phrase

A [pass](https://www.passwordstore.org/) extension to generate passphrases.

## Usage

```
Usage:
    pass phrase [--clip,-c] pass-name [pass-length]
	Generate a new passphrase 

    -c, --clip         Put the passphrase on the clipboard
    -d, --delimiter    Specify a word delimiter
    -q, --quiet        Be quiet
    -v, --version      Show version information
    -w, --wordlist     Specify a wordlist file
    -h, --help         Print this help message and exit
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

`pass-phrase` is available in the [Arch User Repository](https://aur.archlinux.org).

```
paru -S pass-phrase  # or your preferred AUR install method
```
