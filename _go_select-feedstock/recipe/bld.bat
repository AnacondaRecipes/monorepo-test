setlocal enabledelayedexpansion

rem Copy the rendered [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
rem go finds its *.go files via the GOROOT variable
for %%F in (activate deactivate) do (
  if not exist "%PREFIX%\etc\conda\%%F.d" mkdir "%PREFIX%\etc\conda\%%F.d"
  if errorlevel 1 exit 1
  copy "%RECIPE_DIR%\%%F-go.bat" "%PREFIX%\etc\conda\%%F.d\%%F_z60-go.bat"
  if errorlevel 1 exit 1
)

call "%PREFIX%\etc\conda\activate.d\activate_z60-go.bat"
