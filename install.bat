@echo off
chcp 65001 >nul
ECHO ========================================
ECHO Zeniji Emotion Simul 설치 스크립트
ECHO ========================================
ECHO.

REM Python 설치 여부 확인
python --version >nul 2>&1
if errorlevel 1 (
    ECHO [오류] Python이 설치되어 있지 않습니다.
    ECHO.
    ECHO Python 3.11.x를 설치해주세요:
    ECHO https://www.python.org/downloads/
    ECHO.
    ECHO 설치 후 PATH 환경 변수에 Python이 추가되었는지 확인하세요.
    ECHO.
    pause
    exit /b 1
)

REM Python 버전 확인
ECHO Python 버전 확인 중...
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
ECHO 현재 Python 버전: %PYTHON_VERSION%

REM 버전 문자열에서 3.11 확인
echo %PYTHON_VERSION% | findstr /R "^3\.11\." >nul
if errorlevel 1 (
    ECHO.
    ECHO [오류] Python 3.11.x가 필요합니다.
    ECHO 현재 버전: %PYTHON_VERSION%
    ECHO.
    ECHO ========================================
    ECHO 해결 방법:
    ECHO ========================================
    ECHO 1. Python 3.11.x를 다운로드하세요:
    ECHO    https://www.python.org/downloads/release/python-3110/
    ECHO.
    ECHO 2. 설치 시 "Add Python to PATH" 옵션을 체크하세요.
    ECHO.
    ECHO 3. 설치 후 이 배치 파일을 다시 실행하세요.
    ECHO ========================================
    ECHO.
    pause
    exit /b 1
)

ECHO [확인] Python 3.11.x가 설치되어 있습니다.
ECHO.

REM 가상환경이 이미 존재하는지 확인
if exist ".venv" (
    ECHO [경고] .venv 폴더가 이미 존재합니다.
    ECHO 기존 가상환경을 삭제하고 새로 만들까요? (Y/N)
    set /p RECREATE_VENV=
    if /i "%RECREATE_VENV%"=="Y" (
        ECHO 기존 가상환경 삭제 중...
        rmdir /s /q .venv
        ECHO.
    ) else (
        ECHO 기존 가상환경을 유지합니다.
        ECHO.
    )
)

REM 가상환경 생성
if not exist ".venv" (
    ECHO [1/3] 가상환경 생성 중...
    python -m venv .venv
    if errorlevel 1 (
        ECHO [오류] 가상환경 생성에 실패했습니다.
        pause
        exit /b 1
    )
    ECHO [완료] 가상환경이 생성되었습니다.
    ECHO.
) else (
    ECHO [1/3] 기존 가상환경 사용
    ECHO.
)

REM 가상환경 활성화 및 pip 업그레이드
ECHO [2/3] pip 업그레이드 중...
.venv\Scripts\python.exe -m pip install --upgrade pip >nul 2>&1
if errorlevel 1 (
    ECHO [경고] pip 업그레이드에 실패했습니다. 계속 진행합니다...
) else (
    ECHO [완료] pip 업그레이드 완료
)
ECHO.

REM requirements.txt 확인
if not exist "requirements.txt" (
    ECHO [오류] requirements.txt 파일을 찾을 수 없습니다.
    pause
    exit /b 1
)

REM 의존성 설치
ECHO [3/3] 의존성 설치 중...
ECHO 이 작업은 몇 분이 걸릴 수 있습니다...
ECHO.
.venv\Scripts\pip.exe install -r requirements.txt
if errorlevel 1 (
    ECHO.
    ECHO [오류] 의존성 설치에 실패했습니다.
    pause
    exit /b 1
)

ECHO.
ECHO ========================================
ECHO 설치가 완료되었습니다!
ECHO ========================================
ECHO.
ECHO 다음 단계:
ECHO 1. start.bat를 실행하여 애플리케이션을 시작하세요.
ECHO 2. 또는 수동으로:
ECHO    - zeniji_ollama_serve.bat 실행 (Ollama 서버)
ECHO    - .venv\Scripts\activate
ECHO    - python app.py
ECHO.
ECHO ========================================
ECHO.
pause

