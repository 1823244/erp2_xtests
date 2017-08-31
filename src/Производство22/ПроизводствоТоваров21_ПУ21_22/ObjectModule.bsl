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
	
	НаборТестов.НачатьГруппу("ПроизводствоТоваров - 1 Передел + Отходы", Истина);
	НаборТестов.Добавить("ПроверитьКонстанты");
	НаборТестов.Добавить("УдалитьДокументы");
	НаборТестов.Добавить("Спецификация");
	НаборТестов.Добавить("ЗаказНаПроизводство");
	НаборТестов.Добавить("ПланированиеПроизводства");
	НаборТестов.Добавить("МаршрутныйЛист");
	НаборТестов.Добавить("ПоступлениеТоваров");
	НаборТестов.Добавить("ВыполнениеМаршрутногоЛиста");
	НаборТестов.Добавить("ВыпускПродукции");
	НаборТестов.Добавить("ПередачаМатериаловВПроизводство");
	//
	НаборТестов.Добавить("РТУ");
	НаборТестов.Добавить("СчетФактура");
	НаборТестов.Добавить("РасчетСебестоимости");
	НаборТестов.Добавить("ОСВ");
	
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

Процедура ПроверитьКонстанты() Экспорт
	
	Утверждения.ПроверитьРавенство(Константы.ПартионныйУчетВерсии22.Получить(), Истина, "Не включен партионный учет 2.2");
	Утверждения.ПроверитьМеньшеИлиРавно(Константы.ДатаПереходаНаПартионныйУчетВерсии22.Получить(), '2017-07-01', "Дата перехода на партионный учет 2.2 должна быть меньше или равно 01.07.2017");
	
КонецПроцедуры	

Процедура УдалитьДокументы() Экспорт
	
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	РаботаСДокументами.УдалитьДокументыПоОрганизации(Структура.Организация);
	
	КонтекстЯдра.СохранитьКонтекст(Структура);
	
КонецПроцедуры	

Процедура Спецификация() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Спецификация");
	ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(СтруктураДанных, Структура, Истина);
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

//ЗаказНаПроизводство
Процедура ЗаказНаПроизводство() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "ЗаказНаПроизводство");
	ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(СтруктураДанных, Структура, Истина);
	
	МассивДокументов = Новый Массив;
	МассивДокументов.Добавить(СтруктураДанных.ЗаказНаПроизводствоГП1);
	МассивДокументов.Добавить(СтруктураДанных.ЗаказНаПроизводствоПФ);
	
	Для каждого ЗаказНапроизводство из МассивДокументов Цикл
		
		ДокументОбъект = ЗаказНапроизводство.ПолучитьОбъект();
		
		КэшированныеЗначения = Неопределено;
		МассивДанных = Новый Массив;
		Для каждого СтрокаТЧ из ДокументОбъект.Продукция Цикл
			МассивДанных.Добавить(ДанныеПоНоменклатуре(СтрокаТЧ, ДокументОбъект));
		КонецЦикла;	
		
		ПланированиеПроизводства.ЗаполнитьДанныеСпецификаций(ДокументОбъект, МассивДанных, КэшированныеЗначения);
		
		ДокументОбъект.Записать(РежимЗаписиДокумента.Запись);
		ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
	КонецЦикла;
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

Функция ДанныеПоНоменклатуре(ДанныеСтроки, РеквизитыЗаказа)
	
	ДанныеПоНоменклатуре = Новый Структура;
	
	ДанныеПоНоменклатуре.Вставить("КлючСвязиПродукция",     ДанныеСтроки.КлючСвязи);
	ДанныеПоНоменклатуре.Вставить("Номенклатура",           ДанныеСтроки.Номенклатура);
	ДанныеПоНоменклатуре.Вставить("Характеристика",         ДанныеСтроки.Характеристика);
	ДанныеПоНоменклатуре.Вставить("Склад",                  ДанныеСтроки.Склад);
	ДанныеПоНоменклатуре.Вставить("Подразделение",          ДанныеСтроки.Подразделение);
	ДанныеПоНоменклатуре.Вставить("Спецификация",           ДанныеСтроки.Спецификация);
	ДанныеПоНоменклатуре.Вставить("Количество",             ДанныеСтроки.Количество);
	ДанныеПоНоменклатуре.Вставить("Упаковка",               ДанныеСтроки.Упаковка);
	ДанныеПоНоменклатуре.Вставить("НачалоПроизводства",     ДанныеСтроки.НачатьНеРанее);
	ДанныеПоНоменклатуре.Вставить("ДатаПотребности",        ДанныеСтроки.НачатьНеРанее);
	ДанныеПоНоменклатуре.Вставить("КлючСвязиПолуфабрикат");
	ДанныеПоНоменклатуре.Вставить("КлючСвязиЭтапы");
	
	ДанныеПоНоменклатуре.Вставить("Назначение",             ДанныеСтроки.Назначение);
	ДанныеПоНоменклатуре.Вставить("НазначениеЗаказа",       РеквизитыЗаказа.Назначение);
	
	ДанныеПоНоменклатуре.Вставить("ПодразделениеДиспетчер", РеквизитыЗаказа.Подразделение);
	
	Возврат ДанныеПоНоменклатуре;
	
