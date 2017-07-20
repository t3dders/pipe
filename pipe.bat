@echo off
cls
set mywork=d:\ANSYS\pipe
set mysorc=%mywork%\src

REM clear previous results
del /s /q "%mywork%\cfx\*.*"
del /s /q "%mywork%\mech\*.*"

cd "%mywork%\fluent\"
set /a cnt=0
for /d %%A in (*) do set /a cnt+=1
set /a cnt+=1
md %cnt%

echo All set up! Begin meshing...
"%ANSYS150_DIR%\bin\%ANSYS_SYSDIR%\ansys150.exe" -b -dir "%mywork%\mech\" -i "%mysorc%\pipe2.mac" -o "%mywork%\mech\pipe2.out" | rem
echo Done meshing! Begin CFX import...
"%ANSYS150_DIR%\..\cfx\bin\cfx5pre.exe" -batch "%mysorc%\pipe.pre" | rem
echo Done importing! Moving on to Fluent...
"%ANSYS150_DIR%\..\fluent\ntbin\win64\fluent.exe" 3d -tx 10 -i "%mysorc%\pipe.jou" | rem
echo Ready to go. 
set /p id="Press any key to exit..."