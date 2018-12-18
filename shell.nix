{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc862", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, hspec, lens, stdenv, text, trifecta }:
      mkDerivation {
        pname = "aoc2018";
        version = "0.1.0.0";
        src = ./.;
        libraryHaskellDepends = [ base text trifecta ];
        testHaskellDepends = [ base hspec text trifecta ];
        description = "advent of code 2018";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
