{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        name = "window";
        src = ./.;
        nativeBuildInputs = with pkgs; [ cmake ];
        buildInputs = with pkgs; [
          glfw
          glew
          libGL
          xorg.libX11
          xorg.libXi
          xorg.libXrandr
          xorg.libXxf86vm
          xorg.libXcursor
          xorg.libXinerama
        ];
        buildPhase = ''
          cmake .
          make
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp window $out/bin/
        '';
      };

      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/window";
      };

      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [ self.packages.${system}.default ];
      };
    };
}

