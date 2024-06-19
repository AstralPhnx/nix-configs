{
  description = "NixOS Config with flakes for personal ThinkPad T14 AMD Gen 1";
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-24.05;
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  outputs = { self, nixpkgs, nixos-hardware }: {
    nixosConfigurations.astralthinkpad = nixpkgs.lib.nixosSystem {
      modules = [
        # ...
        nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
        ./configuration.nix
      ];
    };
  };
}