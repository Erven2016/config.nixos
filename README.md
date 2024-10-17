# NixOS 配置文件

🚧 正在重构

## 目录结构

```tree
.
└── ~/.config/nixos/
    ├── hardware/ # 共用硬件配置
    ├── home-manager/ # 共用 home-manager 配置文件
    ├── hosts/ # 主机配置/
    │   └── [*hostname].nix
    ├── lib/ # 共用库
    ├── packages # 共用包
    ├── modules/ # 共用模块
    ├── users/ # 用户配置/
    │   └── [*username].nix
    ├── configuration.nix # 默认配置
    ├── flake.lock # flake 版本锁（一般不用动）
    └── flake.nix # flake 配置文件
```

## 常用命令

- `sudo nix-collect-garbage -d`: 清理无用 derivations，释放硬盘占用
- `sudo nixos-rebuild @1 --impure --flake .@2 --show-trace`: 构建系统
  - `@1`: `switch`整个系统|`boot`引导分区
  - `@2`: 留空使用当前hostname|`#hostname`选择某个hostname配置
- 系统更新先执行 `nix flake update` 后再执行构建系统命令

## 配置封装

我已经把一些常用的配置封装了，这样用起来比较方便，大部分已经封装的东西用我默认配置就行。

### 系统引导

### 桌面环境

#### Gnome

### 输入法

### 字体

默认情况下，如果使用了图形化界面，则自动启用字体管理。非图形化界面仍使用启用字体管理，请使用`system.fonts.enable = true;`来开启。

默认安装的字体为 `Noto Fonts` (包括CJK与Emoji), 以及 Nerd patched fonts `FiraCode` 和 `IBMPlexMono`.

#### 安装字体

如果要添加额外字体，请参考：

```nix
# config = {...} 中

system.fonts.extraFonts = with pkgs; [
  roboto
  ... # 字体 packages
];

system.fonts.extraNerdFonts = [
  "JetBrainsMono"
  ... # nerd 字体名称
]
  
```

#### 配置字体

默认使用字体(有先后顺序)：

- sanSerif: `Noto sans`
- Serif: `Noto Serif`, `Time New Roman`
- monospace: `IBMBlexMono`, `FiraCode`
- emoji: `Noto Color Emoji`

添加自定义字体配置，可以参考以下配置，注意先后顺序，前面的字体会先被使用：

```nix
# 写在 config = {...} 中
fonts.fontconfig = {
  defaultFonts = {
    # enable = true; # fontconfig 默认启用，不用动
    emoji = [ "Noto Color Emoji" ];
    monospace = [
      "BlexMono Nerd Font Mono"
      "FiraCode Nerd Font Mono"
    ];
    serif = [
      "Noto Serif"
      "Times New Roman"
    ];
    sansSerif = [ "Noto Sans" ];  };
};
```

### Flatpak

### AppImage

## 驱动



## 待办事项

- [ ] 模块化配置 - 20241015
- [ ] 添加硬件配置 - 20241015
- [ ] 废除 ./system/ - 20241015
