{ pkgs }:

{
  systemPackages =
    with pkgs; [
      cocoapods
      zola
      # vagrant
      postgresql_12
      pinentry_mac
      # weechat

      libssh2
      scons
      # gcc-arm-embedded
      nnn
      nats-streaming-server
      libcoap
      python37Packages.onkyo-eiscp

      nanomsg
      libffi

      # gradle
      # maven
      notmuch
      reattach-to-user-namespace
      neomutt
      rustup
      # haskellPackages.pandoc-citeproc
      # haskellPackages.pandoc-crossref
      luajit
      # mysql-client
      msmtp

      # xquartz
      wireshark
    ];

  variables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    LANG = "en_US.UTF-8";
  };
}
