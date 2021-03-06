#Использовать strings

Функция ОбернутьВКавычки(Строка) Экспорт

	Возврат """" + СтроковыеФункции.СократитьДвойныеКавычки(Строка) + """";

КонецФункции

Функция ВыполнитьКоманду(Приложение, Параметры, Выводить = Истина) Экспорт

	Команда = Новый Команда;
		
	Команда.УстановитьКоманду(Приложение);
	Команда.УстановитьКодировкуВывода(КодировкаТекста.UTF8);
	Команда.ДобавитьПараметры(Параметры);
	Команда.УстановитьИсполнениеЧерезКомандыСистемы(Ложь);
	Команда.ПоказыватьВыводНемедленно(Выводить);
	КодВозврата = Команда.Исполнить();

	Возврат КодВозврата;

КонецФункции

Процедура Пауза(КоличествоСекунд) Экспорт

	Параметры = Новый Массив();
	Параметры.Добавить("127.0.0.1");
	Параметры.Добавить("-n");
	Параметры.Добавить(Строка(КоличествоСекунд + 1));
	ВыполнитьКоманду("ping", Параметры, Ложь);

КонецПроцедуры

Функция ПрочитатьФайлЛога(ИмяФайла) Экспорт

	Файл = Новый Файл(ИмяФайла);

	Если НЕ Файл.Существует() Тогда

		Возврат "";

	КонецЕсли;

	Попытка

		Чтение = Новый ЧтениеТекста(ИмяФайла);
		ФайлЗаблокирован = Ложь;

	Исключение

		ФайлЗаблокирован = Истина;

	КонецПопытки;

	Если ФайлЗаблокирован Тогда

		ИмяКопииЛога = ИмяФайла + "-copy";
		КопироватьФайл(ИмяФайла, ИмяКопииЛога);
		Чтение = Новый ЧтениеТекста(ИмяКопииЛога);

	КонецЕсли;

	Текст = Чтение.Прочитать();
	Чтение.Закрыть();
	
	Если ФайлЗаблокирован Тогда

		УдалитьФайлы(ИмяКопииЛога);

	КонецЕсли;

	Возврат Текст;

КонецФункции

Функция ЭтоОтносительныйПуть(Путь) Экспорт

	Возврат Ложь;
	
КонецФункции

Функция ЭкранироватьПуть(Путь) Экспорт

	Возврат ОбернутьВКавычки(Путь);

КонецФункции

