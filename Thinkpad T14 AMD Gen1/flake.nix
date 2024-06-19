{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-24.05;
  outputs = { self, nixpkgs }: {
    nixosConfigurations.astralthinkpad = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}