КонецФункции

//ПланированиеПроизводства
Процедура ПланированиеПроизводства() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	РассчитатьГрафикПоЗаказу(СтруктураДанных.ЗаказНаПроизводствоПФ);
	СкорректироватьДатыПоЗаказу(СтруктураДанных.ЗаказНаПроизводствоПФ);
	
	РассчитатьГрафикПоЗаказу(СтруктураДанных.ЗаказНаПроизводствоГП1);
	СкорректироватьДатыПоЗаказу(СтруктураДанных.ЗаказНаПроизводствоГП1);
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

Процедура РассчитатьГрафикПоЗаказу(ЗаказНаПроизводство) Экспорт
	
	Результат = ПланированиеПроизводстваВызовСервера.РассчитатьГрафикВыпуска(ЗаказНаПроизводство);
	
	// ПланированиеПроизводстваКлиент.ПланироватьОчередьЗаказов()
	Если НЕ Результат.Запланирован Тогда
		
		Для каждого Ошибка из Результат.Ошибки Цикл
			
			ТекстСообщения = "";
			
			Если ТипЗнч(Ошибка.ВидыРабочихЦентров) = Тип("Массив") Тогда
				
				Для каждого ВидРабочегоЦентра из Ошибка.ВидыРабочихЦентров Цикл
					
					ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Доступности вида рабочего центра %1 недостаточно для размещения этапа.'"),
						ВидРабочегоЦентра.НаименованиеВидаРабочегоЦентра);
					
					ВызватьИсключение ТекстСообщения;
					
				КонецЦикла;
				
			Иначе
				
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Не установлен график, по которому работает подразделение %1.'"),
					Ошибка.ВидыРабочихЦентров);
					
					ВызватьИсключение ТекстСообщения;
					
			КонецЕсли;
				
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура СкорректироватьДатыПоЗаказу(ЗаказНаПроизводство) Экспорт
	
	ЗаказОбъект = ЗаказНаПроизводство.ПолучитьОбъект();
	Если Ложь Тогда
		ЗаказОбъект = Документы.Данные.СоздатьДокумент();
	КонецЕсли;
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ПродукцияГрафик Цикл
		СтрокаТЧ.Начало    = '2017-07-01';
		СтрокаТЧ.Окончание = '2017-07-25';
	КонецЦикла;
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ЭтапыГрафик Цикл
		
		СтрокаТЧ.НачалоПредварительногоБуфера = '2017-07-01';
		СтрокаТЧ.ОкончаниеЗавершающегоБуфера  = '2017-07-25';
		
		СтрокаТЧ.НачалоЭтапа    = '2017-07-01';
		СтрокаТЧ.ОкончаниеЭтапа = '2017-07-25';
		
	КонецЦикла;
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ВыходныеИзделияГрафик Цикл
		СтрокаТЧ.ДатаЗапуска = '2017-07-01';
		СтрокаТЧ.ДатаВыпуска = '2017-07-25';
	КонецЦикла;	
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ВозвратныеОтходыГрафик Цикл
		СтрокаТЧ.ДатаВыпуска = '2017-07-25';
	КонецЦикла;	
	
	Для каждого СтрокаТЧ из ЗаказОбъект.МатериалыИУслугиГрафик Цикл
		СтрокаТЧ.ДатаПотребности = '2017-07-01';
	КонецЦикла;	
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ТрудозатратыГрафик Цикл
		СтрокаТЧ.ДатаПотребности = '2017-07-01';
	КонецЦикла;	
	
	ЗаказОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

