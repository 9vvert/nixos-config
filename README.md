## My NixOS Config
Hi! I'm 9vvert, interested in linux-ricing, binary analysis, game, and many more things. 

I meet NixOS purely by chance. I was first attracted by its design philosophy - "declarative configuration for everything". In later practice, I found more and more exciting features in it.

Now I am trying to use NixOS as my main linux distro. This repo is still under construction.

![](/screenshot/screen1.png)


Btw, I started my first nixos config from the following repo:
> https://github.com/Misterio77/nix-starter-configs.git

Thanks!


### Desktop
- niri

A scrollable-tiling Wayland compositor.

- fcitx5

Chinese input method

### AI
- codex

### Ctf Binary Tool (rev/pwn)
Keep expanding...

```
modules/home-manager/binary
├── debug       # gdb, pwndbg, gef, ...
├── hex         # detect-it-easy, imhex, binwalk, ...
├── pwn         # pwntools, ROPgadget, ...
└── reverse     # ida, ghidra, cutter, ...
```

Since ida is not a free software, it needs installed in `/opt/ida9`. Then we will create a fhs environment to launch it.

### Entertainment
- steam

    Thanks for proton, now we can play almost all the windows games in linux. 

- Minecraft

    `Prism Launcher`, and jdk.

- some classic roguelike/rpg game

    `cataclysm dark days ahead`, `nethack`, `tome4`

- qqmusic

### Terminal & Shell
- ghostty

My favourite terminal.

- nushell

I have been customed to zsh. But this time I am trying something new - nushell!

### Editor & Programming
- vscode

- zed

- nixvim

But my neovim config file has not been fully migrated.

- programming language

`cxx`, `python`, `rust`, `java`, `lua`, `js/ts`, ...

### Network
- dae

A proxy tool based on ebpf.

- NetworkManager

- Firefox & Google Chrome

### Misc
Many other tools.

And all the packages are installed by our nix config, in a very neat way!  
