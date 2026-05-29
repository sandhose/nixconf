{ pkgs, ... }:

{
  home.packages = with pkgs; [
    my.zsh-funcs
    jj-starship
  ];

  programs = {
    zsh = {
      enable = true;

      autocd = true;
      defaultKeymap = "emacs";

      history = {
        extended = true;
        save = 10000;
        size = 10000;
        share = true;
        expireDuplicatesFirst = true;
      };

      shellAliases = {
        zmv = "noglob zmv -W";
        dr = "docker run -it --rm";
      };

      initContent = builtins.readFile ./additional.zsh;
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
        openstack.disabled = true;

        # Unified git/jj prompt module: https://github.com/dmmulroy/jj-starship
        custom.jj = {
          when = "jj-starship detect";
          shell = [ "jj-starship" ];
          format = "$output ";
        };
        git_branch.disabled = true;
        git_status.disabled = true;
      };
    };
  };
}
