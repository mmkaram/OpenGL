{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";  # Adjust this if you're using a different system
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
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
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
      };
    };
}


