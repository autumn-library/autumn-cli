
&Опция(Имя = "n name", ЗначениеПоУмолчанию = "username", Описание = "Имя пользователя")
Перем ИмяПользователя;

&КомандаПриложения(Имя = "H hello", Описание = "Поздоровается с пользователем")
Процедура ПриСозданииОбъекта()
		
КонецПроцедуры

&ВыполнениеКоманды
Процедура ПоприветствоватьПользователя() Экспорт

	ТекстСообщения = "Привет " + ИмяПользователя + "!";

	Сообщить(ТекстСообщения);
	
КонецПроцедуры