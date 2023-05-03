

## Серверное приложение [Test_Task_3_server_app_without_relationModel](https://github.com/AAASASN/Test_Task_3_server_app_without_relationModel)

### Оглавление

	- [Описаниe](#Описание)
 - Развертывание
   - Развертывание
   - Создание виртуальной машины и подключение 
   - Первичные настройки
   - Установка Swift
   - Установка Vapor
   - Создание тестового проекта Hello World
   - Создание  проекта Test_Task_3_server_app_without_relationModel
   - [Установка Docker и создание базы данных](#Установка-Docker)

​	Запуск



В данном руководстве используется версии Ubuntu 22.04, Swift 5.8, Vapor 5.4.0

### Описаниe

Это серверное приложение  создано как API мобильного приложения Додо Пица -  [место для ссылки](http://example.com/link "Я ссылка"). Окликается на запосы типа GET, POST, PUT, DELETE и позволяет получать данные в виде JSON:

по запросу на http://XXX.XXX.XXX.XXX/api/meals возвращает

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

  

по запросу на http://XXX.XXX.XXX.XXX/api/banners возвращает

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



по запросу на http://XXX.XXX.XXX.XXX/api/banners возвращает

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



### Развертывание

### Создание виртуальной машины и подключение 

Для создания ВМ я воспользовался сервисом [Yandex Cloud](https://cloud.yandex.ru), в качестве орерационной системы выбрал Ubuntu 22.04 . Для подключения к ВМ используется протокол SSH, он основан на использовании пары ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Для создания ключей нужно дать команду в терминале:

```
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa
```

Будет предложено ввести пароль, затем в директории ~/.ssh будет созданы файлики вида `id_rsa.pub`  и `id_rsa` . Если файликов в папке  ~/.ssh не оказалось следует поискать их в корневой директории текущуго пользователя и переместить их в  ~/.ssh. Октрытый ключ должен храниться на ВМ и сообщается ей при ее создании, а закрытый `id_rsa`  всегда должен храниться в директории ~/.ssh.

Открываем любым текстовым редактором файлик с публичным ключем  `id_rsa.pub` ,  копируем из него весь текст - он имеет вид -  `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK7roNnfzL+gRPCz`. При создвнии ВМ вставляем открытый ключ в соответствующее поле в панели управления сервиса.

Подключаемся через терминал командой типа `ssh asm@51.250.111.32`  где asm это имя пользователя, 51.250.111.32  адрес указанного при создании ВМ. Водим пароль указаный при создании  ssh-ключа

```
ssh asm@51.250.111.32
```



### Первичные настройки

Далее все команды вводим с указанием прав суперпользователя `sudo` 

Конфигурация Firewall

```
sudo ufw allow OpenSSH
sudo ufw enable
```



 Создаем отдельного пользователя, как пример - vapor

```
sudo adduser vapor
```



Наделяем его правами суперпользователя

```
sudo usermod -aG sudo vapor
```



Копируем авторизованные ключи SSH пользователя root только что созданному пользователю. Это позволит войти в SSH в качестве нового пользователя.

```
sudo rsync --archive --chown=vapor:vapor ~/.ssh /home/vapor
```



Перезаходим под пользователем `vapor` 

```
exit
ssh vapor@51.250.111.32
```





### Установка Swift

Установка необходимых зависимостей Swift.

```
sudo apt-get update
sudo apt-get install binutils git gnupg2 libc6-dev libcurl4-openssl-dev 
     \ libedit2 libgcc-9-dev libpython3.8 libsqlite3-0 libstdc++-9-dev 
     \ libxml2-dev libz3-dev pkg-config tzdata unzip zlib1g-dev
```



Загрузка и установка Swift Toolchain. Для этого нужно дать команду `wget` и указать ссылку для загрузки пакета Swift. Ссылку на пакет берем с официального сайта swift.org - https://www.swift.org/download/#releases. Копируем ту которая соответствует некоторым условиям, в моем случае это   Swift 5.8,  OS - Ubuntu 22.04 и архетиктура железа сервера  `x86_64` 

```
sudo wget https://download.swift.org/swift-5.8-release/ubuntu2204/swift-5.8-RELEASE/swift-5.8-RELEASE-ubuntu22.04.tar.gz
```

 В корневую директорию пользователя `vapor`  загружается архив порядка 500Mb

```
vapor@asm:~$ ls -l
total 531392
-rw-r--r-- 1 root root 544139004 Mar 30 23:16 swift-5.8-RELEASE-ubuntu22.04.tar.gz
vapor@asm:~$ 
```



Распаковываем его при помощи встроенного в операционную систему инструмента `tar` 

```
tar xzf swift-5.8-RELEASE-ubuntu22.04.tar.gz
```

распаковка может занять продолжительное время, ждем

проверяем

```
vapor@asm:~$ ls -l
total 531396
drwxrwxr-x 3 vapor vapor      4096 May  2 12:58 swift-5.8-RELEASE-ubuntu22.04
-rw-r--r-- 1 root  root  544139004 Mar 30 23:16 swift-5.8-RELEASE-ubuntu22.04.tar.gz
vapor@asm:~$ 
```



далее при помощи команды `sudo mkdir /swift` создаем папку swift  в корневой директории 

```
sudo mkdir /swift
```



Для инсталяции Swift 5.8 нужно находясь в директории `/home/vapor` выполнить команду

```
sudo mv swift-5.8-RELEASE-ubuntu22.04 /swift/5.8
```

команда перемещает из директории  `/home/vapor/swift-5.8-RELEASE-ubuntu22.04 ` содержимое папки swift-5.8-RELEASE-ubuntu22.04 в системную папку   `/swift`  одновременно создав в ней подпапку   ` 5.8 `  а  пустая папка ` swift-5.8-RELEASE-ubuntu22.04 ` после будет удалена 



далее выполняем команду

```
sudo ln -s /swift/5.8/usr/bin/swift /usr/bin/swift
```

она создает в системной папке ` /bin ` ссылку на файл ` swift ` находящийся в папке с приложением Swift 5.8 - ` /swift/5.8/usr/bin/swift ` таким образом команды Swift 5.8 можно будет запускать из любой директории используя ключевое слово ` swift ` .  Ссылка выглядит так: 

```
lrwxrwxrwx 1 root root          24 May  2 14:01  swift -> /swift/5.8/usr/bin/swift
```



Если ссылка создалась корректно можно дать комманду ` swift --version ` из любой директории и она должна дать ответ

```
vapor@asm:~$ swift --version
<unknown>:0: warning: glibc not found for 'x86_64-unknown-linux-gnu'; C stdlib may be unavailable
Swift version 5.8 (swift-5.8-RELEASE)
Target: x86_64-unknown-linux-gnu
vapor@asm:~$ 
```



### Установка Vapor

находясь в корневой папке пользователя клонируем Vapor Toolbox

```
git clone https://github.com/vapor/toolbox.git
```



далее

```
cd toolbox
git checkout 18.6.0
```



билдим Vapor

```
swift build -c release --disable-sandbox --enable-test-discovery
```

если сборка завершилась с ошибкой - возможно не хватает некоторых зависимостей, установыим их командой

```
sudo apt-get update
```

и

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



затем пробуем еще раз собрать

```
swift build -c release --disable-sandbox --enable-test-discovery
```



затем перемещаем бинарник в папку ` /usr/local/bin `

```
sudo mv .build/release/vapor /usr/local/bin
```





### Создание проекта

Для демонстрации работы Vapor создаем новый проект HelloWorld

``` 
vapor new HelloWorld
```

при этом установив ` -n ` в ` vapor new HelloWorld -n `  мы отказываемся от включения в проект фреймверков Fluent - работает с базами данных, Leaf - язык шаблонов в стиле языка swift для создания HTML-страниц,  и преднастроек для работы с базами данных



Для текущей версии стандартного шаблона HelloWorld необходимо дополнительно подключить библиотеку Fluent и выбрать базу данных SQLite.

```

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



переходим в папку с новым проектом

```
cd HelloWorld
```



открываем порт 8080

```
sudo ufw allow 8080
```



запускаем приложение, в качестве hostname указываем 0.0.0.0

```
swift run App serve --hostname 0.0.0.0 --port 8080
```



Swift подгрузит все необходимые зависимости, сблидит прект и запустит его. Если все пройдет успешно на в терминале отобразится как минииум

```
vapor@asm:~/toolbox/HelloWorld$ swift run App serve --hostname 0.0.0.0 --port 8080
Building for debugging...
Build complete! (0.25s)
[ NOTICE ] Server starting on http://0.0.0.0:8080
```

Проверить работтоспособность можно сделав запрос в терминале локальной машины или  через браузер по ссылке  `http://62.84.126.38:8080 ` - используем http, а не https

```
alexander@MacBook-Air-Aleksandr ~ % curl http://62.84.126.38:8080   
It works!%                                                                     
alexander@MacBook-Air-Aleksandr ~ % 
```



Для удаления проекта HelloWorld достаточно удалить папку HelloWorld в директории ` toolbox ` 

```
sudo rm -r HelloWorld
```





### Создание  проекта Test_Task_3_server_app_without_relationModel

Переходим в директорию ` /home/vapor/toolbox ` и клонируем текущий проект 

```
git clone https://github.com/AAASASN/Test_Task_3_server_app_without_relationModel.git
```

появляется репозиторий ` Test_Task_3_server_app_without_relationModel `

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
drwxrwxr-x 6 vapor vapor 4096 May  2 22:22 Test_Task_3_server_app_without_relationModel
vapor@asm:~/toolbox$ 
```

В проекте  ` Test_Task_3_server_app_without_relationModel ` используется база данных ` PostgreSQL ` Перед тем как собрать и запустить проект необходимо установить и запустить Docker, создать контейнер и запустить в неи базу данных PostgreSQL

Установка Docker







## Установка Docker

Чтобы успешно установить Docker Desktop, ваш хост Linux должен соответствовать следующим общим требованиям:

- 64-разрядная поддержка ядра и процессора для виртуализации.

- Поддержка виртуализации KVM. Следуйте инструкциям по поддержке виртуализации KVM, чтобы проверить, включены ли модули ядра KVM и как обеспечить доступ к устройству kvm.

- QEMU должен быть версии 5.2 или новше. Мы рекомендуем обновиться до последней версии.

- Система инициализации.

Среда Gnome, KDE или MATE Desktop.

Для многих дистрибутивов Linux среда Gnome не поддерживает значки в трее. Чтобы добавить поддержку значков в трее, необходимо установить расширение Gnome. Например, AppIndicator.

Не менее 4 ГБ оперативной памяти.

Включите настройку сопоставления идентификаторов в пространствах имен пользователей, см. раздел Общий доступ к файлам.



Проверяем поддерживает ли ВМ виртуализацию KVM

```
egrep -c '(vmx|svm)' /proc/cpuinfo
```

Если ответ 0 значит железо не позволяет работать с KVM или поставщик ВМ заблокировал эту функцию и нужно рассмотреть другой тариф. Если ответ больше 0 то все ок и можно продолжить насторойку.

Включаем виртуализацию

```
modprobe kvm
```



В зависимости от процессора хост-машины должен быть загружен соответствующий модуль: ()

```
modprobe kvm_intel  # Intel processors
modprobe kvm_amd    # AMD processors
```