//МаршрутныйЛист
Процедура МаршрутныйЛист() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	МассивЗаказов = Новый Массив;
	МассивЗаказов.Добавить(СтруктураДанных.ЗаказНаПроизводствоГП1);
	МассивЗаказов.Добавить(СтруктураДанных.ЗаказНаПроизводствоПФ);
	
	Результат = ОперативныйУчетПроизводстваВызовСервера.СформироватьМаршрутныеЛистыПоЗаказам(МассивЗаказов);
	Если НЕ Результат.Выполнено Тогда
		//ВызватьИсключение "Маршрутный лист на ГП сформирован";
	КонецЕсли;	
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

//ПоступлениеТоваров
Процедура ПоступлениеТоваров() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "ПТУ");
	ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(СтруктураДанных, Структура, Истина);
	
	МассивДокументов = Новый Массив;
	МассивДокументов.Добавить(СтруктураДанных.ПоступлениеТоваровИУслуг1);
	МассивДокументов.Добавить(СтруктураДанных.ПоступлениеТоваровИУслуг2);
	
	Для каждого ДокументСсылка из МассивДокументов Цикл
		ДокументОбъект = ДокументСсылка.ПолучитьОбъект();
		ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	КонецЦикла;	
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

//ВыполнениеМаршрутногоЛиста
Процедура ВыполнениеМаршрутногоЛиста() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	МассивЗаказов = Новый Массив;
	МассивЗаказов.Добавить(СтруктураДанных.ЗаказНаПроизводствоГП1);
	МассивЗаказов.Добавить(СтруктураДанных.ЗаказНаПроизводствоПФ);
		
	МассивМаршрутныхЛистов = ПолучитьМассивМаршрутныхЛистов(МассивЗаказов);
	
	Для каждого МаршрутныйЛист из МассивМаршрутныхЛистов Цикл
		УстановитьОтметкиМаршрутногоЛиста(МаршрутныйЛист);
	КонецЦикла;	
	
	СтруктураДанных.Вставить("МассивМаршрутныхЛистов", МассивМаршрутныхЛистов);
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

Процедура УстановитьОтметкиМаршрутногоЛиста(МаршрутныйЛист) Экспорт
	
	ДокументОбъект = МаршрутныйЛист.ПолучитьОбъект();
	Если Ложь Тогда
		ДокументОбъект = Документы.МаршрутныйЛистПроизводства.СоздатьДокумент();
	КонецЕсли;	
	
	ДокументОбъект.Дата   = '2017-07-01';
	ДокументОбъект.Статус = Перечисления.СтатусыМаршрутныхЛистовПроизводства.Выполняется;
	ДокументОбъект.ПриИзмененииСтатуса(, '2017-07-01');
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
	Если ДокументОбъект.Трудозатраты.Количество() > 0 Тогда
		ДокументОбъект.Трудозатраты[0].Бригада = Справочники.Бригады.НайтиПоНаименованию("Бригада (Авто-тест)");
	//	ДокументОбъект.Трудозатраты[0].КоличествоФакт = 0;
	//	ДокументОбъект.Трудозатраты[0].КоличествоОтклонение = -ДокументОбъект.Трудозатраты[0].Количество;
	КонецЕсли;	
	
	ДокументОбъект.Статус = Перечисления.СтатусыМаршрутныхЛистовПроизводства.Выполнен;
	ДокументОбъект.ПриИзмененииСтатуса(, '2017-07-25');
	
	Если ДокументОбъект.ФактическоеОкончание = НачалоДня(ДокументОбъект.ФактическоеОкончание) Тогда
		ДокументОбъект.ФактическоеОкончание = ДокументОбъект.ФактическоеОкончание + 1;
	КонецЕсли;	
	
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры	

Функция ПолучитьМассивМаршрутныхЛистов(МассивЗаказов) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Параметры.Вставить("МассивЗаказов", МассивЗаказов);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Док.Ссылка
	|ИЗ
	|	Документ.МаршрутныйЛистПроизводства КАК Док
	|ГДЕ
	|	Док.Распоряжение В (&МассивЗаказов)";
	
	Результат = Запрос.Выполнить();
	Возврат Результат.Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции	

