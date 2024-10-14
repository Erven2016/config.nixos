# NixOS 配置文件

🚧 正在重构

## 目录结构

```tree

```

## 一些常用命令

- `sudo nix-collect-garbage -d`: 清理未使用的 Derivation, 降低硬盘占用率
- `sudo nixos-rebuild [target] --impure --flake . --show-trace`: 构建 nixos
  - [target] 选项
    - switch    构建整个系统
    - boot      构建引导 /boot 例如 grub
  - 初次安装或修改 hostname 后需要指定 hostname: `--flake .#you-hostname`
  - 建议配合 proxychains4 使用

## 待办事项

- [ ] 模块化整个配置

