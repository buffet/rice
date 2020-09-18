{ sources ? import ../nix/sources.nix
, python38Packages
, lib
, i3ipc }:
python38Packages.buildPythonPackage {
  name = "autotiling";

  src = sources.autotiling;

  propagatedBuildInputs = [
    i3ipc
  ];

  doCheck = false;

  meta = with lib; {
    description = "Script for sway and i3 to automatically switch the horizontal / vertical window split orientation";
    homepage = "https://github.com/nwg-piotr/autotiling";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ buffet ];
  };
}