Процедура ВыпускПродукции() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
		
		МассивЗаказов = Новый Массив;
		МассивЗаказов.Добавить(СтруктураДанных.ЗаказНаПроизводствоГП1);
		МассивЗаказов.Добавить(СтруктураДанных.ЗаказНаПроизводствоПФ);
		
		МассивМаршрутныхЛистов = ПолучитьМассивМаршрутныхЛистов(МассивЗаказов);
		СтруктураДанных.Вставить("МассивМаршрутныхЛистов", МассивМаршрутныхЛистов);
		
	КонецЕсли;	
	
	Для каждого МаршрутныйЛист из СтруктураДанных.МассивМаршрутныхЛистов Цикл
		ВыпускПродукцииПоМаршрутномуЛисту(МаршрутныйЛист);
	КонецЦикла;	
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры

//ВыпускПродукции
Процедура ВыпускПродукцииПоМаршрутномуЛисту(МаршрутныйЛист) Экспорт
	
	// ВводНаОснованииУТКлиент.СоздатьНаОснованииМаршрутныхЛистов
	МассивСсылок = Новый Массив;
	МассивСсылок.Добавить(МаршрутныйЛист);
	
	ТекстПредупреждения = Неопределено;
	ПараметрыОформления = Документы.ВыпускПродукции.ПараметрыОформленияВыпуска(МассивСсылок, Неопределено, ТекстПредупреждения);
	Если ПараметрыОформления = Неопределено Тогда
		//Проверять не будем. Если есть, то перезаполним
		ВызватьИсключение ТекстПредупреждения;
	КонецЕсли;
	
	ДокументОбъект = Документы.ВыпускПродукции.СоздатьДокумент();
	ДокументОбъект.Заполнить(МассивСсылок[0]);
	ДокументОбъект.Дата = '2017-07-31';
	
	//Утверждения.ПроверитьРавенство(ДокументОбъект.Товары.Количество(), 1, "В документе Выпуск продукциидолжно быть 1 строка");
	
	Для каждого СтрокаТЧ из ДокументОбъект.Товары Цикл
		
		Если СтрокаТЧ.ТипСтоимости = Перечисления.ТипыСтоимостиВыходныхИзделий.Фиксированная Тогда
			СтрокаТЧ.Цена  = СтрокаТЧ.НомерСтроки * 10;
			СтрокаТЧ.Сумма = СтрокаТЧ.Количество * СтрокаТЧ.Цена;
		КонецЕсли;	
		
	КонецЦикла;	
	
	ДокументОбъект.Записать();
	
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

//ПередачаМатериаловВПроизводство
Процедура ПередачаМатериаловВПроизводство() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	ПередачаМатериаловПоПодразделению(СтруктураДанных, СтруктураДанных.ПодразделениеПФ);
	ПередачаМатериаловПоПодразделению(СтруктураДанных, СтруктураДанных.Подразделение1);
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

