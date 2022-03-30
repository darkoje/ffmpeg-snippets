for %%f in ("*.mp3") do ffmpeg -i "%%f" -an -vcodec copy image.jpg -n


@echo off
call :treeProcess
goto :eof

:treeProcess
rem 
for %%f in ("*.mp3") do ffmpeg -r 1 -loop 1 -i image.jpg -i "%%f" -c:a copy -c:v libx264 -pix_fmt yuv420p -crf 0 -vf scale=1920:-2 -flags global_header -shortest "%%~nf.mp4"
for /D %%d in (*) do (
    cd %%d
    call :treeProcess
    cd ..
)
exit /b