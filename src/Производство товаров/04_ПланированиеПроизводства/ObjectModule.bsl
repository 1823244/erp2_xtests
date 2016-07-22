﻿Перем КонтекстЯдра;
Перем Ожидаем;
Перем Утверждения;
Перем ГенераторТестовыхДанных;
Перем ЗапросыИзБД;
Перем УтвержденияПроверкаТаблиц;

Перем СтруктураДанных;

#Область ЮнитТестирование

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	ГенераторТестовыхДанных = КонтекстЯдра.Плагин("СериализаторMXL");
	ЗапросыИзБД = КонтекстЯдра.Плагин("ЗапросыИзБД");
	УтвержденияПроверкаТаблиц = КонтекстЯдра.Плагин("УтвержденияПроверкаТаблиц");
	
	СтруктураДанных = ПолучитьСтруктуруДанных();
	
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	НаборТестов.Добавить("РассчитатьГрафик");
	НаборТестов.Добавить("СкорректироватьДаты");
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
КонецПроцедуры

Функция РазрешенСлучайныйПорядокВыполненияТестов() Экспорт
	
	Возврат Ложь;
	
КонецФункции

#КонецОбласти

Процедура РассчитатьГрафик() Экспорт
	
	Для каждого ЗаказНаПроизводство из СтруктураДанных.МассивЗаказов Цикл
		РассчитатьГрафикПоЗаказу(ЗаказНаПроизводство);
	КонецЦикла;	
	
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

Процедура СкорректироватьДаты() Экспорт
	
	Для каждого ЗаказНаПроизводство из СтруктураДанных.МассивЗаказов Цикл
		СкорректироватьДатыПоЗаказу(ЗаказНаПроизводство);
	КонецЦикла;	
	
КонецПроцедуры	

Процедура СкорректироватьДатыПоЗаказу(ЗаказНаПроизводство) Экспорт
	
	ЗаказОбъект = ЗаказНаПроизводство.ПолучитьОбъект();
	Если Ложь Тогда
		ЗаказОбъект = Документы.ЗаказНаПроизводство.СоздатьДокумент();
	КонецЕсли;
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ПродукцияГрафик Цикл
		СтрокаТЧ.Начало    = '2016-01-01';
		СтрокаТЧ.Окончание = '2016-01-25';
	КонецЦикла;
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ЭтапыГрафик Цикл
		
		СтрокаТЧ.НачалоПредварительногоБуфера = '2016-01-01';
		СтрокаТЧ.ОкончаниеЗавершающегоБуфера  = '2016-01-25';
		
		СтрокаТЧ.НачалоЭтапа    = '2016-01-01';
		СтрокаТЧ.ОкончаниеЭтапа = '2016-01-25';
		
	КонецЦикла;
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ВыходныеИзделияГрафик Цикл
		СтрокаТЧ.ДатаЗапуска = '2016-01-01';
		СтрокаТЧ.ДатаВыпуска = '2016-01-25';
	КонецЦикла;	
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ВозвратныеОтходыГрафик Цикл
		СтрокаТЧ.ДатаВыпуска = '2016-01-25';
	КонецЦикла;	
	
	Для каждого СтрокаТЧ из ЗаказОбъект.МатериалыИУслугиГрафик Цикл
		СтрокаТЧ.ДатаПотребности = '2016-01-01';
	КонецЦикла;	
	
	Для каждого СтрокаТЧ из ЗаказОбъект.ТрудозатратыГрафик Цикл
		СтрокаТЧ.ДатаПотребности = '2016-01-01';
	КонецЦикла;	
	
	ЗаказОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

Функция ПолучитьСтруктуруДанных()
	
	Макет = ПолучитьМакет("ЗаказНаПроизводство");
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоТабличномуДокументу(Макет);
	
	МассивЗаказов = Новый Массив;
	МассивЗаказов.Добавить(Структура.ЗаказНаПроизводство1);
	
	Структура.Вставить("МассивЗаказов", МассивЗаказов);
	
	Возврат Структура;
	
КонецФункции




