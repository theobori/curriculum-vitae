{
  lib,
  stdenvNoCC,
  texlive,
}:
let
  inherit (lib.strings) intersperse concatStrings;

  langs' = [
    "fr"
    "en"
  ];

  langs = concatStrings (intersperse " " langs');
in
stdenvNoCC.mkDerivation {
  pname = "curriculum-vitae";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = [
    (texlive.combine {
      inherit (texlive)
        scheme-medium
        fourier
        lastpage
        etaremune
        datetime2
        ;
    })
  ];

  buildPhase = ''
    runHook preBuild

    for lang in ${langs}; do
      cd $lang
      pdflatex theobori_cv_$lang.tex
      cd -
    done

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    for lang in ${langs}; do
      mv $lang/theobori_cv_$lang.pdf $out
    done

    runHook postInstall
  '';
}
