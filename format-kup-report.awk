function determineProjectFor(filePath) {
  projectNameStringStart=0
  projectNameStringStop=index(filePath, "?path=")
  for(textOffsetToCheck = projectNameStringStop - 1; textOffsetToCheck >=0; textOffsetToCheck--) {
    if (substr(filePath, textOffsetToCheck, 1) == "/") {
      projectNameStringStart = textOffsetToCheck
      break
    }
  }
  return substr(filePath, projectNameStringStart, (projectNameStringStop - projectNameStringStart))
}

function extensionOf(filePath) {
  elementsCount=split(filePath, filePathElements, ".")
  return filePathElements[elementsCount]
}

function isSourceCode(ext) {
  return ext=="java" || ext="html" || ext="htm" || ext="js" || ext="jsx" || ext="ts" || ext="tsx" || ext="less"
}

function isProperties(ext) {
  return ext=="yml" || ext=="yaml" || ext=="properties" || ext=="xml" || ext="conf" || ext="css" || ext="scss"
}

function isScript(ext) {
  return ext=="ps1" || ext=="gradle"
}

function isDevelopmentType(ext) {
  return isSourceCode(ext) || isProperties(ext) || isScript(ext)
}

function isAutomatedTestingType(ext) {
  return ext=="groovy"
}

function isDocumentationType(ext) {
  return ext=="md"
}

function determineTypeOf(filePath) {
  ext=extensionOf(filePath)
  if (isDevelopmentType(ext)) {
    return "programowanie"
  } else if (isAutomatedTestingType(ext)) {
    return "testy automatyczne"
  } else if (isDocumentationType(ext)) {
    return "dokumentacja projektowa"
  } else {
    return "programowanie"
  }
}

function determineKindOf(modificationType,filePath) {
  isNewFile=modificationType=="A"
  ext=extensionOf(filePath)
  if(isNewFile && isSourceCode(ext)) {
    return "Plik źródłowy z kodem nowego modułu aplikacji"
  } else if (isSourceCode(ext)) {
    return "Plik źródłowy z kodem usprawnienia zmieniającego działanie funkcji w aplikacji"
  } else if (isProperties(ext)) {
    return "Plik źródłowy zawierający zmienne i skrypty konfigurujące oprogramowanie"
  } else if (isScript(ext)) {
    return "Plik źródłowy zawierający skrypt wdrożeniowy"
  } else if (isAutomatedTestingType(ext)) {
    return "Plik źródłowy z kodem testu automatycznego"
  } else if (isDocumentationType(ext)) {
    return "Dokumentacja techniczna i specyfikacja"
  } else {
    return "Kody źródłowe programów komputerowych, aplikacji mobilnych, webowych"
  }
}

function extractFileNameFrom(filePath) {
  fileNameStringStart=index(filePath, "?path=") + 6
  return substr(filePath, fileNameStringStart, (length(filePath) - projectNameStringStart))
}

function shouldBeIncludedInKUP(modificationType, linesChanged) {
  return modificationType == "A" || linesChanged >= 6
}

BEGIN {}
{
  if (shouldBeIncludedInKUP($1, $3)) {
    printf "\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n", determineProjectFor($4), determineTypeOf($4), determineKindOf($1,$4), extractFileNameFrom($4), $2, $4
  }
}