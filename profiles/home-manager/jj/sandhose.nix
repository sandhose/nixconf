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
    };

    git = {
      push-bookmark-prefix = "quenting/push-";
      sign-on-push = true;
    };
  };
}
