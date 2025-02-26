{
  description = "The Pong game in Go with ebitengine 2D game engine.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f:
        builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        }) systems);
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              go
              gopls
              just

              libGL
              libglvnd
              libusb1
              mesa

              xorg.libX11
              xorg.libXcursor
              xorg.libXrandr
              xorg.libXext
              xorg.libXinerama
              xorg.libXi
              xorg.libXxf86vm
            ];
            shellHook = ''
              # Include OpenGL headers and libraries
              export LD_LIBRARY_PATH=${pkgs.lib.getLib pkgs.libGL}/lib:${
                pkgs.lib.getLib pkgs.libGL
              }/lib:$LD_LIBRARY_PATH

              echo "⭐welcome to pong development environment⭐"
              just
            '';
          };
        });
    };
}
