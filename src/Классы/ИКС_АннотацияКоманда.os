
Перем _Значение;
Перем _ДобавлятьАннотациюЖелудь;

Процедура ПриРазворачиванииАннотации(ОпределениеАннотации, ПодчиненныеАннотации, ТипВладельцаСвойств, Свойство) Экспорт
	
	Аннотация = РаботаСАннотациями.НайтиАннотацию(ПодчиненныеАннотации, "Желудь"); 
	ЭтоЗавязь = НЕ РаботаСАннотациями.НайтиАннотацию(Свойство.Аннотации, "Завязь") = Неопределено; 
	Если _ДобавлятьАннотациюЖелудь = Истина 
			И Аннотация = Неопределено 
			И ЭтоЗавязь = Ложь Тогда
		Аннотация = ПодчиненныеАннотации.Вставить(1);
		Аннотация.Имя = "желудь";
		Аннотация.Параметры = Новый ТаблицаЗначений();
		Аннотация.Параметры.Колонки.Добавить("Имя");
		Аннотация.Параметры.Колонки.Добавить("Значение");
	КонецЕсли;
	Если _Значение <> "" Тогда
		РаботаСАннотациями.УстановитьЗначениеПараметраАннотации(Аннотация, "Значение", _Значение);
	КонецЕсли;

КонецПроцедуры

&Аннотация("КомандаПриложения")
&Прозвище("КомандаПриложения")
Процедура ПриСозданииОбъекта(Идентификатор = "", 
								Имя = "", 
								Описание = "", 
								ЭтоПодкоманда = Ложь, 
								&Повторяемый Подкоманда = Неопределено,
								ДобавлятьАннотациюЖелудь = Истина)

	_Значение = Идентификатор;
	_ДобавлятьАннотациюЖелудь = ДобавлятьАннотациюЖелудь;

КонецПроцедуры