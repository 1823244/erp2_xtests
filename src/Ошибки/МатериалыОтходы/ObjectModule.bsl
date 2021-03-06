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
	
	//Материал и отход в одном маршрутном листе
	// Сиситема считает что-то остается к распределению
	// Исправление - ФактическоеОкончание в маршрутном листе не должно быть началом дня
	
	НаборТестов.НачатьГруппу("МатериалыОтходы", Истина);
	НаборТестов.Добавить("УдалитьДокументы");
	НаборТестов.Добавить("ПровестиДокументы");
	
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
КонецПроцедуры

Функция РазрешенСлучайныйПорядокВыполненияТестов() Экспорт
	
	Возврат Ложь;
	
КонецФункции

#КонецОбласти

#Область Тест

Процедура УдалитьДокументы() Экспорт
	
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Организация");
	РаботаСДокументами.УдалитьДокументыПоОрганизации(Структура.Организация);
	
	КонтекстЯдра.СохранитьКонтекст(Структура);
	
КонецПроцедуры	

Процедура ПровестиДокументы() Экспорт
	
	СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Данные");
	ПровестиВыбранныеДокументы(СтруктураДанных);
	
	Структура = КонтекстЯдра.ПолучитьКонтекст();
	
	Результат = МатериалыИРаботывПроизводстве(Структура.Организация, '2016-02-01');
	Утверждения.ПроверитьИстину(Результат, "Обнаружены остатки по регистру МатериалыИРаботыВПроизводстве");
	
	КРаспределению = РаспределениеЗатраты(Структура.Организация, '2016-01-01');
	Утверждения.ПроверитьРавенство(КРаспределению, 0, "Обнаружено количество к распределению");
	
КонецПроцедуры	

#КонецОбласти

#Область ВыполнениеТеста

Процедура ПровестиВыбранныеДокументы(СтруктураДанных)
	
	ДокументОбъект = СтруктураДанных.ЗаказНаПроизводство.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ЗаказНаПроизводство
	
	ДокументОбъект = СтруктураДанных.МаршрутныйЛистПроизводства1.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //МаршрутныйЛистПроизводства1
	
	ДокументОбъект = СтруктураДанных.ВыпускПродукции1.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ВыпускПродукции1
	
	ДокументОбъект = СтруктураДанных.ПоступлениеТоваровИУслуг.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ПоступлениеТоваровИУслуг
	
	ДокументОбъект = СтруктураДанных.ПередачаМатериаловВПроизводство.ПолучитьОбъект();
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение); //ПередачаМатериаловВПроизводство
	
КонецПроцедуры	

#КонецОбласти

#Область Проверки

Функция МатериалыИРаботывПроизводстве(Организация, Период)
	
	Запрос = Новый Запрос;
	Запрос.Параметры.Вставить("Организация", Организация);
	Запрос.Параметры.Вставить("Период",        Период);
	
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Рег.Организация,
	|	Рег.Номенклатура,
	|	Рег.Характеристика,
	|	Рег.Подразделение,
	|	Рег.Серия,
	|	Рег.Назначение,
	|	Рег.УдалитьАналитикаУчетаНоменклатуры,
	|	Рег.КоличествоОстаток
	|ИЗ
	|	РегистрНакопления.МатериалыИРаботыВПроизводстве.Остатки(&Период, Организация = &Организация) КАК Рег";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;	
	
КонецФункции

Функция РаспределениеЗатраты(Организация, Период)
	
	Запрос = Новый Запрос;
	Запрос.Текст = Документы.РаспределениеПроизводственныхЗатрат.ТекстЗапросаЗаполнитьПроизводственныеЗатраты();
	Запрос.УстановитьПараметр("НачалоПериода",		НачалоМесяца(Период));
	
	ГраницаДатаОкончания = Новый Граница(КонецМесяца(Период), ВидГраницы.Включая);
	Запрос.УстановитьПараметр("ГраницаОкончаниеПериода", ГраницаДатаОкончания);
	Запрос.УстановитьПараметр("ОкончаниеПериода",	     КонецМесяца(Период));
	Запрос.УстановитьПараметр("Организация",             Организация);
	Запрос.УстановитьПараметр("ВсеПодразделения",	     Истина);
	
	ПодразделениеПараметр = Новый Массив;
	ПодразделениеПараметр.Добавить(Справочники.СтруктураПредприятия.ПустаяСсылка());
	Запрос.УстановитьПараметр("Подразделения",	ПодразделениеПараметр);
	
	Результат = Запрос.Выполнить();
	ТаблицаЗатрат = Результат.Выгрузить();
	
	Возврат ТаблицаЗатрат.Итог("КРаспределению");
	
КонецФункции

#КонецОбласти

