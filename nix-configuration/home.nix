{
  # FIXME: uncomment the next line if you want to reference your GitHub/GitLab access tokens and other secrets
  # secrets,
  pkgs,
  username,
  nix-index-database,
  ...
}: let
  unstable-packages = with pkgs.unstable; [
    # Packages that we want on the bleeding-edge goes here.
    curl
    git
    htop
    jq
    neovim
    tmux
    unzip
    wget
    zip
  ];

  stable-packages = with pkgs; [
    # Packages that we want to be stable goes here.

    cascadia-code

    # rust stuff
    rustup
    cargo-cache
    cargo-expand
  ];
in {
  imports = [
    nix-index-database.hmModules.nix-index
  ];
  
  fonts.fontconfig.enable = true;

  home.stateVersion = "22.11";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/zsh";
  };

  home.packages =
    stable-packages
    ++ unstable-packages;

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;

    fzf.enable = true;
    fzf.enableZshIntegration = true;
    lsd.enable = true;
    lsd.enableAliases = false;
    zoxide.enable = true;
    zoxide.enableZshIntegration = true;
    zoxide.options = ["--cmd cd"];
  
    # TODO: Set git up correctly.
    git = {
      enable = true;
      package = pkgs.unstable.git;
      userEmail = "ryantam626@gmail.com";
      userName = "Ryan Tam";
      extraConfig = {
        push = {
          default = "current";
          autoSetupRemote = true;
        };
      };
    };

    zsh = {
      enable = true;
      syntaxHighlighting = {
        enable = true;
      };
      shellAliases = {
        pbcopy = "/mnt/c/Windows/System32/clip.exe";
        copy = "/mnt/c/Windows/System32/clip.exe";
        clc = "git rev-parse HEAD | copy";
        "gc-" = "git checkout -";
        gcn = "git commit --no-verify";
        gcor = "gco $(grecent | fzf)'";
        gcm = "git checkout $(git_main_branch)";
        grecent = "git for-each-ref --sort=-committerdate --count=20 --format='%(refname:short)' refs/heads/";
        gsh = "git show";
        rbm = "git rebase $(git_main_branch) -i";
        rt = "gb | grep rt.";
      };
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "zoxide" ];
      };
    };
  };
}
