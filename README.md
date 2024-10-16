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

我已经把一些常用的配置封装了，这样用起来比较方便，大部分已经封装的东西用我默认
配置就行。

### 桌面环境

### 输入法

### 字体

### Flatpak

### AppImage

## 驱动



## 待办事项

- [ ] 模块化配置 - 20241015
- [ ] 添加硬件配置 - 20241015
- [ ] 废除 ./system/ - 20241015
