{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      # the quick shell has already been tuned with nixpkgs
      # inputs.quickshell.follows = "quickshell";  # Use same quickshell version
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
          url = "github:nix-community/home-manager/release-25.11";
            # The `follows` keyword in inputs is used for inheritance.
            # Here, `inputs.nixpkgs` of home-manager is kept consistent with
            # the `inputs.nixpkgs` of the current flake,
            # to avoid problems caused by different versions of nixpkgs.
            inputs.nixpkgs.follows = "nixpkgs";
        };
    # nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-25.05&shallow=1";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    codex-cli-nix.url = "github:sadjow/codex-cli-nix";
	
  };

  outputs = { 
    self, nixpkgs, home-manager, noctalia, codex-cli-nix, ... 
  }@inputs: let
    systems = [
      "x86_64-linux"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems; 
  in
    {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    
    # ----------------- UNCOMMENT -----------------
    # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      "nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          # > Our main nixos configuration file <
          ./nixos/configuration.nix
          # ./configuration.nix
          # ./noctalia.nix
          inputs.daeuniverse.nixosModules.dae

          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   # When loading home.nix, pass an extra argument named inputs.
          #   # IMPORTANT: pass `inputs` to home.nix so `inputs.niri-flake...` works there
          #   home-manager.extraSpecialArgs = { inherit inputs; };
          #   home-manager.users.woc = import ./home-manager/home.nix;
          # }
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "woc" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # FIXME replace x86_64-linux with your architecture 
        extraSpecialArgs = {inherit inputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
          
        ];
      };
    };
  };
}
