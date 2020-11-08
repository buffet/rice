{ stdenv, buildPythonPackage, fetchPypi, isPy27, setuptools, plover }:
buildPythonPackage rec {
  pname = "plover_retro_stringop";
  version = "0.1.2";
  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1vcrjpym1s3sz6l31bjw41mlbvbszk4nyn4kj5j9z0k0a6m9y1qa";
  };

  checkInputs = [ setuptools ];
  buildInputs = [ plover ];
}
