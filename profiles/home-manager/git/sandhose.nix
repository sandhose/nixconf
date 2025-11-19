{ ... }:

{
  programs = {
    git = {
      signing = {
        key = "552719FC";
        signByDefault = true;
      };

      settings.user = {
        email = "quentingliech@gmail.com";
        name = "Quentin Gliech";
      };
    };
  };
}
