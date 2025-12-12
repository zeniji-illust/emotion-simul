@echo off
ECHO ========================================
ECHO Zeniji Emotion Simul 시작 중...
ECHO ========================================
ECHO.

REM Ollama 서버를 새 창에서 실행
ECHO [1/2] Ollama 서버 시작 중...
start "Zeniji Ollama Server" zeniji_ollama_serve.bat

REM 잠시 대기 (Ollama 서버가 시작될 시간 확보)
timeout /t 3 /nobreak >nul

REM Python 앱을 새 창에서 실행
ECHO [2/2] Python 앱 시작 중...
start "Zeniji Emotion Simul" cmd /k ".venv\Scripts\activate && python app.py"

ECHO.
ECHO ========================================
ECHO 두 개의 창이 열렸습니다:
ECHO - Ollama 서버 창
ECHO - Zeniji Emotion Simul 창
ECHO ========================================
ECHO.
ECHO 이 창은 닫아도 됩니다.

timeout /t 2 /nobreak >nul
exit

