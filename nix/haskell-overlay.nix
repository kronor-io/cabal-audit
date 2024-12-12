{hlib, ...}: hfinal: hprev:
let
  fetchFromHackage = pname: version: hash:
    hfinal.callHackageDirect {
      pkg = pname;
      ver = version;
      sha256 = hash;
    };
  ps-cabal-install-solver = (fetchFromHackage "cabal-install-solver" "3.10.3.0" "sha256-4J/7Sgh2nvs77b2QRZd0mB3S0znsXCYghOro65e00jQ=") {};
  ps-cabal-install = (fetchFromHackage "cabal-install" "3.10.3.0" "sha256-lcIRvK3snV2yXrc++2pS8BrdMc1Upyi72hOBREfXib0=") {Cabal-described = null; Cabal-QuickCheck = null; Cabal-tree-diff = null; cabal-install-solver = ps-cabal-install-solver;};
in
{
  cabal-audit = hfinal.callPackage ./cabal-audit.nix {};
  osv = hfinal.callPackage ./osv.nix {};
  hsec-core = hlib.doJailbreak (hfinal.callPackage ./hsec-core.nix {});
  hsec-tools = hlib.doJailbreak (hfinal.callPackage ./hsec-tools.nix {});
  cvss = hfinal.callPackage ./cvss.nix {};

  Cabal-syntax = hprev.Cabal-syntax_3_10_3_0;
  Cabal = hprev.Cabal_3_10_3_0;
  cabal-install = ps-cabal-install;
  cabal-install-solver = ps-cabal-install-solver;

  extensions = hprev.extensions_0_1_0_2.override {inherit (hfinal) Cabal;};

  ormolu = hlib.doJailbreak (hprev.ormolu.override {inherit (hfinal) Cabal-syntax;});
  fourmolu = hlib.doJailbreak (hprev.fourmolu.override {inherit (hfinal) Cabal-syntax;});

  toml-parser = hprev.toml-parser_2_0_1_0;
  sel = hlib.doJailbreak (hlib.markUnbroken hprev.sel);
  typst = hprev.typst_0_5_0_5;
  typst-symbols = hprev.typst-symbols_0_1_6;
  texmath = hprev.texmath_0_12_8_9;
}
