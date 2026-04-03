{ ... }:

{
  programs.jujutsu.settings = {
    user = {
      name = "Quentin Gliech";
      email = "quentingliech@gmail.com";
    };

    signing = {
      backend = "gpg";
      key = "552719FC";
      sign-all = true;
    };

    git.push-bookmark-prefix = "quenting/push-";
  };
}
