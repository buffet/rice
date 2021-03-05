{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "ultralist";
  version = "1.7.0";

  goPackagePath = "github.com/ultralist/ultralist";

  src = fetchFromGitHub {
    owner = "ultralist";
    repo = pname;
    rev = version;
    sha256 = "0rjaaci9iwmhpcncsbmvznmmnczj2kvzzhxldkamdgvhpbm5cq0q";
  };

  meta = with stdenv.lib; {
    description = "Simple task management for tech folks";
    homepage = https://github.com/cjbassi/gotop;
    license = licenses.mit;
    maintainers = with maintainers; [ buffet ];
    platforms = platforms.unix;
  };
}
