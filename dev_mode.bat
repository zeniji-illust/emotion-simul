@echo off
ECHO ========================================
ECHO Zeniji Emotion Simul (Dev Mode) 시작 중...
ECHO ========================================
ECHO.

REM Ollama 서버를 새 창에서 실행
ECHO [1/2] Ollama 서버 시작 중...
start "Zeniji Ollama Server" zeniji_ollama_serve.bat

REM 잠시 대기 (Ollama 서버가 시작될 시간 확보)
timeout /t 3 /nobreak >nul

REM Python 앱을 새 창에서 실행 (dev-mode 플래그 포함)
ECHO [2/2] Python 앱 시작 중 (Dev Mode)...
start "Zeniji Emotion Simul (Dev Mode)" cmd /k ".venv\Scripts\activate && python app.py --dev-mode"

ECHO.
ECHO ========================================
ECHO 두 개의 창이 열렸습니다:
ECHO - Ollama 서버 창
ECHO - Zeniji Emotion Simul 창 (Dev Mode)
ECHO.
ECHO Dev Mode에서는 상세한 프롬프트와 응답 로그가 출력됩니다.
ECHO ========================================
ECHO.
ECHO 이 창은 닫아도 됩니다.

timeout /t 2 /nobreak >nul
exit

