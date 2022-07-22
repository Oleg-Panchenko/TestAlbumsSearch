# TestAlbumsSearch
Test task. Search music albums using iTunes API.

# Содержание

- **[Экран регистрации пользователя с валидацией полей](#SignUp)**
- **[Экран авторизации пользователя](#SignIn)**
- **[Экран поиска музыкальных альбомов + Данные пользователя с экрана регистрации](#Search)**
- **[Экран альбома](#AlbumScreen)**
- **[Требования](#Requirements)**
- **[Презентация реализации](#Presentation)**

## <a id="SignUp"></a>Экран регистрации пользователя с валидацией полей. 
- Имя (только на английском)
- Фамилия (только на английском) 
- Возраст (с возможностью выбора через календарь и не младше 18 лет)
- Номер телефона (должен вводиться автоматически в формате + 7 (xxx) xxx-xx-xx)
- E-mail (проверка на корректность введенного email) 
- Пароль (не менее 6 символов, обязательно должны быть цифра, буква нижнего регистра, буква верхнего регистра) 
- Все поля должны быть обязательны для заполнения и проверены на валидность.

## <a id="SignIn"></a>Экран авторизации пользователя. 
- Поля e-mail и пароль;
- Проверка на наличие пользователя в «базе»; 
- Переход на следующий экран только для авторизованного пользователя.

## <a id="Search"></a>Экран поиска музыкальных альбомов + Данные пользователя с экрана регистрации. 
- Search bar и табличное представление найденных альбомов;
- Альбомы должны быть отсортированы по алфавиту;
- Обязательно для отображения: 
  - лого альбома
  - название альбома
  - название группы
  - количество песен;
- По нажатию на альбом открывается экран альбома. 
- Искать можно и на русском и на английском.

## <a id="AlbumScreen"></a>Экран альбома.
- Обязательно для отображения: 
  - лого альбома
  - название альбома
  - название группы
  - год выхода альбома
  - список песен

## <a id="Requirements"></a>Требования:
- Xcode 11+, Swift 5+, iOS 14+, не использовать SwiftUI;
- Можно использовать любые сторонние библиотеки;
- Дизайн должен соответствовать Human Interface Guidelines;
- Проект должен устанавливаться без дополнительных действий, кроме установки зависимостей (pod install), и ошибок. 
- Данные пользователя не должны передаваться между экранами, а должны сохранятся в локальную базу данных устройства и извлекаться из нее. 
- Возможные ошибки должны быть обработаны.

## <a id="Presentation"></a>Презентация реализации.

<img width="300" src="https://user-images.githubusercontent.com/77533590/180409028-fe12dfcd-ec1e-4c79-9a81-38e906687ff0.png">  <img width="300" src="https://user-images.githubusercontent.com/77533590/180409328-72e59ef4-106a-4b1b-aff5-4287073fc7d5.png">

<img width="300" src="https://user-images.githubusercontent.com/77533590/180410612-d207f0e2-e813-4489-bd84-a8215b230f3c.png">  <img width="300" src="https://user-images.githubusercontent.com/77533590/180409811-8a7769c0-2890-4a1e-82f6-9bb2a511eb4f.png">  <img width="300" src="https://user-images.githubusercontent.com/77533590/180409873-8ec0bf3c-97ec-4d9c-a4c6-d8e42dabb9f7.png">
