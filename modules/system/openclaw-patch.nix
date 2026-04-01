{ lib, ... }:
{
  # Temporary local patch for nix-openclaw plugin manifests.
  # Keep this isolated here (not in flake.nix) so it is easy to remove once upstream fixes packaging.
  nixpkgs.overlays = [
    (final: prev: {
      openclaw = prev.openclaw.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          if [ -d "$src/extensions" ]; then
            while IFS= read -r manifest; do
              rel="''${manifest#$src/extensions/}"
              extDir="''${rel%/openclaw.plugin.json}"
              mkdir -p "$out/lib/openclaw/dist/extensions/$extDir"
              cp -f "$manifest" "$out/lib/openclaw/dist/extensions/$extDir/openclaw.plugin.json"
            done < <(find "$src/extensions" -mindepth 2 -maxdepth 2 -type f -name openclaw.plugin.json || true)
            chmod -R a+r "$out/lib/openclaw/dist/extensions" || true
          fi
        '';
      });
    })
  ];
}