Процедура ПередачаМатериаловПоПодразделению(СтруктураДанных, Подразделение) Экспорт
	
	ПараметрыДанных = Новый Структура;
	ПараметрыДанных.Вставить("Организация",   СтруктураДанных.Организация);
	ПараметрыДанных.Вставить("Подразделение", Подразделение);
	ПараметрыДанных.Вставить("Склад",         СтруктураДанных.СкладПроизводство);
	ПараметрыДанных.Вставить("ЗаказыПоДату",  '0001-01-01');
	
	АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено);
	Обработки.ПолучениеИВозвратМатериалов.ПолучитьДанные(ПараметрыДанных, АдресХранилища);
	
	Данные = ПолучитьИзВременногоХранилища(АдресХранилища);
	
	РеквизитыШапки = Новый Структура;
	РеквизитыШапки.Вставить("Организация",   СтруктураДанных.Организация);
	РеквизитыШапки.Вставить("Подразделение", Подразделение);
	РеквизитыШапки.Вставить("Склад",         СтруктураДанных.СкладПроизводство);
	РеквизитыШапки.Вставить("ХозяйственнаяОперация", ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ПередачаВПроизводство"));
	
	ДанныеДляЗаполненияТовары = Новый ТаблицаЗначений;
	ДанныеДляЗаполненияТовары.Колонки.Добавить("Номенклатура");
	ДанныеДляЗаполненияТовары.Колонки.Добавить("Характеристика");
	ДанныеДляЗаполненияТовары.Колонки.Добавить("КоличествоУпаковок");
	ДанныеДляЗаполненияТовары.Колонки.Добавить("Количество");
	ДанныеДляЗаполненияТовары.Колонки.Добавить("Назначение");
	ДанныеДляЗаполненияТовары.Колонки.Добавить("Серия");
	
	Для каждого ДанныеСтроки Из Данные Цикл
		ДанныеДляЗаполнения = ДанныеДляЗаполненияТовары.Добавить();
		ЗаполнитьЗначенияСвойств(ДанныеДляЗаполнения, ДанныеСтроки);
		
		ДанныеДляЗаполнения.Количество = -ДанныеСтроки.Остаток;
		ДанныеДляЗаполнения.КоличествоУпаковок = ДанныеДляЗаполнения.Количество;
	КонецЦикла;	
		
	ПараметрыОснования = Новый Структура;
	ПараметрыОснования.Вставить("Товары",         ДанныеДляЗаполненияТовары);
	ПараметрыОснования.Вставить("РеквизитыШапки", РеквизитыШапки);
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Док.Ссылка
	|ИЗ
	|	Документ.ПередачаМатериаловВПроизводство КАК Док
	|ГДЕ
	|	Док.Организация = &Организация
	|	И Док.Подразделение = &Подразделение
	|	И Док.Склад = &Склад
	|	И НАЧАЛОПЕРИОДА(Док.Дата, ДЕНЬ) = &Дата
	|	И НЕ Док.ПометкаУдаления";
	
	Запрос.Параметры.Вставить("Организация",   СтруктураДанных.Организация);
	Запрос.Параметры.Вставить("Подразделение", Подразделение);
	Запрос.Параметры.Вставить("Склад",         СтруктураДанных.СкладПроизводство);
	Запрос.Параметры.Вставить("Дата",          '2017-07-31');
	
	Результат = Запрос.Выполнить();
	Если НЕ Результат.Пустой() Тогда
		ДокументСсылка = Результат.Выгрузить()[0].Ссылка;
		ДокументОбъект = ДокументСсылка.ПолучитьОбъект();
		ДокументОбъект.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		
		ДокументОбъект.Товары.Очистить();
		ДокументОбъект.ВидыЗапасов.Очистить();
	Иначе	
		ДокументОбъект = Документы.ПередачаМатериаловВПроизводство.СоздатьДокумент();
	КонецЕсли;
	
	ДокументОбъект.Дата = '2017-07-31';
	ДокументОбъект.Заполнить(ПараметрыОснования);
	ДокументОбъект.ПотреблениеДляДеятельности = Перечисления.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС;
	ДокументОбъект.Статус = Перечисления.СтатусыПередачМатериаловВПроизводство.Принято;
	ДокументОбъект.Записать();
	
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);

КонецПроцедуры

//РТУ
Процедура РТУ() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "РТУ");
	ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(СтруктураДанных, Структура, Истина);
	
	МассивДокументов = Новый Массив;
	МассивДокументов.Добавить(СтруктураДанных.РТУ1);
	МассивДокументов.Добавить(СтруктураДанных.РТУ2);
	
	РаботаСДокументами.ПровестиДокументы(МассивДокументов);
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

//СчетФактура
Процедура СчетФактура() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	СформироватьСчетФактуруПоРеализации(СтруктураДанных, СтруктураДанных.РТУ1, "1");
	СформироватьСчетФактуруПоРеализации(СтруктураДанных, СтруктураДанных.РТУ2, "2");
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

//СчетФактура
Процедура СформироватьСчетФактуруПоРеализации(СтруктураДанных, ДокументРеализации, Номер = "") Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	РеквизитыСчетаФактуры = Неопределено;
	ПараметрыОтбора = Новый Структура("Организация", СтруктураДанных.Организация);
	СчетаФактуры = Документы.СчетФактураВыданный.СчетаФактурыПоОснованию(ДокументРеализации, ПараметрыОтбора, РеквизитыСчетаФактуры);
	
	Если СчетаФактуры.Количество() > 0 Тогда
		ДокументОбъект = РеквизитыСчетаФактуры.Ссылка.ПолучитьОбъект();
		ДокументОбъект.ДокументыОснования.Очистить();
	Иначе
		ДокументОбъект = Документы.СчетФактураВыданный.СоздатьДокумент();
		ДокументОбъект.Дата = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДокументРеализации, "Дата");
		ДокументОбъект.ДатаВыставления = ДокументОбъект.Дата;
	КонецЕсли;	
	
	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("ДокументОснование", ДокументРеализации);
	ДанныеЗаполнения.Вставить("Организация",       СтруктураДанных.Организация);
	
	ДокументОбъект.Заполнить(ДанныеЗаполнения);
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
	СтруктураДанных.Вставить("СчетФактура" + Номер, ДокументОбъект.Ссылка);
	
