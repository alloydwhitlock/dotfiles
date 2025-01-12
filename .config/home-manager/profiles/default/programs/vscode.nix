{config, pkgs, lib, ...}: {
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

      # Set the Nord theme
      "workbench.colorTheme" = "Nord";
    };

    extensions = with pkgs.vscode-extensions; [
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

      # Nord theme
      arcticicestudio.nord-visual-studio-code
    ] ++ lib.optionals (pkgs.stdenv.hostPlatform.system != "aarch64-linux") [
      # Extensions not supported on aarch64-linux
      ms-python.python
      ms-python.vscode-pylance
      ms-python.debugpy
    ];
  };
}
