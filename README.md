# My Dotfiles

## Zsh

```
apt install zsh
```

## Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## P10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

## Config zshrc

```bash
ln -nfs $PWD/zsh/zshrc ~/.zshrc
```

## Vim

```bash
ln -nfs $PWD/vim/vimrc ~/.vimrc
```

## OSX

```bash
./homebrew/install.sh
```