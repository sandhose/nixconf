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

    templates.git_push_bookmark = ''"quenting/push-" ++ change_id.short()'';

    revsets.git-sign-on-push = "~signed() & mine()";
  };
}
