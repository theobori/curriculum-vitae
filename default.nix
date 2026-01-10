{
  stdenvNoCC,
  texlive,
  gnumake,
}:
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

    gnumake
  ];

  buildPhase = ''
    runHook preBuild

    make

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    PREFIX=$out make install

    runHook postInstall
  '';
}
