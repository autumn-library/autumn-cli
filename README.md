# autumn-cli 

Обертка над [cli](https://github.com/khorevaa/cli) библиотекой, которая предоставляет возможности создания консольных приложений на фреймворке [ОСень](https://github.com/autumn-library/autumn).

## Подключение и пример использования

Точка входа в приложение

```main.os```
```bsl
#Использовать autumn
#Использовать autumn-cli
#Использовать "Каталог/С/Классами/Команд"

Поделка = Новый Поделка();
Поделка
	.ПросканироватьКаталог("Каталог/С/Классами/Команд")
	.ЗапуститьПриложение();
```

Допустим мы хотим сделать приложение, которое имеет следующие команды:

```plus``` - Принимает один числовой аргумент, и прибавляет к нему 10. Выводит результат в консоль.

```hello``` - Имеет опцию ```name```, и выводит в консоль приветствующее сообщение.

```date``` - Имеет две подкоманды, ```day``` выводит в консоль начало дня, и ```month``` выводит в консоль начало месяца.

## Аргументы

Подготовим первую команду:

```Каталог/С/Классами/Команд/КомандаПлюс.os```
```bsl
&Аргумент(Имя = "ARG", Описание = "Значение числа") // Определим аргумент, и дадим ему описание
&ТЧисло // Укажем тип аргумента
Перем ПереданноеЧисло;

&КомандаПриложения(Имя = "p plus", Описание = "Прибавляет 10 к заданному числу") // Аннотация, обозначающая, что этот класс - консольная команда
Процедура ПриСозданииОбъекта()
		
КонецПроцедуры

&ВыполнениеКоманды // Метод, помеченный этой аннотацией будет выполнены при вызове команды.
Процедура ВывестиРезультатСложения() Экспорт

	Результат = ПереданноеЧисло + 10;

	Сообщить("Результат сложения: " + Результат);
	
КонецПроцедуры
```

В этом примере мы определили класс как команду консольного приложения с помощью аннотации 

```&КомандаПриложения(Имя = "p plus", Описание = "Прибавляет 10 к заданному числу")```

В которой указали имя команды и ее описание. А для определения аргумента команды, была создана переменная с аннотацией 

```&Аргумент(Имя = "ARG", Описание = "Значение числа")```

Для того, что бы дать понять библиотеке, какой метод нужно выполнить при вызове команды, нужно сделать экспортный метод с аннотацией

```&ВыполнениеКоманды```

## Опции

Команда с опцией

```Каталог/С/Классами/Команд/КомандаПривет.os```
```bsl
&Опция(Имя = "n name", Описание = "Имя пользователя")
Перем ИмяПользователя;

&КомандаПриложения(Имя = "H hello", Описание = "Поздоровается с пользователем")
Процедура ПриСозданииОбъекта()
		
КонецПроцедуры

&ВыполнениеКоманды
Процедура ПоприветствоватьПользователя() Экспорт

	ТекстСообщения = "Привет " + ИмяПользователя + "!";

	Сообщить(ТекстСообщения);
	
КонецПроцедуры
```

В этом примере, для определения опции команды, была создана переменная с аннотацией 

```&Опция(Имя = "n name", Описание = "Имя пользователя")```

## Подкоманды

Теперь определим последнюю команду, которая имеет две подкоманды

```Каталог/С/Классами/Команд/КомандаДата.os```
```bsl
&КомандаПриложения(Имя = "d date", 
					Описание = "Выводит дату",
					Подкоманда = "ПодкомандаДень",
					Подкоманда = "ПодкомандаМесяц"
)
Процедура ПриСозданииОбъекта()
		
КонецПроцедуры
```

И с помощью аннотации ```&ПодкомандаПриложения``` определим эти две подкоманды

```Каталог/С/Классами/Команд/ПодкомандаДень.os```
```bsl
&ПодкомандаПриложения(Имя = "day", Описание = "Выводит дату - начало дня")
Процедура ПриСозданииОбъекта()
		
КонецПроцедуры

&ВыполнениеКоманды
Процедура СообщитьДень() Экспорт

	Сообщить(НачалоДня(ТекущаяДата()));

КонецПроцедуры
```

```Каталог/С/Классами/Команд/ПодкомандаМесяц.os```
```bsl
&ПодкомандаПриложения(Имя = "month", Описание = "Выводит дату - начало месяца")
Процедура ПриСозданииОбъекта()
		
КонецПроцедуры

&ВыполнениеКоманды
Процедура СообщитьМесяц() Экспорт

	Сообщить(НачалоМесяца(ТекущаяДата()));
	
КонецПроцедуры
```

## Типы аргументов и опций

Имеется набор аннотаций, которые можно добавить к полям команд, которые обозначат, к какому типу нужно приводить эти поля

```bsl
&ТБулево
&ТДата
&ТЧисло
&ТСтрока
&ТМассивДат
&ТМассивЧисел
&ТМассивСтрок
```

## Дополнительные аннотации аргументов и опций

```bsl
&ВОкружении
&Флаговый
&Флаг
&СкрытьВСправке
&ПоУмолчанию
&Псевдоним
&Описание
&Обязательный
&ПодробноеОписание
```

## Настройка версии и имени приложения.

Настройку вывода версии и имени приложения можно осуществить двумя способами.

1) Создать рядом с точкой входа файл 

```autumn-properties.json```
```json
{
    "cli": {
        "ИмяПриложения": "cli_test",
        "ПолноеИмяПриложения": "cli_test v%{cli.ВерсияПриложения}",
        "ВерсияПриложения": "1.0.1"
    }
}
```

2) В каталог с командами, которые будут загружены в контекст осени, добавить желудь с определенным интерфейсом

```Каталог/С/Классами/Команд/ДемоОписаниеПриложения.os```
```bsl
&Желудь("ОписаниеКонсольногоПриложения")
&Верховный
Процедура ПриСозданииОбъекта()
КонецПроцедуры

Функция ИмяПриложения() Экспорт
	Возврат "demo-cli";
КонецФункции

Функция ПолноеИмяПриложения() Экспорт
	Возврат "Демонстрационное консольное приложение";
КонецФункции

Функция ВерсияПриложения() Экспорт
	Возврат "1.0";
КонецФункции
```

## Миграция с [cli](https://github.com/khorevaa/cli)

Инфраструктурный, условный ```main.os``` от вашего приложения не нужен. он должен быть запущен при помощи [ОСени](https://github.com/autumn-library/autumn). А вот команды придется модифицировать, аннотациями конструктора ```&КомандаПриложения``` или ```&ПодкомандаПриложения```. Дальше перед вами два пути: Вервый - оставить методы ```ОписаниеКоманды``` и ```ВыполнитьКоманду```, тогда фреймворк поймет что они уже реализованы, и не будет генерировать для них код. Второй - убрать методы ```ОписаниеКоманды``` и ```ВыполнитьКоманду```, и создать поля класса, с необходимыми аннотациями, и метод с аннотацией ```&ВыполнениеКоманды```. В таком случае фреймворк сгенерить для все остальное за вас.

## Больше примеров

Описанные классы можно посмотреть в каталоге [example](example/) и еще больше примеров команд в каталоге [tests](tests/Классы)


