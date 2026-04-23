{
  description = "ListenBrainz TUI music player";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python3;

      pythonEnv = python.withPackages (ps:
        with ps; [
          requests
          yt-dlp
          prompt-toolkit
        ]);

      lb-tui = python.pkgs.buildPythonPackage {
        pname = "lb";
        version = "0.1.0";
        src = ./.;
        propagatedBuildInputs = with python.pkgs; [
          requests
          yt-dlp
          prompt-toolkit
        ];
        meta = {
          description = "ListenBrainz TUI music player";
          license = pkgs.lib.licenses.mit;
          mainProgram = "lb";
        };
      };
    in {
      packages.default = lb-tui;

      devShells.default = pkgs.mkShell {
        buildInputs = [
          pythonEnv
          pkgs.mpv
          pkgs.yt-dlp
        ];

        shellHook = ''
          if [ -f .env ]; then
            export $(grep -v '^#' .env | xargs)
            echo "✅ Loaded credentials from .env"
          else
            echo "⚠️  .env file not found. Create one from .env.template"
          fi

          export PYTHONPATH="$PWD:$PYTHONPATH"
          alias lb='python -m lb'

          echo "🎵 ListenBrainz TUI Music Player"
          echo ""
          echo "✅ Ready! Launch with: lb"
          echo ""
        '';
      };
    });
}
