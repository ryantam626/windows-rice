{ lib, pkgs, ... }:
let
  username = "rtam";
  git-author-name = "Ryan Tam";
  git-email = "ryantam626@gmail.com";
in {
  home = {
    packages = with pkgs; [
      cascadia-code
      curl
      git
      go-task
      htop
      jq
      tmux
      unzip
      wget
      zip
      zsh
    ];

    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    sessionVariables.SHELL = "/home/${username}/.nix-profile/bin/zsh";

    stateVersion = "24.11";
  };
  programs = {
    home-manager.enable = true;

    fzf.enable = true;
    fzf.enableZshIntegration = true;
    lsd.enable = true;
    lsd.enableAliases = false;
    zoxide.enable = true;
    zoxide.enableZshIntegration = true;

    command-not-found.enable = false;

    git = {
      enable = true;
      userEmail = "${git-email}";
      userName = "${git-author-name}";
      extraConfig = {
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        stash = {
          showPatch = true;
        };
        rebase = {
          autosquash = true;
        };
        pull = {
          rebase = true;
        };
        rerere = {
          enabled = true;
        };
      };
    };

    zsh = {
      enable = true;
      syntaxHighlighting = { enable = true; };
      initExtraFirst = ''
        source $HOME/.nix-profile/etc/profile.d/nix.sh
      '';
      initExtra = ''
        eval "$(task --completion zsh)"
      '';
      shellAliases = {
        pbcopy = "/mnt/c/Windows/System32/clip.exe";
        copy = "/mnt/c/Windows/System32/clip.exe";
        clc = "git rev-parse HEAD | copy";
        "gc-" = "git checkout -";
        gcn = "git commit --no-verify";
        gcor = "gco $(grecent | fzf)";
        gcm = "git checkout $(git_main_branch)";
        grecent =
          "git for-each-ref --sort=-committerdate --count=20 --format='%(refname:short)' refs/heads/";
        gsh = "git show";
        rbm = "git rebase $(git_main_branch) -i";
        rt = "gb | grep rt.";
        vim = "nvim";
      };
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "zoxide" ];
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      extraConfig = ''
        luafile ${./nvim.lua}
      '';
    };

    tmux = let
      tmux-nord = pkgs.tmuxPlugins.mkTmuxPlugin {
        pluginName = "nord";
        version = "0.3.0";
        src = pkgs.fetchFromGitHub {
          owner = "nordtheme";
          repo = "tmux";
          rev = "v0.3.0";
          hash = "sha256-s/rimJRGXzwY9zkOp9+2bAF1XCT9FcyZJ1zuHxOBsJM=";
        };
      }; in {
      aggressiveResize = true;
      baseIndex = 1;
      clock24 = true;
      enable = true;
      terminal = "screen-256color";
      keyMode = "vi";
      prefix = "C-a";
      historyLimit = 100000;
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmux-nord
        {
          plugin = tmuxPlugins.yank;
          extraConfig = ''
            set -g @yank_selection_mouse 'clipboard'
            set -g @override_copy_command 'copy'
          '';
        }
        {
          plugin = tmuxPlugins.tmux-thumbs;
          extraConfig = ''
            set -g @thumbs-key v
            set -g @thumbs-position left
            set -g @thumbs-command 'echo -n {} | /mnt/c/Windows/System32/clip.exe'
          '';
        }
      ];
      extraConfig = ''
        # Split panes using Prefix+- and Prefix+_ instead of Prefix+" and Prefix+%
        bind-key _ split-window -h -c '#{pane_current_path}'
        bind-key - split-window -v -c '#{pane_current_path}'
        unbind-key '"'
        unbind-key '%'

        # Pane nav
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
        bind-key -n 'M-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'M-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'M-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'M-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

        bind-key -T copy-mode-vi 'M-h' select-pane -L
        bind-key -T copy-mode-vi 'M-j' select-pane -D
        bind-key -T copy-mode-vi 'M-k' select-pane -U
        bind-key -T copy-mode-vi 'M-l' select-pane -R

        # Create window with Ctrl+T instead of Prefix+c
        bind -n C-t new-window
        unbind-key 'c'

        # Alt+[ for copy mode
        bind -n M-[ copy-mode

        # Move to new window with Alt+Shift+H/L
        bind-key -n M-H previous-window
        bind-key -n M-L next-window

        # Setup 'v' to begin selection as in Vim
        bind-key -T copy-mode-vi v send -X begin-selection

        # make colors inside tmux look the same as outside of tmux
        # see https://github.com/tmux/tmux/issues/696
        # see https://stackoverflow.com/a/41786092
        set-option -ga terminal-overrides ",xterm-256color:Tc"
        # bg color of active pane, https://www.color-hex.com/color-palette/1029048, darkest
        setw -g window-active-style 'bg=#292e39'

      '';
    };
  };
}

