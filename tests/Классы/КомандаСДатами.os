&Опция(Имя = "a", Описание = "Дата без формата")
&ТДата
Перем Дата1;

&Опция(Имя = "b", Описание = "Дата с форматом")
&ТДата("yyyy-MM-dd")
Перем Дата2;

Перем Результат Экспорт;

&КомандаПриложения(Имя = "testingdate")
Процедура ПриСозданииОбъекта()
	Результат = Новый Массив();
КонецПроцедуры

&ВыполнениеКоманды
Процедура СформироватьРезультат() Экспорт

	Результат.Добавить(Дата1);
	Результат.Добавить(Дата2);
	
КонецПроцедуры
