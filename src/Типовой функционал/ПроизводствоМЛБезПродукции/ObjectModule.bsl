﻿Перем КонтекстЯдра;
Перем Ожидаем;
Перем Утверждения;
Перем ГенераторТестовыхДанных;
Перем ЗапросыИзБД;
Перем УтвержденияПроверкаТаблиц;

Перем РаботаСДокументами;

#Область ЮнитТестирование

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	ГенераторТестовыхДанных = КонтекстЯдра.Плагин("СериализаторMXL");
	ЗапросыИзБД = КонтекстЯдра.Плагин("ЗапросыИзБД");
	УтвержденияПроверкаТаблиц = КонтекстЯдра.Плагин("УтвержденияПроверкаТаблиц");
	
	РаботаСДокументами = КонтекстЯдра.Плагин("Plugin_РаботаСДокументами");
	
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	
	//Тест проверяет распределение материалов на заказы, у которых МЛ есть в разных месяцах
	//В типовой такая ситуация вдет к появлению незавершенки
	
	НаборТестов.Добавить("ПроизводствоМЛБезПродукции");
	
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область Тест

Процедура ПроизводствоМЛБезПродукции() Экспорт
	
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Организация");
	РаботаСДокументами.УдалитьДокументыПоОрганизации(Структура.Организация);
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Данные");
	ПровестиДокументы(СтруктураДанных);
	
	РаботаСДокументами.ЗакрытьМесяц(Структура.Организация, '2016-01-01');
	Результат = ПартииНезавершенногоПроизводства(Структура.Организация, '2016-02-01');
	Утверждения.ПроверитьРавенство (Результат, Истина, "Обнаружены остатки по регистру ПартииНезавершенногоПроизводства")
	
КонецПроцедуры

Процедура ПровестиДокументы(СтруктураДанных)
	
	ДокументОбъект = СтруктураДанных.ЗаказНаПроизводство.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ЗаказНаПроизводство
	
	ДокументОбъект = СтруктураДанных.МаршрутныйЛистПроизводства1.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //МаршрутныйЛистПроизводства1
	
	ДокументОбъект = СтруктураДанных.МаршрутныйЛистПроизводства2.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //МаршрутныйЛистПроизводства2
	
	ДокументОбъект = СтруктураДанных.ВыпускПродукции1.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ВыпускПродукции1
	
	ДокументОбъект = СтруктураДанных.ВыпускПродукции2.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ВыпускПродукции2
	
	ДокументОбъект = СтруктураДанных.ПоступлениеТоваровИУслуг.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ПоступлениеТоваровИУслуг
	
	ДокументОбъект = СтруктураДанных.ПередачаМатериаловВПроизводство.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ПередачаМатериаловВПроизводство
	
КонецПроцедуры	

#КонецОбласти

#Область Проверки

Функция ПартииНезавершенногоПроизводства(Организация, Дата)
	
	Запрос = Новый Запрос;
	Запрос.Параметры.Вставить("Период",      Дата);
	Запрос.Параметры.Вставить("Организация", Организация);
	
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Рег.Организация,
	|	Рег.АналитикаУчетаНоменклатуры,
	|	Рег.ВидЗапасов,
	|	Рег.ЗаказНаПроизводство,
	|	Рег.КодСтрокиПродукция,
	|	Рег.ДокументПоступления,
	|	Рег.Этап,
	|	Рег.СтатьяКалькуляции,
	|	Рег.АналитикаУчетаПартий,
	|	Рег.КоличествоОстаток КАК Количество,
	|	Рег.СтоимостьОстаток КАК Стоимость,
	|	Рег.СтоимостьБезНДСОстаток КАК СтоимостьБезНДС,
	|	Рег.СтоимостьРеглОстаток КАК СтоимостьРегл,
	|	Рег.НДСРеглОстаток КАК НДСРегл,
	|	Рег.ПостояннаяРазницаОстаток КАК ПостояннаяРазница,
	|	Рег.ВременнаяРазницаОстаток КАК ВременнаяРазница
	|ИЗ
	|	РегистрНакопления.ПартииНезавершенногоПроизводства.Остатки(&Период, Организация = &Организация) КАК Рег";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;	
	
КонецФункции

#КонецОбласти

