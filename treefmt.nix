{ ... }:
{
  projectRootFile = "flake.nix";
  programs.nixfmt.enable = true;
  programs.texfmt.enable = true;
  programs.mbake.enable = true;
}
