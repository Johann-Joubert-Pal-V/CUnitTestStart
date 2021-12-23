REM Automatically generated batch file to generate Microsoft Visual Studio compiler and project configurations for PC-lint Plus

REM Temporary filename for imposter log
SET "IMPOSTER_LOG=C:\Users\Johann428\AppData\Local\Temp\tmpE7A5.tmp"
REM Clear temporary file
BREAK > "%IMPOSTER_LOG%"
REM Activate Visual Studio developer tools environment
CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64
@echo on
REM Set path to cl.exe
FOR /F "tokens=* USEBACKQ" %%F IN (`where cl`) DO (SET "PCLP_CFG_CL_PATH=%%F" & GOTO AFTER_FIRST_CL)
:AFTER_FIRST_CL
REM Generate compiler configuration
python "C:\PC-Lint\windows\config\pclp_config.py" --compiler=vs2019_64 --compiler-bin="%PCLP_CFG_CL_PATH%" --config-output-lnt-file="C:\Git\BuildServer\CUnitTestStart\co_vs2019_x64.lnt" --config-output-header-file="C:\Git\BuildServer\CUnitTestStart\co_vs2019_x64.h" --generate-compiler-config
REM build imposter.c
cl "/FeC:\PC-Lint\windows\config\\" "C:\PC-Lint\windows\config\imposter.c"
REM generate project configuration
msbuild "C:\Git\BuildServer\CUnitTestStart\CUnitTestAppl2.sln" /t:clean
SET IMPOSTER_MODULES_IN_WORKING_DIR=1
SET IMPOSTER_PATH_ARGUMENT_RELATIVE_TO_WORKING_DIR_OPTION_INTRODUCERS=/I;-I
SET "IMPOSTER_COMPILER=%PCLP_CFG_CL_PATH%"
REM Clear temporary file
BREAK > "%IMPOSTER_LOG%"
msbuild "C:\Git\BuildServer\CUnitTestStart\CUnitTestAppl2.sln" /p:CLToolEXE=imposter.exe /p:CLToolPath="C:\PC-Lint\windows\config"
python "C:\PC-Lint\windows\config\pclp_config.py" --compiler=vs2019_64 --imposter-file="%IMPOSTER_LOG%" --config-output-lnt-file="C:\Git\BuildServer\CUnitTestStart\pr_CUnitTestAppl2.lnt" --generate-project-config
REM done

