
#Использовать tempfiles
#Использовать v8runner

Перем КаталогБазыАгента;
Перем ЗапущенныеАгенты;
Перем ПодключенныеАгенты;

Функция СоздатьАгента() Экспорт

	Агент = ИнициализироватьАгент();
	Агент.Запустить();
	ЗапущенныеАгенты.Добавить(Агент);

	Возврат Агент;

КонецФункции

Функция ПодключитьсяКАгенту() Экспорт

	Агент = ИнициализироватьАгент();
	Агент.Подключиться();

	ПодключенныеАгенты.Добавить(Агент);

	Возврат Агент;

КонецФункции

Функция ИнициализироватьАгент()

	СтрокаСоединения = СтрШаблон("/F ""%1""", КаталогБазыАгента);
	Агент = Новый АгентКонфигуратора();
	Агент
		.УстановитьПараметрыБазы(СтрокаСоединения, , ВременныеФайлы.СоздатьКаталог("v8agent-path"))
		.УстановитьПараметрыПодключения("127.0.0.1", 6777)
		.УстановитьПараметрыАвторизации("admin", "1");

	Возврат Агент;

КонецФункции

Функция СоздатьИБ() Экспорт

	ИмяКаталога = ВременныеФайлы.СоздатьКаталог("v8agent-db");

	Конфигуратор = Новый УправлениеКонфигуратором();
	Конфигуратор.СоздатьФайловуюБазу(ИмяКаталога);
	Конфигуратор.УстановитьКонтекст(СтрШаблон("/F ""%1""", ИмяКаталога), "", "");

	ФайлВыгрузки = ОбъединитьПути(КаталогФикстур(), "agent-db.dt");
	Конфигуратор.ЗагрузитьИнформационнуюБазу(ФайлВыгрузки);

	КаталогБазыАгента = ИмяКаталога;

	Возврат ИмяКаталога;

КонецФункции

Функция КаталогФикстур()

	Возврат ОбъединитьПути(ТекущийСценарий().Каталог, "..", "..", "fixtures");

КонецФункции

Процедура ОчиститьДанныеТестКейса() Экспорт

	Для Каждого Агент Из ПодключенныеАгенты Цикл

		Агент.Отключиться();

	КонецЦикла;

	Для Каждого Агент Из ЗапущенныеАгенты Цикл

		Агент.ЗавершитьРаботуАгента();

	КонецЦикла;

	Для Каждого Файл Из НайтиФайлы(КаталогВременныхФайлов(), "*v8agent*") Цикл

		УдалитьФайлы(Файл.ПолноеИмя);

	КонецЦикла;

	ЗапущенныеАгенты.Очистить();
	ПодключенныеАгенты.Очистить();

	ВременныеФайлы.Удалить();

КонецПроцедуры

Функция ПолучитьВерсиюПредприятия() Экспорт

	Конфигуратор = Новый УправлениеКонфигуратором();
	Путь = Конфигуратор.ПутьКПлатформе1С();

	ЧастиПути = СтрРазделить(Путь, ПолучитьРазделительПути());

	Для Инд = 1 По ЧастиПути.Количество() Цикл

		Часть = ЧастиПути[ЧастиПути.Количество() - Инд];

		Если СтрНачинаетсяС(Часть, "8.") Тогда

			Возврат Часть;

		КонецЕсли;

	КонецЦикла;

	ВызватьИсключение "Не удалось определить версию платформы";

КонецФункции

ЗапущенныеАгенты = Новый Массив();
ПодключенныеАгенты = Новый Массив();
