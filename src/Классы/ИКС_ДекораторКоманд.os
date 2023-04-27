#Использовать decorator
#Использовать autumn

Перем Рефлектор;

Перем ОписаниеАргументов;

&Желудь
Процедура ПриСозданииОбъекта()
	Рефлектор = Новый Рефлектор();
	ЗаполнитьОписаниеАргументов();
КонецПроцедуры

Функция СоздатьКомандуПоАннотациямОбъекта(ДанныеЖелудя) Экспорт
	Декоратор = Новый ПостроительДекоратора(ДанныеЖелудя.Желудь);

	ПодготовитьОписаниеКоманды(Декоратор, ДанныеЖелудя);
	ПодготовитьВыполнитьКоманду(Декоратор, ДанныеЖелудя);

	Возврат Декоратор.Построить();
КонецФункции

Процедура ПодготовитьОписаниеКоманды(ПостроительДекоратора, ДанныеЖелудя)
	Если ЕстьМетод(ДанныеЖелудя.Желудь, "ОписаниеКоманды") Тогда
		Возврат;
	КонецЕсли;

	ТелоМетода = Новый Массив;
	Свойства = ДанныеЖелудя.ОпределениеЖелудя.Свойства();

	Для Каждого Свойство из Свойства Цикл
		Аннотация = РаботаСАннотациями.ПолучитьАннотацию(Свойство, "Опция");
		Если Аннотация = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ТелоМетода.Добавить(СтрШаблон("ТекКоманда = КомандаПриложения.Опция(""%1"", """", ""%2"");", 
							РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, "Имя"),
							РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, "Описание")));

		ДополнитьОписаниеОпции(ТелоМетода, Свойство);
	КонецЦикла;

	Метод = Новый Метод("ОписаниеКоманды").Публичный();
	Метод.Параметр(Новый ПараметрМетода("КомандаПриложения").ПоЗначению());
	Метод.ТелоМетода(СтрСоединить(ТелоМетода, Символы.ПС));

	ПостроительДекоратора.Метод(Метод);
КонецПроцедуры

Процедура ПодготовитьВыполнитьКоманду(ПостроительДекоратора, ДанныеЖелудя)
	Если ЕстьМетод(ДанныеЖелудя.Желудь, "ВыполнитьКоманду") Тогда
		Возврат;
	КонецЕсли;

	ТелоМетода = Новый Массив;
	Свойства = ДанныеЖелудя.ОпределениеЖелудя.Свойства();

	Для Каждого Свойство из Свойства Цикл
		Аннотация = РаботаСАннотациями.ПолучитьАннотацию(Свойство, "Опция");
		Если Аннотация = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		ИмяОпции = СтрРазделить(РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, "Имя"), " ")[0];

		ТелоМетода.Добавить(СтрШаблон("%1 = КомандаПриложения.ЗначениеОпции(""%2"");", 
							Свойство.Имя,
							ИмяОпции));
	КонецЦикла;

	МетодыВыполненияКоманды = РаботаСАннотациями.НайтиМетодыСАннотацией(
													ДанныеЖелудя.ОпределениеЖелудя.Методы(), 
													"ВыполнениеКоманды");

	Для каждого МетодВыполненияКоманды Из МетодыВыполненияКоманды Цикл
		ТелоМетода.Добавить(МетодВыполненияКоманды.Имя + "();");
	КонецЦикла;

	Метод = Новый Метод("ВыполнитьКоманду").Публичный();
	Метод.Параметр(Новый ПараметрМетода("КомандаПриложения").ПоЗначению());
	Метод.ТелоМетода(СтрСоединить(ТелоМетода, Символы.ПС));

	ПостроительДекоратора.Метод(Метод);

КонецПроцедуры

Процедура ДополнитьОписаниеОпции(ТелоМетода, Свойство)

	Для каждого ТекущийАргумент Из ОписаниеАргументов Цикл

		Аннотация = РаботаСАннотациями.ПолучитьАннотацию(Свойство, ТекущийАргумент.Имя);

		Если Аннотация = Неопределено Тогда

			Продолжить;

		Иначе

			СтрокаОписанияАргумента = ПолучитьСтрокуОписаняАргумента("ТекКоманда.%1(%2);", Аннотация, ТекущийАргумент);
			ТелоМетода.Добавить(СтрокаОписанияАргумента);

		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

Функция ПолучитьСтрокуОписаняАргумента(Шаблон, Аннотация, ОписаниеАргумента)

	Возврат СтрШаблон(Шаблон, ОписаниеАргумента.Имя, СформироватьПараметрыМетодаАргумента(Аннотация, ОписаниеАргумента));
	
КонецФункции

Функция СформироватьПараметрыМетодаАргумента(Аннотация, ОписаниеАргумента)
	
	Если ОписаниеАргумента.ЕстьПараметры = Ложь Тогда
		Возврат "";
	КонецЕсли;

	Если ОписаниеАргумента.Параметры = Неопределено 
		ИЛИ ОписаниеАргумента.Параметры.Количество() = 1 Тогда

		Возврат ЗначениеЕдинственногоПараметраАннотации(Аннотация);

	КонецЕсли;

	Если ОписаниеАргумента.Параметры.Количество() > 1 Тогда
		Параметры = Новый Массив();
		Для Каждого ТекПараметр из ОписаниеАргумента.Параметры Цикл
			ЗначениеПараметра = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, ТекПараметр);
			Если ЗначениеПараметра = Неопределено Тогда
				Параметры.Добавить("");
			Иначе
				Параметры.Добавить(ПолучитьПредставлениеПараметраКоманды(ЗначениеПараметра));
			КонецЕсли;
		КонецЦикла;
		Возврат СтрСоединить(Параметры, ",");
	КонецЕсли;

КонецФункции

Функция ЗначениеЕдинственногоПараметраАннотации(Аннотация)

	Если Аннотация.Параметры.Количество() = 0 Тогда
		Возврат "";
	Иначе
		Возврат ПолучитьПредставлениеПараметраКоманды(Аннотация.Параметры[0].Значение);
	КонецЕсли; 
	
КонецФункции

Функция ПолучитьПредставлениеПараметраКоманды(ПараметрКоманды)

	Если ПараметрКоманды = Неопределено Тогда
		Возврат "Неопределено";

	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("Строка") Тогда
		Возврат """" + ПараметрКоманды + """";
	
	ИначеЕсли ТипЗнч(ПараметрКоманды) = Тип("Булево") Тогда
		Возврат ?(ПараметрКоманды = Истина, "Истина", "Ложь");

	Иначе 
		Возврат Строка(ПараметрКоманды);
	КонецЕсли;  

КонецФункции

Функция ЕстьМетод(Команда, ИмяМетода)
	Возврат Рефлектор.МетодСуществует(Команда, ИмяМетода);
КонецФункции

Процедура ЗаполнитьОписаниеАргументов()

	ОписаниеАргументов = Новый ТаблицаЗначений();
	ОписаниеАргументов.Колонки.Добавить("Имя");
	ОписаниеАргументов.Колонки.Добавить("ЕстьПараметры");
	ОписаниеАргументов.Колонки.Добавить("Параметры");

	ВОкружении = ОписаниеАргументов.Добавить();
	ВОкружении.Имя = "ВОкружении";
	ВОкружении.ЕстьПараметры = Истина;

	Флаговый = ОписаниеАргументов.Добавить();
	Флаговый.Имя = "Флаговый";

	Флаг = ОписаниеАргументов.Добавить();
	Флаг.Имя = "Флаг";

	СкрытьВСправке = ОписаниеАргументов.Добавить();
	СкрытьВСправке.Имя = "СкрытьВСправке";

	ПоУмолчанию = ОписаниеАргументов.Добавить();
	ПоУмолчанию.Имя = "ПоУмолчанию";
	ПоУмолчанию.ЕстьПараметры = Истина;

	ТБулево = ОписаниеАргументов.Добавить();
	ТБулево.Имя = "ТБулево";

	ТДата = ОписаниеАргументов.Добавить();
	ТДата.Имя = "ТДата";
	ТДата.ЕстьПараметры = Истина;

	ТЧисло = ОписаниеАргументов.Добавить();
	ТЧисло.Имя = "ТЧисло";

	ТСтрока = ОписаниеАргументов.Добавить();
	ТСтрока.Имя = "ТСтрока";

	ТМассивДат = ОписаниеАргументов.Добавить();
	ТМассивДат.Имя = "ТМассивДат";
	ТМассивДат.ЕстьПараметры = Истина;
	ТМассивДат.Параметры = СтрРазделить("ФорматДаты;ВходящийРазделительМассива", ";");

	ТМассивЧисел = ОписаниеАргументов.Добавить();
	ТМассивЧисел.Имя = "ТМассивЧисел";
	ТМассивЧисел.ЕстьПараметры = Истина;
	
	ТМассивСтрок = ОписаниеАргументов.Добавить();
	ТМассивСтрок.Имя = "ТМассивСтрок";
	ТМассивСтрок.ЕстьПараметры = Истина;
	
	Псевдоним = ОписаниеАргументов.Добавить();
	Псевдоним.Имя = "Псевдоним";
	Псевдоним.ЕстьПараметры = Истина;

	Описание = ОписаниеАргументов.Добавить();
	Описание.Имя = "Описание";
	Описание.ЕстьПараметры = Истина;

	Обязательный = ОписаниеАргументов.Добавить();
	Обязательный.Имя = "Обязательный";
	Обязательный.ЕстьПараметры = Истина;
	
	// TODO: Дотащить остальные текучие методы.


КонецПроцедуры