КонецПроцедуры	

//РасчетСебестоимости
Процедура РасчетСебестоимости() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	РаботаСДокументами.ЗакрытьМесяц(СтруктураДанных.Организация, '2017-07-01');
	//РаботаСДокументами.ЗакрытьМесяц(СтруктураДанных.Организация, '2017-07-01');
	
	Результат = ПартииНезавершенногоПроизводства(СтруктураДанных.Организация, '2017-08-01');
	Утверждения.ПроверитьИстину(Результат, "Обнаружены остатки  по регистру ПартииНезавершенногоПроизводства");
	
	Результат = СебестоимостьТоваров(СтруктураДанных.Организация, '2017-08-01');
	Утверждения.ПроверитьИстину(Результат, "Обнаружены остатки  по регистру СебестоимостьТоваров");
	
КонецПроцедуры	

//ОСВ
Процедура ОСВ() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	ТабДокОСВ = СформироватьОСВ(СтруктураДанных.Организация);
	ТабДокОригинал = ПолучитьМакет("ОСВ");
	
	УтвержденияПроверкаТаблиц.ПроверитьРавенствоТабличныхДокументовТолькоПоЗначениям(ТабДокОСВ, ТабДокОригинал);
	
КонецПроцедуры	

#КонецОбласти

#Область Проверки

Функция ПартииНезавершенногоПроизводства(Организация, Период)
	
	Запрос = Новый Запрос;
	Запрос.Параметры.Вставить("Организация", Организация);
	Запрос.Параметры.Вставить("Период",        Период);
	
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
	|	Рег.КоличествоОстаток,
	|	Рег.СтоимостьОстаток,
	|	Рег.СтоимостьБезНДСОстаток,
	|	Рег.СтоимостьРеглОстаток,
	|	Рег.НДСРеглОстаток,
	|	Рег.ПостояннаяРазницаОстаток,
	|	Рег.ВременнаяРазницаОстаток
	|ИЗ
	|	РегистрНакопления.ПартииНезавершенногоПроизводства.Остатки(&Период, Организация = &Организация) КАК Рег";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;	
	
КонецФункции

Функция СебестоимостьТоваров(Организация, Период)
	
	Запрос = Новый Запрос;
	Запрос.Параметры.Вставить("Организация", Организация);
	Запрос.Параметры.Вставить("Период",      Период);
	Запрос.Параметры.Вставить("РазделУчета", Перечисления.РазделыУчетаСебестоимостиТоваров.ПроизводственныеЗатраты);
	
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Рег.АналитикаУчетаНоменклатуры,
	|	Рег.РазделУчета,
	|	Рег.ВидЗапасов,
	|	Рег.Организация,
	|	Рег.КоличествоОстаток,
	|	Рег.СтоимостьОстаток,
	|	Рег.СтоимостьБезНДСОстаток,
	|	Рег.СуммаДопРасходовОстаток,
	|	Рег.СуммаДопРасходовБезНДСОстаток,
	|	Рег.СтоимостьРеглОстаток,
	|	Рег.ПостояннаяРазницаОстаток,
	|	Рег.ВременнаяРазницаОстаток
	|ИЗ
	|	РегистрНакопления.СебестоимостьТоваров.Остатки(
	|			&Период,
	|			Организация = &Организация
	|				И РазделУчета = &РазделУчета) КАК Рег";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;	
	
КонецФункции

