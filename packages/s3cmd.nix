{ pkgs, ... }:

let
  inherit (pkgs) lib fetchFromGitHub;
  inherit (pkgs.python38Packages)
    buildPythonApplication python_magic python-dateutil;

in buildPythonApplication rec {
  pname = "s3cmd";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "s3tools";
    repo = "s3cmd";
    rev = "v${version}";
    sha256 = "0p6mbgai7f0c12pkw4s7d649gj1f8hywj60pscxvj9jsna3iifhs";
  };

  propagatedBuildInputs = [ python_magic python-dateutil ];

  dontUseSetuptoolsCheck = true;

  meta = with lib; {
    homepage = "https://s3tools.org/s3cmd";
    description =
      "Command line tool for managing Amazon S3 and CloudFront services";
    license = licenses.gpl2;
    maintainers = [ maintainers.spwhitt ];
  };
}
