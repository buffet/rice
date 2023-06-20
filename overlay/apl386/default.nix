{
  inputs,
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "apl386";
  version = "unstable";

  src = inputs.apl386;

  installPhase = ''
    runHook preInstall

    install -Dm644 APL386.ttf -t $out/share/fonts/apl386

    runHook postInstall
  '';

  meta = with lib; {
    description = "APL385 Unicode font evolved ";
    homepage = "https://github.com/abrudz/APL386";
    license = licenses.unlicense;
    maintainers = with maintainers; [buffet];
    platforms = platforms.all;
  };
}
