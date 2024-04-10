:: De aqui para abajo para descargar lo nuevo y borrar las lineas de description

cd POPJunior.Jackson_County
git pull
cd ..

mkdir tmp
cd tmp
mkdir POPJunior.Jackson_County
xcopy ..\POPJunior.Jackson_County .\POPJunior.Jackson_County /E
move .\POPJunior.Jackson_County\est_server .


findstr /v /i /L /c:"est_server\FuncionesDev.h" .\POPJunior.Jackson_County\description.ext > .\POPJunior.Jackson_County\description2.ext
findstr /v /i /L /c:"allowFunctionsRecompile" .\POPJunior.Jackson_County\description2.ext > .\POPJunior.Jackson_County\description.ext
del .\POPJunior.Jackson_County\description2.ext

:: lo que tenemos lo vamos a convertir en .pbo

C:\"Program Files"\"PBO Manager v.1.4 beta"\PBOConsole.exe -pack .\POPJunior.Jackson_County .\POPJunior.Jackson_County.pbo
C:\"Program Files"\"PBO Manager v.1.4 beta"\PBOConsole.exe -pack .\est_server .\est_server.pbo

del C:\"Program Files (x86)"\Steam\steamapps\common\"Arma 3 Server"\mpmissions\POPJunior.Jackson_County.pbo
del C:\"Program Files (x86)"\Steam\steamapps\common\"Arma 3 Server"\@est_server\addons\est_server.pbo

move .\est_server.pbo C:\"Program Files (x86)"\Steam\steamapps\common\"Arma 3 Server"\@est_server\addons\est_server.pbo
move .\POPJunior.Jackson_County.pbo C:\"Program Files (x86)"\Steam\steamapps\common\"Arma 3 Server"\mpmissions\POPJunior.Jackson_County.pbo

cd ..

rmdir .\tmp /s /q 

"C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\arma3server_x64.exe" "-bepath=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\Battleye" -port=2302 "-config=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\TADST\default\TADST_config.cfg" "-cfg=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\TADST\default\TADST_basic.cfg" "-profiles=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Server\TADST\default" -name=default "-mod=@est_server;@extDB3;@PoPJunior" -autoInit
