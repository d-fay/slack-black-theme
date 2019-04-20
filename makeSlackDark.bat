@echo off
for /f "tokens=*" %%f in ('dir %%LOCALAPPDATA%%\slack\app-3.* /b /s /o:D') do set slackDir=%%f
type static-css-injections.js >> %slackDir%\resources\app.asar.unpacked\src\static\index.js
type static-css-injections.js >> %slackDir%\resources\app.asar.unpacked\src\static\ssb-interop.js
