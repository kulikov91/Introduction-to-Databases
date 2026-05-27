print('\n ## Создание коллекции и вставка 1 документа \n ');
db.mycollection.insert([
	{nId: 1, name: 'Стол', price: 4025.25 }
]);

print('\n ## Выведение коллекции \n ');
db.mycollection.find();

print('\n ## Создание нескольких документов в виде массива \n ');
catalog = [
	{nId: 2, name: 'Стул', price: 1025.25},
	{nId: 3, name: 'Диван', price: 45789},
	{nId: 4, name: 'Компьютер работника', otdel: 'Продажи',
		address: { ulitsa: "Новороссийская", dom: "25" }}
]

print('\n ## Вставка массива объектов в коллекцию \n ');
db.mycollection.insert(catalog);

print('\n ## Выведение коллекции \n ');
db.mycollection.find();

print('\n ## Выведение коллекции в более наглядном виде\n ');
db.mycollection.find().pretty()

print('\n ## Вставка совсем отличающегося по структуре документа \n ');
db.mycollection.insert([
	{aa: 'Совсем', bbb: 'по-', 45: 'другому' }
]);

print('\n ## Выведение коллекции \n ');
db.mycollection.find();

print('\n ## Выведение документа по условию\n ');
db.mycollection.find({ nId: 3 });

print('\n ## Выведение документа по условию вложенного свойства\n ');
db.mycollection.find({ 'address.dom': '25' });

print('\n ## Выведение только определенных полей документа\n ');
db.mycollection.find({nId: 3}, {name: 1})

print('\n ## Найдем отличающийся элемент без поля nID в коллекции\n ');
db.mycollection.find({nId: null})

print('\n ## Удалим отличающийся элемент без поля nID из коллекции\n ');
db.mycollection.deleteOne({nId: null})

print('\n ## Выведение коллекции \n ');
db.mycollection.find();

print('\n ## Обновим первую запись\n ');
db.mycollection.updateOne({'nId': 1}, {'$set': {'name': 'Шкаф'}})

print('\n ## Выведение коллекции \n ');
db.mycollection.find();

print('\n ## Отображение всех товаров, кроме Компьютера работника\n ');
db.mycollection.find({nId: {$ne: 4 }});

print('\n ## Замена названия name на слово Товар, кроме Компьютера работника\n ');
db.mycollection.updateMany({nId: {$ne: 4}}, {$rename:{"name": 'Товар'}});

print('\n ## Выведение коллекции\n ');
db.mycollection.find();