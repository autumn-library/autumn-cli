// Обработчик выполнения команды
//
// Параметры:
//   КомандаПриложения - КомандаПриложения - Выполняемая команда
//
Процедура ВыполнитьКоманду(Знач КомандаПриложения) Экспорт

	КомандаПриложения.ВывестиСправку();

КонецПроцедуры

&КомандаПриложения(
	Имя = "help h",
	Описание = "Вывести справку по командам"
)
&Прозвище("КомандаПриложенияПоУмолчанию")
Процедура ПриСозданииОбъекта()

КонецПроцедуры