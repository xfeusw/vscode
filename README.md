# VSCode Configuration for NixOS Home Manager

A reusable VSCode configuration flake with pre-configured extensions and settings for Rust, Haskell, and Nix development.

## Features

- **Pre-configured settings** for Rust (rust-analyzer), Haskell (HLS), and Nix (alejandra)
- **Tokyo Night theme** with Material Icon Theme
- **Privacy-focused** (telemetry disabled)
- **Performance optimized** (excludes build artifacts from watchers)
- **Custom keybindings** for terminal and formatting

## Installation

### 1. Add to your flake inputs

In your `flake.nix`:
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    # Add this flake
    vscode-config.url = "github:xfeusw/vscode-config";
  };

  outputs = { nixpkgs, home-manager, vscode-config, ... }: {
    homeConfigurations.youruser = home-manager.lib.homeManagerConfiguration {
      # ... your configuration
      modules = [
        vscode-config.homeManagerModules.vscode
        # ... other modules
      ];
    };
  };
}
```

### 2. Alternative: Direct import (without flakes)

In your `home.nix`:
```nix
{ pkgs, ... }:

{
  imports = [
    (fetchGit {
      url = "https://github.com/yourusername/vscode-config";
      ref = "main";
    } + "/config/default.nix")
  ];
}
```

### 3. Apply configuration
```bash
home-manager switch --flake .#youruser
```

## Customization

Override settings in your `home.nix`:
```nix
{
  programs.vscode.profiles.default.userSettings = {
    "workbench.colorTheme" = "Dracula";
    "editor.tabSize" = 4;
  };
}
```

## Keybindings

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+=` | Toggle terminal |
| `Ctrl+Alt+F` | Format document |

## Structure
```
.
├── flake.nix              # Flake definition
└── config/
    ├── default.nix        # Main configuration
    └── extensions.nix     # VSCode extensions list
```

## Requirements

- NixOS with flakes enabled
- Home Manager
- `allowUnfree = true` in your config (for VSCode)

## License

MIT
