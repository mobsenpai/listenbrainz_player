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
      inherit (pkgs) python3;
      inherit (python3.pkgs) buildPythonPackage setuptools wheel requests prompt-toolkit;

      mpv-mpris = pkgs.mpv.override {
        scripts = [pkgs.mpvScripts.mpris];
      };
    in {
      packages.default = buildPythonPackage {
        pname = "lb";
        version = "0.1.0";
        pyproject = true;

        src = ./.;

        nativeBuildInputs = [
          setuptools
          wheel
          pkgs.makeWrapper
        ];
        propagatedBuildInputs = [
          requests
          prompt-toolkit
          pkgs.yt-dlp
        ];

        postFixup = ''
          wrapProgram "$out/bin/lb" \
            --prefix PATH : ${pkgs.lib.makeBinPath [mpv-mpris]}
        '';

        meta = with pkgs.lib; {
          description = "ListenBrainz TUI music player";
          license = licenses.mit;
          mainProgram = "lb";
        };
      };

      devShells.default = pkgs.mkShell {
        buildInputs = [
          (python3.withPackages (ps: with ps; [requests prompt-toolkit yt-dlp]))
          mpv-mpris
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

          echo "🎵 ListenBrainZ TUI Music Player"
          echo ""
          echo "✅ Ready! Launch with: lb"
        '';
      };
    });
}
