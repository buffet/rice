{ plover, plover_retro_stringop }:
plover.overridePythonAttrs (
  oldAttrs: {
    name = "plover-with-plugins3";
    propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [
      plover_retro_stringop
    ];
  }
)
