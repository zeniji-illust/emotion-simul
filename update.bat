@echo off
chcp 65001 >nul
echo ========================================
echo 의존성 업데이트
echo ========================================
echo.

REM 가상 환경 활성화 확인
if exist ".venv\Scripts\activate.bat" (
    echo 가상 환경 활성화 중...
    call .venv\Scripts\activate.bat
) else (
    echo 경고: 가상 환경을 찾을 수 없습니다.
    echo 가상 환경이 없다면 install.bat을 먼저 실행하세요.
    echo.
    pause
    exit /b 1
)

echo.
echo requirements.txt에서 패키지 확인 중...
echo.

REM pip 업그레이드
python -m pip install --upgrade pip

echo.
echo 새로운 의존성 설치 중...
echo.

REM requirements.txt의 패키지만 설치 (이미 설치된 것은 건너뜀)
python -m pip install -r requirements.txt

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo 의존성 업데이트 완료!
    echo ========================================
) else (
    echo.
    echo ========================================
    echo 오류: 의존성 설치 중 문제가 발생했습니다.
    echo ========================================
    pause
    exit /b 1
)

echo.
pause

