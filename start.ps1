Stop-Process -Name "arma3server" -ErrorAction SilentlyContinue

Set-Location -Path C:\Users\Administrador\Desktop\server\POPJunior.Jackson_County
$cmdOutput = git pull
if ($cmdOutput -ne "Already up to date.") {
    echo "Updating..."
    Set-Location -Path ..

    New-Item -ItemType Directory -Force -Path tmp
    Set-Location -Path tmp
    Copy-Item -Path ..\POPJunior.Jackson_County -Destination .\POPJunior.Jackson_County -Recurse
    Move-Item -Path .\POPJunior.Jackson_County\est_server -Destination .

    (get-content .\POPJunior.Jackson_County\description.ext | select-string -pattern 'allowFunctionsRecompile = 1;' -notmatch) | Set-Content .\POPJunior.Jackson_County\description.ext
    (get-content .\POPJunior.Jackson_County\description.ext | select-string -pattern '    #include \"est_server\\FuncionesDev.h\"' -notmatch) | Set-Content .\POPJunior.Jackson_County\description.ext
    Remove-Item -Path .\POPJunior.Jackson_County\.git -Recurse -Force
    Remove-Item -Path .\POPJunior.Jackson_County\.github -Recurse -Force
    # lo que tenemos lo vamos a convertir en .pbo

    & 'C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe' -pack .\POPJunior.Jackson_County .\POPJunior.Jackson_County.pbo
    & 'C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe' -pack .\est_server .\est_server.pbo

    Remove-Item -Path 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\mpmissions\POPJunior.Jackson_County.pbo'
    Remove-Item -Path 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\@est_server\addons\est_server.pbo'

    Move-Item -Path .\est_server.pbo -Destination 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\@est_server\addons\est_server.pbo'
    Move-Item -Path .\POPJunior.Jackson_County.pbo -Destination 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\mpmissions\POPJunior.Jackson_County.pbo'

    Set-Location -Path ..

    Remove-Item -Path .\tmp -Recurse -Force
}

& 'C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\arma3server.exe' -port=2302  "-bepath=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\Battleye" "-config=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\TADST\default\TADST_config.cfg" "-cfg=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\TADST\default\TADST_basic.cfg" "-profiles=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\TADST\default" -name=default  "-mod=@est_server;@extDB3;@POPJunior;@infiSTAR_A3;@infiSTAR_A3_vision" -autoInit -enableHT -hugePages