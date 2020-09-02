{ makeWrapper, rclone }:
rclone.overrideAttrs (oldAttrs: {
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ makeWrapper ];

  postFixup = ''
    wrapProgram $out/bin/rclone \
        --prefix PATH : /run/wrappers/bin
  '';
})
