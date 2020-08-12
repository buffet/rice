{ sources ? import ../nix/sources.nix
, buildGoModule, lib }:
buildGoModule {
  name = "trup";

  src = sources.trup;

  vendorSha256 = "1a8z68hypvz5d38qjrpz9355pzg41gc1q67k5h3hw6vz4pm94kkl";

  meta = with lib; {
    description = "Discord bot for the Unixporn community";
    homepage = "https://gitlab.com/unixporn/trup";
    license = licenses.mpl20;
    platforms = platforms.all;
    maintainers = with maintainers; [ buffet ];
  };
}
