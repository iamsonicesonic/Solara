@echo off
REM Disable command echo for cleaner output.

:executor
REM This function computes the LCM of three numbers, uses them as coefficients in a polynomial, 
REM and evaluates the polynomial for a given x.

setlocal enabledelayedexpansion
REM Enable delayed variable expansion for handling variables within loops.

REM Prompt the user to enter three numbers separated by spaces.
echo Enter three numbers separated by spaces:
set /p input=

REM Parse the input and assign to variables a, b, and c.
for /f "tokens=1,2,3" %%a in ("!input!") do (
    set a=%%a
    set b=%%b
    set c=%%c
)

REM Prompt the user to enter a value for x.
echo Enter a value for x:
set /p x=

:GCD
REM This function computes the Greatest Common Divisor (GCD).
setlocal
set num1=%1
set num2=%2

:WHILE
if %num2%==0 (
    endlocal & set GCDResult=%num1%
    goto :EOF
)
set /a "temp=num1 %% num2"
set /a "num1=num2"
set /a "num2=temp"
goto :WHILE

:LCM
REM This function computes the Least Common Multiple (LCM).
setlocal
set num1=%1
set num2=%2
call :GCD %num1% %num2%
set /a lcm=(num1*num2)/GCDResult
endlocal & set LCMResult=%lcm%
goto :EOF

call :LCM %a% %b%
set lcm_ab=%LCMResult%

call :LCM %lcm_ab% %c%
set lcm_abc=%LCMResult%

REM Compute and display the polynomial value.
set /a polynomial=lcm_abc*x*x + lcm_abc*x + lcm_abc

echo Polynomial: %lcm_abc%x^2 + %lcm_abc%x + %lcm_abc%
echo Value of the polynomial at x=%x% is: %polynomial%

exit /b
