function determineProjectFor(filePath) {
  projectNameStringStart=0
  projectNameStringStop=index(filePath, "?path=")
  for(textOffsetToCheck = projectNameStringStop - 1; textOffsetToCheck >=0; textOffsetToCheck--) {
    if (substr(filePath, textOffsetToCheck, 1) == "/") {
      projectNameStringStart = textOffsetToCheck + 1
      break
    }
  }
  return substr(filePath, projectNameStringStart, (projectNameStringStop - projectNameStringStart))
}

function extensionOf(filePath) {
  elementsCount=split(filePath, filePathElements, ".")
  return filePathElements[elementsCount]
}

function isSourceCode(filePath) {
  ext=extensionOf(filePath)
  return ext=="java" || ext="html" || ext="htm" || ext="js" || ext="jsx" || ext="ts" || ext="tsx" || ext="less"
}

function isProperties(filePath) {
  ext=extensionOf(filePath)
  return ext=="yml" || ext=="yaml" || ext=="properties" || ext=="xml" || ext="conf" || ext="css" || ext="scss"
}

function isScript(filePath) {
  ext=extensionOf(filePath)
  return ext=="ps1" || ext=="gradle"
}

function isDevelopmentType(filePath) {
  ext=extensionOf(filePath)
  return isSourceCode(filePath) || isProperties(filePath) || isScript(filePath)
}

function isAutomatedTestingType(filePath) {
  return isJavaTestType(filePath) || isJSTestType(filePath)
}

function isJavaTestType(filePath) {
  ext=extensionOf(filePath)
  isTestDirectory=index(filePath,"src/test") > 0
  return isTestDirectory && (ext=="groovy" || ext=="java")
}

function isJSTestType(filePath) {
  elementsCount=split(filePath, filePathElements, ".")
  return filePathElements[elementsCount-1]=="spec"
}

function isDocumentationType(filePath) {
  ext=extensionOf(filePath)
  return ext=="md"
}

function determineTypeOf(filePath) {
  ext=extensionOf(filePath)
  if (isAutomatedTestingType(filePath)) {
    return "testy automatyczne"
  } else if (isDevelopmentType(filePath)) {
    return "programowanie"
  } else if (isDocumentationType(filePath)) {
    return "dokumentacja projektowa"
  } else {
    return "programowanie"
  }
}

function determineKindOf(modificationType, filePath) {
  isNewFile=modificationType=="A"
  if(isNewFile && isSourceCode(filePath)) {
    return "Plik źródłowy z kodem nowego modułu aplikacji"
  } else if (isAutomatedTestingType(filePath)) {
    return "Plik źródłowy z kodem testu automatycznego"
  } else if (isSourceCode(filePath)) {
    return "Plik źródłowy z kodem usprawnienia zmieniającego działanie funkcji w aplikacji"
  } else if (isProperties(filePath)) {
    return "Plik źródłowy zawierający zmienne i skrypty konfigurujące oprogramowanie"
  } else if (isScript(filePath)) {
    return "Plik źródłowy zawierający skrypt wdrożeniowy"
  } else if (isDocumentationType(filePath)) {
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