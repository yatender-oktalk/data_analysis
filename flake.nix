{
  description = "Jupyter development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            (python3.withPackages (ps: with ps; [
              jupyter
              notebook
              ipykernel
              numpy
              pandas
              matplotlib
              scipy
              scikit-learn
              seaborn
              plotly
              ipywidgets
            ]))
            nodejs
            pandoc
          ];

          shellHook = ''
            mkdir -p ~/.jupyter
            export JUPYTER_PATH="${pkgs.jupyter}/share/jupyter"
            export JUPYTER_CONFIG_DIR="$HOME/.jupyter"
            echo "Jupyter environment ready! Start notebook with: jupyter notebook"
          '';
        };
      });
}
