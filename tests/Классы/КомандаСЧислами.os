&Опция(Имя = "a", Описание = "Число 1")
&ТЧисло
Перем Число1;

&Опция(Имя = "b", Описание = "Число -1")
&ТЧисло
Перем Число2;

&Опция(Имя = "c", Описание = "Число 1.5")
&ТЧисло
Перем Число3;

&Опция(Имя = "d", Описание = "Число 10000")
&ТЧисло
Перем Число4;

Перем Результат Экспорт;

&КомандаПриложения(Имя = "testingdigs")
Процедура ПриСозданииОбъекта()
	Результат = Новый Массив();
КонецПроцедуры

&ВыполнениеКоманды
Процедура СформироватьРезультат() Экспорт

	Результат.Добавить(Число1);
	Результат.Добавить(Число2);
	Результат.Добавить(Число3);
	Результат.Добавить(Число4);
	
КонецПроцедуры
