&Опция(Имя = "a", Описание = "Массив дат")
&ТМассивДат(ФорматДаты = "yyyy-MM-dd", ВходящийРазделительМассива = ";")
Перем МассивДат Экспорт;

&Опция(Имя = "b", Описание = "Массив строк")
&ТМассивСтрок(";")
Перем МассивСтрок Экспорт;

&Опция(Имя = "c", Описание = "Массив чисел")
&ТМассивЧисел(";")
Перем МассивЧисел Экспорт;

&КомандаПриложения(Имя = "testingarray")
Процедура ПриСозданииОбъекта()

КонецПроцедуры

&ВыполнениеКоманды
Процедура СформироватьРезультат() Экспорт
	
КонецПроцедуры
