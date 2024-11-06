{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Python with Jupyter
    (python3.withPackages (ps: with ps; [
      jupyter
      notebook
      ipykernel
      
      # Common data science packages
      numpy
      pandas
      matplotlib
      scipy
      scikit-learn
      
      # Optional: Additional useful packages
      seaborn
      plotly
      ipywidgets
      openpyxl
    ]))

    # Additional system dependencies
    nodejs # For JupyterLab extensions
    pandoc # For notebook conversion
  ];

  shellHook = ''
    # Set up Jupyter notebook configuration
    mkdir -p ~/.jupyter
    
    # Set environment variables
    export JUPYTER_PATH="${pkgs.jupyter}/share/jupyter"
    export JUPYTER_CONFIG_DIR="$HOME/.jupyter"
    
    echo "Jupyter environment ready! Start notebook with: jupyter notebook"
  '';
}
