@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo.
echo =========================================
echo  DEPLOY A GITHUB PAGES
echo =========================================
echo.

REM Get current date/time for commit message
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)

echo [1/4] Copiando /publish a /docs...
xcopy /E /I /Y "publish" "docs" >nul 2>&1
if errorlevel 1 (
    echo ❌ Error al copiar. Verifica que /publish existe.
    pause
    exit /b 1
)
echo ✅ Copiado

echo.
echo [2/4] Staging cambios...
git add docs >nul 2>&1
if errorlevel 1 (
    echo ❌ Error en git add.
    pause
    exit /b 1
)
echo ✅ Staged

echo.
echo [3/4] Commiteando...
git commit -m "Deploy: cambios en sitio público (%mydate% %mytime%)" >nul 2>&1
if errorlevel 1 (
    echo ⚠️  (sin cambios nuevos, saltando commit)
) else (
    echo ✅ Committed
)

echo.
echo [4/4] Pusheando a GitHub...
git push origin master >nul 2>&1
if errorlevel 1 (
    echo ❌ Error en git push. Verifica tu conexión.
    pause
    exit /b 1
)
echo ✅ Pusheado

echo.
echo =========================================
echo ✅ DEPLOY COMPLETADO
echo =========================================
echo.
echo Tu sitio se actualizó en:
echo https://tallerdjjuventudrgl.github.io/campus-dj-juventud/
echo.
echo (Se actualiza en ~1-2 minutos)
echo.
pause
