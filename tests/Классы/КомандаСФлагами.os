&Опция(Имя = "t flagtrue", Описание = "Значение - флаг - истина")
&Флаг
Перем ФлагИстина;

&Опция(Имя = "f flagfalse", Описание = "Значение - флаг - ложь")
&Флаг
&ПоУмолчанию(Ложь)
Перем ФлагЛожь;

Перем Результат Экспорт;

&КомандаПриложения(Имя = "testingflag")
Процедура ПриСозданииОбъекта()
	Результат = Новый Массив();
КонецПроцедуры

&ВыполнениеКоманды
Процедура СформироватьРезультат() Экспорт

	Результат.Добавить(ФлагИстина);
	Результат.Добавить(ФлагЛожь);
	
КонецПроцедуры
