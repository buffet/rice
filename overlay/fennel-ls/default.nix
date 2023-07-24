{
  inputs,
  lib,
  stdenvNoCC,
  lua,
  luaPackages,
}:
stdenvNoCC.mkDerivation {
  name = "fennel-ls";

  src = inputs.fennel-ls;

  nativeBuildInputs = [luaPackages.fennel];
  buildInputs = [lua];

  makeFlags = ["PREFIX=$(out)"];

  meta = with lib; {
    description = "A language server for fennel-ls.";
    homepage = "https://git.sr.ht/~xerool/fennel-ls";
    license = licenses.mit;
    platforms = lua.meta.platforms;
    maintainers = with maintainers; [buffet];
  };
}
