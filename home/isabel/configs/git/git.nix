{
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.programs.agnostic.git;
in {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "isabel";
    userEmail = "isabel" + "@" + "isabelroses" + "." + "com"; # obsfuscate email to prevent webscrapper spam

    signing = {
      key = cfg.signingKey;
      signByDefault = true;
    };

    lfs = {
      enable = true;
      skipSmudge = true; # we don't want another ctp/userstyles situation
    };

    ignores = [
      ".DS_Store"
      "*.bak"
      "*.swp"
      "*.swo"
      "target/"
      ".cache/"
      ".idea/"
      "*.swp"
      "*.elc"
      ".~lock*"
      "auto-save-list"
      ".direnv/"
      "node_modules"
      "result"
      "result-*"
    ];

    delta = {
      enable = true;
      catppuccin.enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };

    extraConfig = {
      init.defaultBranch = "main"; # warning the AUR hates this
      repack.usedeltabaseoffset = "true";
      color.ui = "auto";
      diff.algorithm = "histogram"; # a much better diff
      help.autocorrect = 10; # 1 second warning to a typo'd command

      core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";

      branch = {
        autosetupmerge = "true";
        sort = "committerdate";
      };

      commit.verbose = true;

      fetch.prune = true;

      pull.ff = "only"; # equivalent to --ff-only

      push = {
        default = "current";
        followTags = true;
        autoSetupRemote = true;
      };

      merge = {
        stat = "true";
        conflictstyle = "zdiff3";
        tool = "meld";
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
      };

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      # prevent data corruption
      transfer.fsckObjects = true;
      fetch.fsckObjects = true;
      receive.fsckObjects = true;

      url = {
        "https://github.com/".insteadOf = "github:";
        "ssh://git@github.com/".pushInsteadOf = "github:";
        "https://gitlab.com/".insteadOf = "gitlab:";
        "ssh://git@gitlab.com/".pushInsteadOf = "gitlab:";
        "https://aur.archlinux.org/".insteadOf = "aur:";
        "ssh://aur@aur.archlinux.org/".pushInsteadOf = "aur:";
        "https://git.sr.ht/".insteadOf = "srht:";
        "ssh://git@git.sr.ht/".pushInsteadOf = "srht:";
        "https://codeberg.org/".insteadOf = "codeberg:";
        "ssh://git@codeberg.org/".pushInsteadOf = "codeberg:";
      };
    };

    aliases = {
      st = "status";
      br = "branch";
      c = "commit -m";
      ca = "commit -am";
      co = "checkout";
      d = "diff";
      df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
      fuck = "commit --amend -m";
      graph = "log --all --decorate --graph";
      ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
      pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
      af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
      hist = ''
        log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all
      '';
      llog = ''
        log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative
      '';
    };
  };
}
