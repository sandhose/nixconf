{
  writeShellApplication,
  gh,
  jq,
  jujutsu,
  ...
}:

writeShellApplication {
  name = "jj-mark-reviewed";
  runtimeInputs = [
    gh
    jq
    jujutsu
  ];
  text = builtins.readFile ./jj-mark-reviewed.sh;
}
