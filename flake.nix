{
  description = "Reusable VSCode configuration for Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
        "vscode"
      ];
    };
  in {
    # Export as reusable Home Manager module
    homeManagerModules.vscode = import ./config/default.nix { inherit pkgs; };
  };
}
