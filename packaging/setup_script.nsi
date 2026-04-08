Unicode true
RequestExecutionLevel admin
XPStyle on
SetCompress force
SetCompressor /FINAL /SOLID lzma
SetCompressorDictSize 64

!include "MUI2.nsh"
!include "x64.nsh"
!include "WinVer.nsh"

!define APP_AUTHOR "Henry++"
!define APP_WEBSITE "https://github.com/pgs666/memreduct"
!define COPYRIGHT "(c) 2011-2026 ${APP_AUTHOR}. All Rights Reversed."
!define LICENSE_FILE "${APP_FILES_DIR}\64\License.txt"

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Launch ${APP_NAME}"
!define MUI_FINISHPAGE_RUN_FUNCTION RunApplication
!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show release notes"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION ShowReleaseNotes
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED

Name "${APP_NAME}"
Caption "${APP_NAME} v${APP_VERSION}"
BrandingText "${COPYRIGHT}"

InstallDir "$PROGRAMFILES64\${APP_NAME}"
InstallDirRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "InstallLocation"

OutFile "${APP_NAME_SHORT}-${APP_VERSION}-setup.exe"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "${LICENSE_FILE}"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

VIAddVersionKey "Comments" "${APP_WEBSITE}"
VIAddVersionKey "CompanyName" "${APP_AUTHOR}"
VIAddVersionKey "FileDescription" "${APP_NAME}"
VIAddVersionKey "FileVersion" "${APP_VERSION}"
VIAddVersionKey "InternalName" "${APP_NAME_SHORT}"
VIAddVersionKey "LegalCopyright" "${COPYRIGHT}"
VIAddVersionKey "OriginalFilename" "${APP_NAME_SHORT}-${APP_VERSION}-setup.exe"
VIAddVersionKey "ProductName" "${APP_NAME}"
VIAddVersionKey "ProductVersion" "${APP_VERSION}"
VIProductVersion "${APP_VERSION}.0"

Function .onInit
  ${If} ${RunningX64}
    SetRegView 64
  ${EndIf}

  ${IfNot} ${AtLeastWin7}
    MessageBox MB_OK|MB_ICONEXCLAMATION "${APP_NAME} requires Windows 7 and later."
    Abort
  ${EndIf}
FunctionEnd

Section "Install"
  SectionIn RO

  SetOutPath "$INSTDIR"

  ${If} ${IsNativeARM64}
    File "${APP_FILES_DIR}\ARM64\${APP_NAME_SHORT}.exe"
  ${Else}
    File "${APP_FILES_DIR}\64\${APP_NAME_SHORT}.exe"
  ${EndIf}

  File /nonfatal "${APP_FILES_DIR}\64\${APP_NAME_SHORT}.lng"
  File /nonfatal "${APP_FILES_DIR}\64\History.txt"
  File /nonfatal "${APP_FILES_DIR}\64\Readme.txt"
  File /nonfatal "${APP_FILES_DIR}\64\License.txt"

  SetOutPath "$INSTDIR\i18n"
  File /r "${APP_FILES_DIR}\64\i18n\*.*"

  SetOutPath "$INSTDIR"
  WriteUninstaller "$INSTDIR\uninstall.exe"

  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortCut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${APP_NAME_SHORT}.exe"
  CreateShortCut "$SMPROGRAMS\${APP_NAME}\Readme.lnk" "$INSTDIR\Readme.txt"
  CreateShortCut "$SMPROGRAMS\${APP_NAME}\History.lnk" "$INSTDIR\History.txt"
  CreateShortCut "$SMPROGRAMS\${APP_NAME}\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_NAME_SHORT}.exe"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "Publisher" "${APP_AUTHOR}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "URLInfoAbout" "${APP_WEBSITE}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "DisplayIcon" "$INSTDIR\${APP_NAME_SHORT}.exe"
  WriteRegExpandStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "InstallLocation" "$INSTDIR"
  WriteRegExpandStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}" "NoRepair" 1
SectionEnd

Section "Uninstall"
  Delete "$DESKTOP\${APP_NAME}.lnk"
  RMDir /r "$SMPROGRAMS\${APP_NAME}"

  Delete "$INSTDIR\${APP_NAME_SHORT}.exe"
  Delete "$INSTDIR\${APP_NAME_SHORT}.lng"
  Delete "$INSTDIR\History.txt"
  Delete "$INSTDIR\Readme.txt"
  Delete "$INSTDIR\License.txt"
  Delete "$INSTDIR\uninstall.exe"
  RMDir /r "$INSTDIR\i18n"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME_SHORT}"
  RMDir "$INSTDIR"
SectionEnd

Function RunApplication
  ${If} ${FileExists} "$INSTDIR\${APP_NAME_SHORT}.exe"
    Exec '"$INSTDIR\${APP_NAME_SHORT}.exe"'
  ${EndIf}
FunctionEnd

Function ShowReleaseNotes
  ${If} ${FileExists} "$INSTDIR\History.txt"
    ExecShell "" '"$INSTDIR\History.txt"'
  ${EndIf}
FunctionEnd