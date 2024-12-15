{config, pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;  # Enable nonfree packages

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    mutableExtensionsDir = false;  # Manage extensions purely through Nix

    # Enable settings sync
    userSettings = {
      "settings.sync.enabled" = true;
      "editor.formatOnSave" = true;
      "files.autoSave" = "onFocusChange";

      # Python settings
      "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
      "python.formatting.provider" = "black";
      "python.formatting.blackPath" = "${pkgs.python3Packages.black}/bin/black";
      "python.formatting.blackArgs" = ["--line-length" "120"];
      "python.linting.enabled" = true;
      "python.linting.flake8Enabled" = true;
      "python.linting.flake8Path" = "${pkgs.python3Packages.flake8}/bin/flake8";
      "python.linting.flake8Args" = ["--max-line-length=120"];
      "python.testing.pytestEnabled" = true;
      "python.testing.unittestEnabled" = false;
      "python.testing.nosetestsEnabled" = false;
      "python.testing.pytestPath" = "${pkgs.python3Packages.pytest}/bin/pytest";
      "[python]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "ms-python.python";
        "editor.rulers" = [120];
      };

      # Go settings
      "go.useLanguageServer" = true;
      "go.formatTool" = "goimports";

      # JavaScript/React settings
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "javascript.suggest.autoImports" = true;
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
    };

    extensions = with pkgs.vscode-extensions; [
      # Python
      ms-python.python
      ms-python.vscode-pylance
      ms-python.debugpy

      # Go
      golang.go

      # JavaScript/React
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode

      # General
      eamodio.gitlens

      # Shell
      mads-hartmann.bash-ide-vscode
      timonwong.shellcheck
    ];
  };
}
