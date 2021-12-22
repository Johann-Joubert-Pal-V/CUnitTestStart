@echo off
set PATH=%PATH%;C:\Program Files\Python39\python.exe
echo "PATH="
echo %PATH%
set COVFILE=.\test.cov
echo "COVFILE="
echo %COVFILE%


REM Automatically generated batch file to generate Microsoft Visual Studio compiler and project configurations for PC-lint Plus

REM Temporary filename for imposter log
SET "IMPOSTER_LOG=C:\Users\danje\AppData\Local\Temp\tmp6DF4.tmp"
REM Clear temporary file
BREAK > "%IMPOSTER_LOG%"
REM Activate Visual Studio developer tools environment
CALL "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x86
@echo on
REM Set path to cl.exe
FOR /F "tokens=* USEBACKQ" %%F IN (`where cl`) DO (SET "PCLP_CFG_CL_PATH=%%F" & GOTO AFTER_FIRST_CL)
:AFTER_FIRST_CL
REM Generate compiler configuration
REM CALL "C:\Program Files\Python39\python.exe" "C:\PC-Lint\windows\config\pclp_config.py" --compiler=vs2022_64 --compiler-bin="%PCLP_CFG_CL_PATH%" --config-output-lnt-file="co_vs2019_x64.lnt" --config-output-header-file="co_vs2019_x64.h" --generate-compiler-config
REM build imposter.c
REM cl "/FeC:\PC-Lint\windows\config\\" "C:\PC-Lint\windows\config\imposter.c"
REM generate project configuration
msbuild "C:\CUnit_zip\CUnitTestAppl2\CUnitTestAppl2.sln" /t:clean
SET IMPOSTER_MODULES_IN_WORKING_DIR=1
SET IMPOSTER_PATH_ARGUMENT_RELATIVE_TO_WORKING_DIR_OPTION_INTRODUCERS=/I;-I
SET "IMPOSTER_COMPILER=%PCLP_CFG_CL_PATH%"
REM Clear temporary file
BREAK > "%IMPOSTER_LOG%"
msbuild "C:\CUnit_zip\CUnitTestAppl2\CUnitTestAppl2.sln" /p:CLToolEXE=imposter.exe /p:CLToolPath="C:\PC-Lint\windows\config"
REM python "C:\PC-Lint\windows\config\pclp_config.py" --compiler=vs2019_64 --imposter-file="%IMPOSTER_LOG%" --config-output-lnt-file="pr_CUnitTestAppl2.lnt" --generate-project-config
REM done
REM pclp64 -os(analysis.log) co_vs2019_x64.lnt C:\PC-Lint\windows\lnt\env-jenkins.lnt pr_CUnitTestAppl2.lnt 

cov01 --on
msbuild "CUnitTestAppl2.sln" /t:rebuild /p:Configuration=Debug /p:Platform="x86" /m
".\Debug\CUnitTestAppl2.exe" xml out
cov01 --off
covselect --file "%COVFILE%" --add c:
C:\Git\BuildServer\BullsEyeTest\bullshtml\bullshtml.exe -f test.cov -e UTF_8 ./cov_html_output
