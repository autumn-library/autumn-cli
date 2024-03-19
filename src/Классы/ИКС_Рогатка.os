// TODO: отдельная рогатка ovm по управлчению временными файлами? Перехватчик "ПриЗавершенииПриложения" в ОСени?
#Использовать tempfiles

&Пластилин
Перем КонсольноеПриложение;

&Деталька(ЗначениеПоУмолчанию = Истина)
Перем ПоказыватьСтекВызовов;

Перем Лог;

Процедура ПриЗапускеПриложения() Экспорт

	КодСостояния = 0;
	Попытка
		КонсольноеПриложение.Запустить(АргументыКоманднойСтроки);
	Исключение
		Если ПоказыватьСтекВызовов Тогда
			ПодробныйСтекВызовов = СтекВызововСтрокой(ИнформацияОбОшибке());
			Лог.Ошибка("Стек трейс:
			|" + ПодробныйСтекВызовов);
		КонецЕсли;
		// основную ошибку покажем ниже стека вызовов, чтобы пользователю не пришлось скроллить
		Лог.Ошибка(ОписаниеОшибки());

		ВременныеФайлы.Удалить(); // todo: перехватчик "ПриЗавершенииПриложения" в ОСени?

		КодСостояния = 1; // todo: возврат кода состояния рогатки как ExitCodeGenerator?
	КонецПопытки;

	ЗавершитьРаботу(КодСостояния); // todo: прям не хорошо

КонецПроцедуры

&Рогатка(ЗапускатьВФоне = Ложь)
Процедура ПриСозданииОбъекта()
	Лог = Логирование.ПолучитьЛог("oscript.lib.autumn-cli");
КонецПроцедуры

// Получить стек вызовов строкой для выдачи в логи
//
// Параметры:
//   ИнформацияОбОшибке - ИнформацияОбОшибке - ошибка
//
//  Возвращаемое значение:
//   Строка
//
Функция СтекВызововСтрокой(Знач ИнформацияОбОшибке) Экспорт
	СтекВызовов_ = ИнформацияОбОшибке.ПолучитьСтекВызовов();
	МассивТекстИсключения = Новый Массив;

	Отступ = "";
	СимволОтступа = "  ";
	ПервыйКадр = Истина;
	Для Каждого КадрСтекаВызовов Из СтекВызовов_ Цикл
		// пропустим первый кадр стека, т.к. он ведет на служебный вызов исключения
		Если ПервыйКадр Тогда
			ПервыйКадр = Ложь;
			Продолжить;
		КонецЕсли;
		
		ЭтоКадрСтекаИзОсени = СтрНачинаетсяС(КадрСтекаВызовов.Метод, "ДекораторВнутренний_")
			И СтрНачинаетсяС(КадрСтекаВызовов.ИмяМодуля, "<string");
		Если ЭтоКадрСтекаИзОсени Тогда
			Прервать;
		КонецЕсли;

		Отступ = Отступ + СимволОтступа;

		СтрокаСтекТрейса = СтрШаблон(
			"%1%2 / Метод %3 / Строка %4",
			Отступ,
			КадрСтекаВызовов.ИмяМодуля,
			КадрСтекаВызовов.Метод,
			Формат(КадрСтекаВызовов.НомерСтроки, "ЧГ=")
		);
		МассивТекстИсключения.Добавить(СтрокаСтекТрейса);
	КонецЦикла;

	Возврат СтрСоединить(МассивТекстИсключения, Символы.ПС);

КонецФункции
