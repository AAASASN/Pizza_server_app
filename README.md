

## Серверное приложение [Test_Task_3_server_app_without_relationModel](https://github.com/AAASASN/Test_Task_3_server_app_without_relationModel)

Оглавление

1. Описаниe

2. Развертывание
   1. Создание виртуальной машины и подключение 
   2. Первичные настройки
   3. Установка Swift
   4. Установка Vapor
   5. Создание проекта
   6. Установка Docker и создание базы данных
   7. Запуск

- 



### 1. Описаниe

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



### 2. Развертывание

