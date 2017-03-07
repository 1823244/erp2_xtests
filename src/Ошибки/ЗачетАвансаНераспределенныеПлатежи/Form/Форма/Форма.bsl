﻿&НаКлиенте
Перем КонтекстЯдра;
&НаКлиенте
Перем Ожидаем;
&НаКлиенте
Перем Утверждения;
&НаКлиенте
Перем ГенераторТестовыхДанных;
&НаКлиенте
Перем ЗапросыИзБД;
&НаКлиенте
Перем УтвержденияПроверкаТаблиц;

&НаКлиенте
Перем Форма;

#Область ЮнитТестирование

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	ГенераторТестовыхДанных = КонтекстЯдра.Плагин("СериализаторMXL");
	ЗапросыИзБД = КонтекстЯдра.Плагин("ЗапросыИзБД");
	УтвержденияПроверкаТаблиц = КонтекстЯдра.Плагин("УтвержденияПроверкаТаблиц");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	НаборТестов.Добавить("ЗачетАвансаНераспределенныеПлатежиБезДоговора");
КонецПроцедуры

&НаКлиенте
Процедура ПередЗапускомТеста() Экспорт
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗапускаТеста() Экспорт
	
	Попытка
		Форма.Модифицированность = Ложь;
		Форма.Закрыть();
	Исключение
	КонецПопытки;	
	
КонецПроцедуры

#КонецОбласти

&НаСервереБезКонтекста
Процедура ПровестиВыбранныеДокументы(СтруктураДанных)
	
	ДокументОбъект = СтруктураДанных.ЗаказКлиента1.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ЗаказКлиента1
	
	ДокументОбъект = СтруктураДанных.ПоступлениеБезналичныхДС1.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ПоступлениеДС
	
	ДокументОбъект = СтруктураДанных.ВзаимозачетЗадолженности1.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ВзаимозачетЗадолженности1
	
КонецПроцедуры

&НаКлиенте
Процедура ЗачетАвансаНераспределенныеПлатежиБезДоговора() Экспорт
	
	Макет = ПолучитьМакет("Ссылки");
	Ссылки = ГенераторТестовыхДанных.СоздатьДанныеПоТабличномуДокументу(Макет,,, Истина);
	УдалитьДокументыПоОрганизации(Ссылки.Организация);
	
	Макет = ПолучитьМакет();
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоТабличномуДокументу(Макет,,, Истина);
	
	ПровестиВыбранныеДокументы(СтруктураДанных);
	
	ПараметрыФормы = Новый Структура("Документ", СтруктураДанных.ЗаказКлиента1);
	Форма = ПолучитьФорму("Обработка.ПомощникЗачетаОплат.Форма", ПараметрыФормы);
	Форма.Открыть();
	
	ДоступноКЗачету = Форма.Оплаты[0].ДоступноКЗачету;
	Утверждения.ПроверитьРавенство(ДоступноКЗачету, 2000, "Не верная сумма доступно к зачету");
	
КонецПроцедуры	

&НаСервереБезКонтекста
Функция ПолучитьЗаказ(ДокументДС)
	
	Возврат ДокументДС.РасшифровкаПлатежа[0].Заказ;
	
КонецФункции	

&НаСервере
Функция ПолучитьМакет(ИмяМакета = "Данные")
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	Возврат ОбработкаОбъект.ПолучитьМакет(ИмяМакета);
	
КонецФункции

#Область УдалениеДокументов

