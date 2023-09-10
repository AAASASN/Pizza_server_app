



## Серверное приложение [Pizza_server_app](https://github.com/AAASASN/Pizza_server_app)



*Серверное приложение написано на языке Swift с использованием фреймверков Vapor, Fluent и базы данных PostgreSQL. Представляет из себя API, позволяет получать три вида данных - перечень продуктов (meal), категории продуктов (categoty) и акционные банеры (banner). Отвечает на запросы типа GET, POST, PUT и DELETE. Мобильное приложение работающее с данным API находится по ссылке - [*здесь будет ссылка*] и представляет из себя клон приложения Додо Пиццы.*



### Оглавление

1. [Описаниe API](#Описаниe-API)

2. [Развертывание на Mac локально](#Развертывание-на-Mac-локально)

3. [Развертывание на VPS/VDS](#Развертывание-на-VPS/VDS)
   - [Создание виртуальной машины и подключение](#Создание-виртуальной-машины-и-подключение)
   
   - [Первичные настройки](#Первичные-настройки)
   
   - [Установка Swift](#Установка-Swift)
   
   - [Установка Vapor](#Установка-Vapor)
   
   - [Создание тестового проекта HelloWorld](#Создание-тестового-проекта-HelloWorld)
   
   - [Создание проекта Pizza_server_app](#Создание-проекта-Pizza_server_app)
   - [Tmux](#Tmux)
   - [Демонизация приложения](#Демонизация-приложения)
   
4. [Развертывание с использованием Docker](#Развертывание-с-использованием-Docker)

5. [Ссылки](#Ссылки)





## Описаниe API 

[Наверх](#Оглавление)

Отвечает на запосамиы типа GET, POST, PUT, DELETE, возвращает данные в виде JSON:

по запросу на http://XXX.XXX.XXX.XXX/api/meals

``` [
[
      {
        "id": 1,
        "name": "Пицца Миксик + набор юного садовода",
        "description": "Пицца четвертинками с ветчиной, цыпленком, томатами, брынзой, моцареллой, фирменным соусом альфредо",
        "priceFrom": 495,
        "categoryId": 1,
        "categoryName": "Пицца",
        "image": "https://github.com/AAASASN/Test_Task_3_db/blob/main/Images/Pizza/Picca-Miksik-nabor-yunogo-sadovoda/c91bba331b664442a00e1f3e795a7807_584x584.jpg?raw=true"
      },
      {
        "id": 2,
        "name": "Пицца из половинок",
        "description": "Соберите свою пиццу 35 см с двумя разными вкусами",
        "priceFrom": 670,
        "categoryId": 1,
        "categoryName": "Пицца",
        "image": "https://github.com/AAASASN/Test_Task_3_db/blob/main/Images/Pizza/Picca-iz-polovinok/3eb52fd02f0348df913beb28f77d766e_584x584.jpg?raw=true"
      }
]
```

  

по запросу на http://XXX.XXX.XXX.XXX/api/banners

```
[
    {
        "image": "https://github.com/m-niyazov/db-hammer-systems-pizza/blob/main/banners/banner-3.jpeg?raw=true",
        "appId": 3,
        "id": "0CA4638F-168D-4BDF-BF88-86F54B9E09A2"
    },
    {
        "image": "https://github.com/m-niyazov/db-hammer-systems-pizza/blob/main/banners/banner-1.jpeg?raw=true",
        "appId": 1,
        "id": "704AEA7F-675D-44BE-B333-A45A90CE02BE"
    },
    {
        "image": "https://github.com/m-niyazov/db-hammer-systems-pizza/blob/main/banners/banner-2.jpeg?raw=true",
        "appId": 2,
        "id": "B739E7CB-7B30-435A-8626-359AD8A32E3C"
    }
]
```



по запросу на http://XXX.XXX.XXX.XXX/api/banners

```
[
    {
        "appId": 1,
        "name": "Пицца",
        "id": "E7B7C692-69C5-4703-A0CB-EAC0FCDE92FC"
    },
    {
        "appId": 2,
        "name": "Комбо",
        "id": "51AE94E9-C781-4191-B83D-3891B4261F39"
    },
    {
        "appId": 3,
        "name": "Закуски",
        "id": "0B9DE7E3-3F1A-4FA6-9F53-16A2C0F76502"
    },
    {
        "appId": 4,
        "name": "Десерты",
        "id": "C8F68A28-3CB3-49B4-9AA9-B650AD59115A"
    },
    {
        "appId": 5,
        "name": "Напитки",
        "id": "808213E2-AC1D-433E-A571-CC03A2F529B6"
    },
    {
        "appId": 6,
        "name": "Другие товары",
        "id": "7C4AB7F5-1861-4D95-AADA-BB0137B2A9F5"
    }
]
```









## Развертывание на Mac локально

[Наверх](#Оглавление)



*здесь будет описание утановки Vapor на локальный Mac*



```




```









## Развертывание на VPS/VDS



### Создание виртуальной машины и подключение 

[Наверх](#Оглавление)



Для создания VM я воспользовался сервисом [Yandex Cloud](https://cloud.yandex.ru), в качестве орерационной системы выбрал Ubuntu 22.04 . Для подключения к VM используется протокол SSH, он основан на использовании пары ключей: открытый ключ размещается на VM, а закрытый ключ хранится у пользователя. Для создания ключей нужно дать команду в терминале:

```
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa
```

Будет предложено ввести пароль, затем в директории ~/.ssh будет созданы файлики вида `id_rsa.pub`  и `id_rs ` . Если файликов в папке  ~/.ssh не оказалось следует поискать их в корневой директории текущуго пользователя и переместить их в  ~/.ssh. Октрытый ключ должен храниться на ВМ и сообщается ей при ее создании, а закрытый `id_rsa`  всегда должен храниться в директории ~/.ssh.

Открываем любым текстовым редактором файлик с публичным ключем  `id_rsa.pub` ,  копируем из него весь текст - он имеет вид -  `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK7roNnfzL+gRPCz`. Открытый ключ вставляем в соответствующее поле в панели управления при создании VM.

Подключаемся через терминал командой типа `ssh asm@51.250.111.32`  где asm это имя пользователя, 51.250.111.32  адрес назначеный VM при создании. Водим пароль указаный при создании  ssh-ключа.

```
ssh asm@51.250.111.32
```

*ip: 51.250.111.32 - приведен для примера*





### Первичные настройки

[Наверх](#Оглавление)



Далее все команды вводим с указанием прав суперпользователя `sudo` .

Конфигурация Firewall.

```
sudo ufw allow OpenSSH
```

```
sudo ufw enable
```

 Создаем отдельного пользователя, как пример - vapor.

```
sudo adduser vapor
```

Наделяем пользователя `vapor` правами суперпользователя.

```
sudo usermod -aG sudo vapor
```

Копируем авторизованные ключи SSH пользователя root только что созданному пользователю. Это позволит войти в SSH в качестве нового пользователя.

```
sudo rsync --archive --chown=vapor:vapor ~/.ssh /home/vapor
```

Перезаходим под пользователем `vapor` .

```
exit
ssh vapor@51.250.111.32
```



### Установка Swift

[Наверх](#Оглавление)

Установка необходимых зависимостей.

```
sudo apt-get update
```

```
sudo apt-get install binutils git gnupg2 libc6-dev libcurl4-openssl-dev 
     \ libedit2 libgcc-9-dev libpython3.8 libsqlite3-0 libstdc++-9-dev 
     \ libxml2-dev libz3-dev pkg-config tzdata unzip zlib1g-dev
```

```
sudo apt-get install \
          binutils \
          git \
          gnupg2 \
          libc6-dev \
          libcurl4 \
          libedit2 \
          libgcc-9-dev \
          libpython2.7 \
          libsqlite3-0 \
          libstdc++-9-dev \
          libxml2 \
          libz3-dev \
          pkg-config \
          tzdata \
          zlib1g-dev
```

Загрузка и установка Swift Toolchain. Для этого нужно дать команду `wget` и указать ссылку для загрузки пакета Swift. Ссылку на пакет берем с официального сайта swift.org - https://www.swift.org/download/#releases. Копируем ту которая соответствует некоторым условиям, в моем случае это   Swift 5.8,  OS - Ubuntu 22.04 и архетиктура железа   `x86_64` .

```
sudo wget https://download.swift.org/swift-5.8-release/ubuntu2204/swift-5.8-RELEASE/swift-5.8-RELEASE-ubuntu22.04.tar.gz
```

 В корневую директорию пользователя `vapor`  загружается архив порядка 544Mb.

```
vapor@asm:~$ ls -l
total 531392
-rw-r--r-- 1 root root 544139004 Mar 30 23:16 swift-5.8-RELEASE-ubuntu22.04.tar.gz
vapor@asm:~$ 
```

Распаковываем его при помощи встроенного в операционную систему инструмента `tar` .

```
tar xzf swift-5.8-RELEASE-ubuntu22.04.tar.gz
```

Распаковка может занять некоторое время, ждем, проверяем.

```
vapor@asm:~$ ls -l
total 531396
drwxrwxr-x 3 vapor vapor      4096 May  2 12:58 swift-5.8-RELEASE-ubuntu22.04
-rw-r--r-- 1 root  root  544139004 Mar 30 23:16 swift-5.8-RELEASE-ubuntu22.04.tar.gz
vapor@asm:~$ 
```

Архив можно удалить,если на VM мало места.

```
sudo rm -r swift-5.8-RELEASE-ubuntu22.04.tar.gz
```

Далее при помощи команды `sudo mkdir /swift` создаем папку swift  в системной директории.

```
sudo mkdir /swift
```

Для инсталяции ` Swift 5.8 ` нужно находясь в директории `/home/vapor` выполнить команду

```
sudo mv swift-5.8-RELEASE-ubuntu22.04 /swift/5.8
```

Команда перемещает из директории  `/home/vapor/swift-5.8-RELEASE-ubuntu22.04 ` содержимое папки  `swift-5.8-RELEASE-ubuntu22.04`  в системную папку   `/swift`  одновременно создав в ней подпапку   ` 5.8 ` , а  пустая папка ` swift-5.8-RELEASE-ubuntu22.04 `  удаляется.



Далее выполняем команду.

```
sudo ln -s /swift/5.8/usr/bin/swift /usr/bin/swift
```

Она создает в системной папке ` /bin ` ссылку на файл ` swift ` находящийся в папке с приложением Swift 5.8 - ` /swift/5.8/usr/bin/swift ` таким образом команды `Swift 5.8` можно будет запускать из любой директории используя ключевое слово ` swift ` .  Ссылка выглядит так: 

```bash
lrwxrwxrwx 1 root root          24 May  2 14:01  swift -> /swift/5.8/usr/bin/swift
```

Если ссылка создалась корректно можно дать комманду ` swift --version ` из любой директории и она должна дать ответ

```bash
vapor@asm:~$ swift --version
<unknown>:0: warning: glibc not found for 'x86_64-unknown-linux-gnu'; C stdlib may be unavailable
Swift version 5.8 (swift-5.8-RELEASE)
Target: x86_64-unknown-linux-gnu
vapor@asm:~$ 
```





### Установка Vapor

[Наверх](#Оглавление)

Находясь в корневой папке пользователя клонируем Vapor Toolbox.

```
git clone https://github.com/vapor/toolbox.git
```

далее

```
cd toolbox
git checkout 18.6.0
```

Билдим Vapor.

```
swift build -c release --disable-sandbox --enable-test-discovery
```

Затем перемещаем бинарник в папку ` /usr/local/bin `.

```bash
sudo mv .build/release/vapor /usr/local/bin
```





### Создание тестового проекта HelloWorld

[Наверх](#Оглавление)

Для демонстрации работы Vapor создаем новый проект HelloWorld.

``` 
vapor new HelloWorld
```

При этом добавив ` -n ` в ` vapor new HelloWorld -n `  мы отказываемся от включения в проект фреймверков Fluent (работает с базами данных,) Leaf (язык шаблонов в стиле языка swift для создания HTML-страниц)  и преднастроек для работы с базами данных.

Для текущей версии стандартного шаблона HelloWorld необходимо дополнительно подключить библиотеку Fluent и выбрать базу данных SQLite.

```bash
vapor@asm:~/toolbox$ vapor new HelloWorld
Cloning template...
name: HelloWorld
Would you like to use Fluent? (--fluent/--no-fluent)
y/n> y
fluent: Yes
db: SQLite
Would you like to use Leaf? (--leaf/--no-leaf)
y/n> n
leaf: No
Generating project files
+ Package.swift
+ entrypoint.swift
+ configure.swift
+ routes.swift
+ Todo.swift
+ CreateTodo.swift
+ .gitkeep
+ TodoController.swift
+ AppTests.swift
+ .gitkeep
+ Dockerfile
+ docker-compose.yml
+ .gitignore
+ .dockerignore
Creating git repository
Adding first commit
                                                                                                       
                                                                                      **               
                                                                                    **~~**             
                                                                                  **~~~~~~**           
                                                                                **~~~~~~~~~~**         
                                                                              **~~~~~~~~~~~~~~**       
                                                                            **~~~~~~~~~~~~~~~~~~**     
                                                                          **~~~~~~~~~~~~~~~~~~~~~~**   
                                                                         **~~~~~~~~~~~~~~~~~~~~~~~~**  
                                                                        **~~~~~~~~~~~~~~~~~~~~~~~~~~** 
                                                                       **~~~~~~~~~~~~~~~~~~~~~~~~~~~~**
                                                                       **~~~~~~~~~~~~~~~~~~~~~~~~~~~~**
                                                                       **~~~~~~~~~~~~~~~~~~~~~++++~~~**
                                                                        **~~~~~~~~~~~~~~~~~~~++++~~~** 
                                                                         ***~~~~~~~~~~~~~~~++++~~~***  
                                                                           ****~~~~~~~~~~++++~~****    
                                                                              *****~~~~~~~~~*****      
                                                                                 *************         
                                                                                                       
                                                                        _       __    ___   ___   ___  
                                                                       \ \  /  / /\  | |_) / / \ | |_) 
                                                                        \_\/  /_/--\ |_|   \_\_/ |_| \ 
                                                                          a web framework for Swift    
                                                                                                       
                                                                     Project HelloWorld has been created!
                                                                                       
                                                              Use cd 'HelloWorld' to enter the project directory
                                     Then open your project, for example if using Xcode type open Package.swift or code . if using VSCode
vapor@asm:~/toolbox$ 
```

Переходим в папку с новым проектом.

```bash
cd HelloWorld
```

Открываем порт 8080.

```bash
sudo ufw allow 8080
```

Запускаем приложение, в качестве hostname указываем 0.0.0.0 .

```
swift run App serve --hostname 0.0.0.0 --port 8080
```

Swift подгрузит все необходимые зависимости, сблидит прект и запустит его. Если все пройдет успешно на в терминале отобразится как минииум:

```
vapor@asm:~/toolbox/HelloWorld$ swift run App serve --hostname 0.0.0.0 --port 8080
Building for debugging...
Build complete! (0.25s)
[ NOTICE ] Server starting on http://0.0.0.0:8080
```

Проверить работтоспособность можно сделав запрос в терминале локальной машины или  через браузер по ссылке  `http://62.84.126.38:8080 ` - используем `http`, а не `https`.

```
alexander@MacBook-Air-Aleksandr ~ % curl http://62.84.126.38:8080   
It works!%                                                                     
alexander@MacBook-Air-Aleksandr ~ % 
```

Для удаления проекта HelloWorld достаточно удалить папку HelloWorld в директории ` toolbox ` .

```
sudo rm -r HelloWorld
```





### Создание проекта Pizza_server_app

[Наверх](#Оглавление)

Переходим в директорию ` /home/vapor/toolbox ` и клонируем текущий проект.

```
git clone https://github.com/AAASASN/Pizza_server_app.git
```

Появляется репозиторий ` Pizza_server_app `.

```
vapor@asm:~/toolbox$ ls -l
total 40
-rw-rw-r-- 1 vapor vapor  438 May  2 21:33 Dockerfile
-rw-rw-r-- 1 vapor vapor 1079 May  2 21:32 LICENSE.txt
-rw-rw-r-- 1 vapor vapor  479 May  2 21:32 Makefile
-rw-rw-r-- 1 vapor vapor 1941 May  2 21:34 Package.resolved
-rw-rw-r-- 1 vapor vapor 1130 May  2 21:33 Package.swift
-rw-rw-r-- 1 vapor vapor  940 May  2 21:32 README.md
drwxrwxr-x 2 vapor vapor 4096 May  2 21:32 scripts
drwxrwxr-x 4 vapor vapor 4096 May  2 21:32 Sources
drwxrwxr-x 3 vapor vapor 4096 May  2 21:32 Tests
drwxrwxr-x 6 vapor vapor 4096 May  2 22:22 Pizza_server_app
vapor@asm:~/toolbox$ 
```

В проекте  ` Pizza_server_app ` используется база данных ` PostgreSQL ` Перед тем как собрать и запустить проект необходимо установить и запустить Docker, создать контейнер и запустить в неи базу данных PostgreSQL.

Установка Docker.

```
sudo apt  install docker.io
```

Запуск базы данных PostgreSQL с параметрами .

```
sudo docker run --name restaurant \
	-e POSTGRES_DB=rest_database\
	-e POSTGRES_USER=rest_username\
	-e POSTGRES_PASSWORD=rest_password\
	-p 5432:5432 -d postgres
```

Если все прошло успешно отобразится что то типа:

```sh
vapor@asm:~/toolbox$ sudo docker run --name restaurant \
        -e POSTGRES_DB=rest_database\
        -e POSTGRES_USER=rest_username\
        -e POSTGRES_PASSWORD=rest_password\
        -p 5432:5432 -d postgres
Unable to find image 'postgres:latest' locally
latest: Pulling from library/postgres
9e3ea8720c6d: Pull complete 
7782b3e1be4b: Pull complete 
247ec4ff783a: Pull complete 
f7ead6900700: Pull complete 
e7afdbe9a191: Pull complete 
3ef71fe7cece: Pull complete 
1459ebb56be5: Pull complete 
3595124f6861: Pull complete 
dd8e229a2a13: Pull complete 
8cf43a35dc10: Pull complete 
2fac9b4aab2f: Pull complete 
b3f90da87261: Pull complete 
5f7e3ef14a3b: Pull complete 
Digest: sha256:482e881c53826bd27044a88cafa86305958142472cfe49e0facc6671eaa2fbf5
Status: Downloaded newer image for postgres:latest
8837363a7a4e3fa08147e3b7ecfd6dae1ecc4c3230ec859f2b332a6fc9eafbd2
vapor@asm:~/toolbox$ 
```

Для того что бы  Docker автоматически стартовал контейнер при падении или после перезагрузки VM выполняем команду:

```
sudo docker update --restart unless-stopped restaurant
```

Переходим в папку с новым проектом.

```
cd Pizza_server_app
```

Открываем порт 8080.

```
sudo ufw allow 8080
```

Запускаем приложение, в качестве hostname указываем 0.0.0.0 .

```
swift run App serve --hostname 0.0.0.0 --port 8080
```

Swift подгрузит все необходимые зависимости, сблидит прект сделает миграцию моделей в базу данных и запустит его. Если все пройдет успешно на в терминале отобразится как минииум:

```
.
..
...
Working copy of https://github.com/apple/swift-nio.git resolved at 2.51.0
Building for debugging...
[2289/2289] Linking App
Build complete! (259.29s)
[ INFO ] [Migrator] Starting prepare [database-id: psql, migration: App.CreateMeal]
[ INFO ] [Migrator] Finished prepare [database-id: psql, migration: App.CreateMeal]
[ INFO ] [Migrator] Starting prepare [database-id: psql, migration: App.CreateBanner]
[ INFO ] [Migrator] Finished prepare [database-id: psql, migration: App.CreateBanner]
[ INFO ] [Migrator] Starting prepare [database-id: psql, migration: App.CreateCategory]
[ INFO ] [Migrator] Finished prepare [database-id: psql, migration: App.CreateCategory]
[ NOTICE ] Server starting on http://0.0.0.0:8080
```

После этого можно поробовать постлать запросы через браузер или Postman.

```
[ INFO ] GET /api/categories [request-id: 2D1A1246-9C74-45E7-9C26-B1539E7071A6]
[ INFO ] GET /api/banners [request-id: 252D7946-7187-4F48-8744-87413110D97D]
[ INFO ] GET /api/meals [request-id: 7DFE43FA-0C97-41FD-8ECC-8E3B1C7452CA]
[ INFO ] POST /api/meals [request-id: 2F2A5C44-2C3C-4423-B55E-EB65E755AD7A]
[ WARNING ] Abort.499: Не получилось декодировать контент в модель Meal [request-id: 2F2A5C44-2C3C-4423-B55E-EB65E755AD7A]
[ INFO ] POST /api/meals [request-id: 7565FFB3-C1A3-413E-B4C4-42675669E1EA]
[ INFO ] GET /api/categories [request-id: D568A86D-0938-4334-9793-1D46D391A874]
```





### Tmux

[Наверх](#Оглавление)

При зактытии окна терминала завершается сессия пользователя и все процессы запущенные им, приложение падает. Частично эту проблему может решить утилита **Screen** или **Tmux **(в Ubuntu установлен по умолчанию, в CentOS нужно ставить самостоятельно).

Даем команду.

```
tmux attach
```

Делая так, вы сперва пытаетесь подключиться к уже существующему серверу tmux, если он существует. Если такого ещё нет — создаёте новый вызвав команду:

```
tmux new
```

После этого вы попадаете в полноценную консоль. Предвариткльно переходим в папку с проектом. В ней уже можно запустить приложение командой.

```
swift run App serve --hostname 0.0.0.0 --port 8080
```



***Теперь, если закрыть окно терминала, приложение не упадет.***

Можно просто закрыть окно Tmux командойм**Ctrl+b d**.

 ***В общем и все,  можно закрыть терминал и приложение продолжит работу***

Если в открытом окошке Tmux с запущеным приложением дать команду ***Ctrl+b &*** —  окошко Tmux закроется и приложение упадет

В одной сессии может быть сколько угодно окошек:

- **Ctrl+b c** — создать окошко;
- **Ctrl+b 0...9** — перейти в такое-то окошко;
- **Ctrl+b p** — перейти в предыдущее окошко;
- **Ctrl+b n** — перейти в следующее окошко;
- **Ctrl+b l** — перейти в предыдущее активное окошко (из которого вы переключились в текущее);
- **Ctrl+b &** — закрыть окошко (а можно просто набрать **`exit`** в терминале).

В одном окошке может быть много панелей:

- **Ctrl+b %** — разделить текущую панель на две, по вертикали;
- **Ctrl+b "** — разделить текущую панель на две, по горизонтали (это кавычка, которая около Enter, а не Shift+2);
- **Ctrl+b** →←↑↓ — переходить между панелями;
- **Ctrl+b x** — закрыть панель (а можно просто набрать **`exit`** в терминале).

Использование Tmux удобно использовать при разработке и тестировании. Для комерческого использования это не есть хорошая практика и необходимо преобразовать приложение в демона OS. Это позволит запускать его автоматически при старте OS, отслеживать его работу со стороны системы и перезагружать  если оно упало.



### Демонизация приложения 

*(раздел требует дополнения)*

[Наверх](#Оглавление)

Допустим нам нужно что бы после перезагрузки VM сервис приложения поднимался автоматически,  для этого нужно чтобы

- был запущен Vapor - он является демоном и стартует автоматически

- был запущен Docker - он является демоном и стартует автоматически
- в Docker был запущен контейнер `restaurant` с базой данных ( Docker должен запустить его если ранее была выполнена команда `sudo docker update --restart unless-stopped restaurant` , если нет выполняем ее. Так же контейнер можно запустить вручную командой  `sudo docker start restaurant` )
- и было запущено приложение из директории ` /home/vapor/toolbox/Pizza_server_app` командой `swift run App serve --hostname 0.0.0.0 --port 8080` 



Как это сделать и пойдет речь далее.

Чтобы превратить  приложение в демона можно воспользоваться менеджером системы и служб  Systemd.

Systemd запускает сервисы описанные в его конфигурации.
Конфигурация состоит из множества файлов, которые называют юнитами.

Все эти юниты разложены в трех каталогах:

`/usr/lib/systemd/system ` — юниты из установленных пакетов RPM — всякие nginx, apache, mysql и прочее.
`/run/systemd/system/ ` — юниты, созданные в рантайме — тоже, наверное, нужная штука.
`/etc/systemd/system/` — юниты, созданные системным администратором — а вот сюда мы и положим свой юнит.

Простейший стартап скрипт, он же unit для systemd: myunit.service *(раздел требует дополнения)*

```
[Unit]
Description=VaporUnit
After=syslog.target
After=network.target
After=nginx.service
After=mysql.service
Requires=mysql.service
Wants=redis.service

[Service]
Type=forking
PIDFile=/home/vapor/toolbox/Pizza_server_app
WorkingDirectory=/home/vapor/toolbox/Pizza_server_app

User=vapor
Group=vapor

Environment=RACK_ENV=production

OOMScoreAdjust=-1000

ExecStart=/usr/local/bin/bundle exec service -C /work/www/myunit/shared/config/service.rb --daemon
ExecStop=/usr/local/bin/bundle exec service -S /work/www/myunit/shared/tmp/pids/service.state stop
ExecReload=/usr/local/bin/bundle exec service -S /work/www/myunit/shared/tmp/pids/service.state restart
TimeoutSec=300

[Install]
WantedBy=multi-user.target 
```

*(раздел требует дополнения)*



## Развертывание с использованием Docker

[Наверх](#Оглавление)

*(здесь будет описание сборки образа с приложением и разверывание в контейнере Docker)*





## Ссылки

[Наверх](#Оглавление)

работа с TMUX - https://habr.com/ru/articles/126996/

шпаргалка по MarkDown - https://paulradzkov.com/2014/markdown_cheatsheet/

статья по Systemd - https://habr.com/ru/companies/southbridge/articles/255845/





### Команды Unix

[Наверх](#Оглавление)



Вывести список всех пользователей

```
cut -d: -f1 /etc/passwd
```



Переключиться на `root` пользователя

```
sudo -i
```

Переключиться на `user1` пользователя

```
su user1
```


Изменить пароль у `user1` пользователя, предварительно нужно переключиться на `root` пользователя

```
passwd user1
```

Установка утилиты `nano` в CentOS

```
yum install nano
```

Установка утилиты `nano` в Ubuntu

```
sudo apt update
sudo apt install nano
```

Посмотреть свободное пространство на диске

```
df
```

Поиск по имени файла в текущей директории

```
find -name "findname.html"
```

Удаление папки или файла

```
rm filename.html
```

Удаление папки и всех файлов содержащейся в нем рекурсивным перебором

```
rm -r bitrix
```

Удаление папки и всех файлов содержащейся сразу

```
rm -rf bitrix
```
