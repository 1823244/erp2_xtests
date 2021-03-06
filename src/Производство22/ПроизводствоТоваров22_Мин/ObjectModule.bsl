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
	
	НаборТестов.НачатьГруппу("ПроизводствоТоваров - Мин", Истина);
	НаборТестов.Добавить("ПроверитьКонстанты");
	НаборТестов.Добавить("УдалитьДокументы");
	НаборТестов.Добавить("Спецификация");
	НаборТестов.Добавить("ЗаказНаПроизводство");
	НаборТестов.Добавить("ЭтапыПроизводства");
	НаборТестов.Добавить("ПоступлениеТоваров");
	НаборТестов.Добавить("ВыполнениеЭтаповПроизводства");
	НаборТестов.Добавить("ПередачаПродукции");
	НаборТестов.Добавить("ПередачаМатериаловВПроизводство");
	//
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
	
	Утверждения.ПроверитьРавенство(Константы.ИспользоватьУправлениеПроизводством2_2.Получить(), Истина, "Не включено использование производства 2.2");
	
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
	
	РаботаСДокументами.ПровестиДокумент(СтруктураДанных.ЗаказНаПроизводствоГП1);
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

Процедура ЭтапыПроизводства() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	МассивДокументов = Новый Массив;
	МассивДокументов.Добавить(СтруктураДанных.ЗаказНаПроизводствоГП1);
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Распоряжения", МассивДокументов);
	
	АдресХранилища = Неопределено;
	Документы.ЭтапПроизводства2_2.ОбеспечитьПотребностиПроизводстваВПродукцииИПолуфабрикатах(ПараметрыЗадания, АдресХранилища);
	
	МассивЭтаповПроизводства = ПолучитьМассивЭтаповПроизводства(МассивДокументов);
	Для каждого Этап из МассивЭтаповПроизводства Цикл
		ЭтапОбъект = Этап.ПолучитьОбъект();
		ЭтапОбъект.Дата = '2017-08-01';
		ЭтапОбъект.Записать(РежимЗаписиДокумента.Проведение);
	КонецЦикла;	
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

//ПланированиеПроизводства
Процедура ПланированиеПроизводства() Экспорт
	
	МетодикаУправленияПроизводством = Константы.МетодикаУправленияПроизводством.Получить();
	Если МетодикаУправленияПроизводством = Перечисления.МетодикаУправленияПроизводством.БезПланирования Тогда
		Возврат;
	КонецЕсли;	
	
КонецПроцедуры	

//ПоступлениеТоваров
Процедура ПоступлениеТоваров() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	Структура = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "ПТУ");
	ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(СтруктураДанных, Структура, Истина);
	
	РаботасДокументами.ПровестиДокумент(СтруктураДанных.ПоступлениеТоваровИУслуг1);
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

//ВыполнениеЭтаповПроизводства
Процедура ВыполнениеЭтаповПроизводства() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	МассивЭтаповПроизводства = ПолучитьМассивЭтаповПроизводства(СтруктураДанных.ЗаказНаПроизводствоГП1);
	Для каждого ЭтапПроизводства из МассивЭтаповПроизводства Цикл
		УстановитьОтметкиЭтапаПроизводства(ЭтапПроизводства, СтруктураДанных.Бригада, '2017-08-02');
	КонецЦикла;	
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

Процедура УстановитьОтметкиЭтапаПроизводства(ЭтапПроизводства, Бригада, Дата) Экспорт
	
	ДокументОбъект = ЭтапПроизводства.ПолучитьОбъект();
	Если Ложь Тогда
		ДокументОбъект = Документы.ЭтапПроизводства2_2.СоздатьДокумент();
	КонецЕсли;	
	
	ДокументОбъект.ПроизводствоОднойДатой = Истина;
	ДокументОбъект.ДатаПроизводства       = Дата;
	
	ДокументОбъект.ФактическоеНачалоЭтапа    = '2017-08-01';
	ДокументОбъект.ФактическоеОкончаниеЭтапа = Дата;
	Для каждого СтрокаТЧ из ДокументОбъект.ВыходныеИзделия Цикл
		СтрокаТЧ.ДатаПроизводства = Дата;
	КонецЦикла;	
	
	ПлановаяДатаПоступления = Дата;
	ДанныеЗаполнения = УправлениеПроизводством.ДанныеЗаполненияПриИзмененииСтатуса(
		ДокументОбъект, ПлановаяДатаПоступления);
	
	ИзмененныеРеквизиты = УправлениеПроизводством.ЗаполнитьРеквизитыЭтапаПриИзмененииОтметкиВыполнения(
		ДокументОбъект,
		ДанныеЗаполнения);
		
	Для каждого СтрокаТЧ из ДокументОбъект.Трудозатраты Цикл
		СтрокаТЧ.Бригада = Бригада;
		СтрокаТЧ.ДатаВыполнения = Дата;
	КонецЦикла;	
	
	Для каждого СтрокаТЧ из ДокументОбъект.ПобочныеИзделия Цикл
		СтрокаТЧ.Цена  = 10;
		СтрокаТЧ.Сумма = СтрокаТЧ.Количество * СтрокаТЧ.Цена;
	КонецЦикла;	
	
	// Нельзя записывать, а потом проводить
	//ДокументОбъект.Записать(РежимЗаписиДокумента.Запись);
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры	