Функция ПодготовитьПараметрыОтчета(Отчет)

	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("Организация"                      , Отчет.Организация);
	ПараметрыОтчета.Вставить("НачалоПериода"                    , Отчет.НачалоПериода);
	ПараметрыОтчета.Вставить("КонецПериода"                     , Отчет.КонецПериода);
	ПараметрыОтчета.Вставить("ВключатьОбособленныеПодразделения", Отчет.ВключатьОбособленныеПодразделения);
	ПараметрыОтчета.Вставить("ПоказательБУ"                     , Отчет.ПоказательБУ);
	ПараметрыОтчета.Вставить("ПоказательНУ"                     , Отчет.ПоказательНУ);
	ПараметрыОтчета.Вставить("ПоказательПР"                     , Отчет.ПоказательПР);
	ПараметрыОтчета.Вставить("ПоказательВР"                     , Отчет.ПоказательВР);
	ПараметрыОтчета.Вставить("ПоказательВалютнаяСумма"          , Мин(Отчет.ПоказательВалютнаяСумма, БухгалтерскийУчетПереопределяемый.ИспользоватьВалютныйУчет()));
	ПараметрыОтчета.Вставить("ПоказательКонтроль"               , Отчет.ПоказательКонтроль);
	ПараметрыОтчета.Вставить("ВыводитьЗабалансовыеСчета"        , Отчет.ВыводитьЗабалансовыеСчета);
	ПараметрыОтчета.Вставить("РазмещениеДополнительныхПолей"    , Отчет.РазмещениеДополнительныхПолей);
	ПараметрыОтчета.Вставить("ПоСубсчетам"                      , Отчет.ПоСубсчетам);
	ПараметрыОтчета.Вставить("Группировка"                      , Отчет.Группировка.Выгрузить());
	ПараметрыОтчета.Вставить("ДополнительныеПоля"               , Отчет.ДополнительныеПоля.Выгрузить());
	ПараметрыОтчета.Вставить("РазвернутоеСальдо"                , Отчет.РазвернутоеСальдо.Выгрузить());
	ПараметрыОтчета.Вставить("РежимРасшифровки"                 , Отчет.РежимРасшифровки);
	ПараметрыОтчета.Вставить("ВыводитьЗаголовок"                , Ложь);
	ПараметрыОтчета.Вставить("ВыводитьПодвал"                   , Ложь);
	ПараметрыОтчета.Вставить("ДанныеРасшифровки"                , Неопределено);
	ПараметрыОтчета.Вставить("МакетОформления"                  , Неопределено);
	ПараметрыОтчета.Вставить("СхемаКомпоновкиДанных"            , Отчет.ПолучитьМакет("СхемаКомпоновкиДанных"));
	ПараметрыОтчета.Вставить("ИдентификаторОтчета"              , "ОборотноСальдоваяВедомость");
	ПараметрыОтчета.Вставить("НастройкиКомпоновкиДанных"        , Отчет.КомпоновщикНастроек.ПолучитьНастройки());
	ПараметрыОтчета.Вставить("НаборПоказателей"                 , Отчеты[ПараметрыОтчета.ИдентификаторОтчета].ПолучитьНаборПоказателей());
    ПараметрыОтчета.Вставить("ОтветственноеЛицо"                , Перечисления.ОтветственныеЛицаОрганизаций.ОтветственныйЗаБухгалтерскиеРегистры);
    ПараметрыОтчета.Вставить("ВыводитьЕдиницуИзмерения"         , Ложь);
	
	Возврат ПараметрыОтчета;

КонецФункции

Функция СформироватьОСВ(Организация)
	
	Отчет = Отчеты.ОборотноСальдоваяВедомость.Создать();
	
	Отчет.НачалоПериода = '2017-01-01';
	Отчет.КонецПериода  = КонецМесяца('2017-07-01');
	Отчет.Организация   = Организация;
	Отчет.ПоказательБУ  = Истина;
	Отчет.ПоСубсчетам   = Истина;
	
	Отчет.КомпоновщикНастроек.Настройки.ДополнительныеСвойства.Вставить("ВыводитьЗаголовок", Ложь);
	Отчет.КомпоновщикНастроек.Настройки.ДополнительныеСвойства.Вставить("ВыводитьПодвал"   , Ложь);
	
	ПараметрыОтчета = ПодготовитьПараметрыОтчета(Отчет);
	
	АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено);
	БухгалтерскиеОтчетыВызовСервера.СформироватьОтчет(ПараметрыОтчета, АдресХранилища);
	
	Струткра = ПолучитьИзВременногоХранилища(АдресХранилища);
	Возврат Струткра.Результат;
	
КонецФункции

#КонецОбласти
