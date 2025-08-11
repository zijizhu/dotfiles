# 🔵 dotfiles

This repo contains a bunch of dotfiles for various programs. They are managed by [GNU stow](https://www.gnu.org/software/stow/).

This includes the config files for:
- [kitty terminal](https://sw.kovidgoyal.net/kitty/)
- [neovim](https://neovim.io)
- [starship](https://starship.rs/)
- [GNU Emacs](https://www.gnu.org/software/emacs/)

Usage:

To stow the `emacs` package into `$HOME/.config` directory:

```bash
stow -v --no-folding --dotfiles emacs
```

To stow the rest of packages:

```bash
stow -v --dotfiles --ignore=emacs .
```

To clean up the stow of `emacs` package:

```bash
stow -v -D --no-folding --dotfiles emacs && rmdir $HOME/.config/emacs
```

To clean up the rest of the stowed packages:

```bash
stow -v -D --dotfiles --ignore=emacs .
```

## 📦 Installation of Other Tools

### General Shell programs

- [`direnv`](https://direnv.net/)
- [`fzf`](https://github.com/junegunn/fzf)

### Programming Languages and Frameworks

- [`uv`](https://docs.astral.sh/uv/)
- [`bun`](https://bun.sh/)
- [`nvm`](https://github.com/nvm-sh/nvm)