Функция ПолучитьМассивЭтаповПроизводства(МассивЗаказов) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Параметры.Вставить("МассивЗаказов", МассивЗаказов);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Док.Ссылка
	|ИЗ
	|	Документ.ЭтапПроизводства2_2 КАК Док
	|ГДЕ
	|	Док.Распоряжение В(&МассивЗаказов)";
	
	Результат = Запрос.Выполнить();
	Возврат Результат.Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции	

//ПередачаПродукции
Процедура ПередачаПродукции() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	МассивЭтаповПроизводства = ПолучитьМассивЭтаповПроизводства(СтруктураДанных.ЗаказНаПроизводствоГП1);
	Для каждого ЭтапПроизводства из МассивЭтаповПроизводства Цикл
		СформироватьПередачуПродукции(ЭтапПроизводства, '2017-08-02 12:00:00', СтруктураДанных.СкладГП);
	КонецЦикла;	
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

Процедура СформироватьПередачуПродукции(ЭтапПроизводства, Дата, Получатель = Неопределено)
	
	МассивОснований = Новый Массив;
	МассивОснований.Добавить(ЭтапПроизводства);
	
	РезультатПроверки = ПроизводствоВызовСервера.СоздатьПередачуМатериаловВПроизводствоПроверкаОснований(МассивОснований, Истина);
	Если РезультатПроверки.ТекстОшибки <> Неопределено Тогда
		ВызватьИсключение РезультатПроверки.ТекстОшибки;
	КонецЕсли;
	
	ХозяйственнаяОперация =  Перечисления.ХозяйственныеОперации.ПередачаПродукцииИзПроизводства;
	РеквизитыШапки = Документы.ДвижениеПродукцииИМатериалов.ДанныеЗаполненияНакладной(
						МассивОснований, ХозяйственнаяОперация);
						
	// Для случаев когда есть разные склады в одном этапе
	Если Получатель <> Неопределено Тогда						
		РеквизитыШапки.Получатель = Получатель;
	КонецЕсли;	
						
	ПараметрыОснования = Новый Структура;
	ПараметрыОснования.Вставить("РеквизитыШапки", РеквизитыШапки);
	ПараметрыОснования.Вставить("МассивЗаказов",  МассивОснований);
	
	ДокументОбъект = Документы.ДвижениеПродукцииИМатериалов.СоздатьДокумент();
	ДокументОбъект.Заполнить(ПараметрыОснования);
	ДокументОбъект.Дата = Дата;
	
	ДокументОбъект.Записать(РежимЗаписиДокумента.Запись);
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры	

//ПередачаМатериаловВПроизводство
Процедура ПередачаМатериаловВПроизводство() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	МассивЗаказов = Новый Массив;
	МассивЗаказов.Добавить(СтруктураДанных.ЗаказНаПроизводствоГП1);
	
	МассивЭтаповПроизводства = ПолучитьМассивЭтаповПроизводства(МассивЗаказов);
	Для каждого Этап из МассивЭтаповПроизводства Цикл
		ПередачаМатериаловПоЭтапу(Этап, '2017-08-01');
	КонецЦикла;
	
	КонтекстЯдра.СохранитьКонтекст(СтруктураДанных);
	
КонецПроцедуры	

Процедура ПередачаМатериаловПоЭтапу(Этап, Дата) Экспорт
	
	МассивОснований = Новый Массив;
	МассивОснований.Добавить(Этап);
	
	РеквизитыШапки = Документы.ДвижениеПродукцииИМатериалов.ДанныеЗаполненияНакладной(МассивОснований, Перечисления.ХозяйственныеОперации.ПередачаМатериаловВПроизводство);
	
	ПараметрыОснования = Новый Структура;
	ПараметрыОснования.Вставить("РеквизитыШапки", РеквизитыШапки);
	ПараметрыОснования.Вставить("МассивЗаказов",  МассивОснований);
	
	ДокументОбъект = Документы.ДвижениеПродукцииИМатериалов.СоздатьДокумент();
	ДокументОбъект.Заполнить(ПараметрыОснования);
	ДокументОбъект.Дата = Дата;
	
	ДокументОбъект.Записать(РежимЗаписиДокумента.Запись);
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

//РасчетСебестоимости
Процедура РасчетСебестоимости() Экспорт
	
	СтруктураДанных = КонтекстЯдра.ПолучитьКонтекст();
	Если СтруктураДанных = Неопределено Тогда
		СтруктураДанных = ГенераторТестовыхДанных.СоздатьДанныеПоМакетам(ЭтотОбъект, "Ссылки");
	КонецЕсли;	
	
	РаботаСДокументами.ЗакрытьМесяц(СтруктураДанных.Организация, '2017-08-01');
	
	Результат = ПартииНезавершенногоПроизводства(СтруктураДанных.Организация, '2017-09-01');
	Утверждения.ПроверитьИстину(Результат, "Обнаружены остатки  по регистру ПартииНезавершенногоПроизводства");
	
	Результат = СебестоимостьТоваров(СтруктураДанных.Организация, '2018-09-01');
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
	
	Отчет.НачалоПериода = '2017-08-01';
	Отчет.КонецПериода  = КонецМесяца('2017-08-01');
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