&НаСервереБезКонтекста
Процедура УдалитьДокументыПоОрганизации(Организация)
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("Имя");
	Таблица.Колонки.Добавить("Отбор");
	
	ДобавитьДокумент(Таблица, "Документ.РасчетСебестоимостиТоваров");
	ДобавитьДокумент(Таблица, "Документ.РегламентнаяОперация");
	ДобавитьДокумент(Таблица, "Документ.ПереоценкаВалютныхСредств");
	ДобавитьДокумент(Таблица, "Документ.ПоступлениеБезналичныхДенежныхСредств");
	ДобавитьДокумент(Таблица, "Документ.СчетФактураПолученныйАванс");
	ДобавитьДокумент(Таблица, "Документ.СчетФактураВыданный");
	ДобавитьДокумент(Таблица, "Документ.СчетФактураВыданныйАванс");
	ДобавитьДокумент(Таблица, "Документ.ВзаимозачетЗадолженности");
	ДобавитьДокумент(Таблица, "Документ.РеализацияТоваровУслуг");
	ДобавитьДокумент(Таблица, "Документ.СписаниеБезналичныхДенежныхСредств");
	ДобавитьДокумент(Таблица, "Документ.ПоступлениеБезналичныхДенежныхСредств");
	ДобавитьДокумент(Таблица, "Документ.АктВыполненныхРабот");
	ДобавитьДокумент(Таблица, "Документ.РаспределениеПроизводственныхЗатрат");
	ДобавитьДокумент(Таблица, "Документ.СборкаТоваров");
	ДобавитьДокумент(Таблица, "Документ.ВыработкаСотрудников");
	ДобавитьДокумент(Таблица, "Документ.ВыпускПродукции");
	ДобавитьДокумент(Таблица, "Документ.ПередачаМатериаловВПроизводство");
	ДобавитьДокумент(Таблица, "Документ.ПеремещениеТоваров");
	ДобавитьДокумент(Таблица, "Документ.ЗаказНаПеремещение");
	ДобавитьДокумент(Таблица, "Документ.МаршрутныйЛистПроизводства");
	ДобавитьДокумент(Таблица, "Документ.СчетФактураПолученный");
	ДобавитьДокумент(Таблица, "Документ.ПоступлениеТоваровУслуг");
	ДобавитьДокумент(Таблица, "Документ.ПоступлениеУслугПрочихАктивов");
	ДобавитьДокумент(Таблица, "Документ.ПриемНаРаботу");
	ДобавитьДокумент(Таблица, "Документ.НачислениеЗарплаты");
	ДобавитьДокумент(Таблица, "Документ.ОтражениеЗарплатыВФинансовомУчете");
	ДобавитьДокумент(Таблица, "Документ.КорректировкаЗаказаМатериаловВПроизводство");
	ДобавитьДокумент(Таблица, "Документ.ЗаказНаПроизводство");
	ДобавитьДокумент(Таблица, "Документ.ЗаказКлиента");
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Док.Ссылка
	|ИЗ
	|	Документ.АвансовыйОтчет КАК Док
	|ГДЕ
	|	Док.Организация = &Организация";
	
	Запрос = Новый Запрос;
	Запрос.Параметры.Вставить("Организация", Организация);
	
	Для каждого СтрокаТЗ из Таблица Цикл
		
		Текст1 = СтрЗаменить(ТекстЗапроса, "Документ.АвансовыйОтчет", СтрокаТЗ.Имя);
		Текст1 = СтрЗаменить(Текст1, "Док.Организация", СтрокаТЗ.Отбор);
		
		Запрос.Текст = Текст1;
		ТаблицаДокументов = Запрос.Выполнить().Выгрузить();
		Для каждого Строка1 из ТаблицаДокументов Цикл
			
			ДокументОбъект = Строка1.Ссылка.ПолучитьОбъект();
			
			Если ДокументОбъект <> Неопределено Тогда
				
				Попытка
					ДокументОбъект.Удалить();
				Исключение
					//Сообщить(Строка(ТипЗнч(Объект)) + ": " + Строка(Объект));
				КонецПопытки;
				
			КонецЕсли;	
					
		КонецЦикла;	
		
	КонецЦикла;	
	
КонецПроцедуры	

&НаСервереБезКонтекста
Процедура ДобавитьДокумент(Таблица, Имя, Отбор = "Организация")
	
	НоваяСтрока = Таблица.Добавить();
	НоваяСтрока.Имя   = Имя;
	НоваяСтрока.Отбор = Отбор;
	
КонецПроцедуры	

#КонецОбласти
