&Опция(Имя = "n name", ЗначениеПоУмолчанию = "noname", Описание = "Имя пользователя")
Перем ИмяПользователя;

Перем ТекстПрощания Экспорт;

&КомандаПриложения(Имя = "ident", Идентификатор = "КастомноеИмяКоманды")
Процедура ПриСозданииОбъекта()
		
КонецПроцедуры

&ВыполнениеКоманды
Процедура СформироватьТекстПрощания() Экспорт

	ТекстПрощания = "Пока " + ИмяПользователя;
	
КонецПроцедуры

Функция ИмяПользователя() Экспорт
	Возврат ИмяПользователя;
КонецФункции
