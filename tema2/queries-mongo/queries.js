//1.Escribe una consulta para mostrar todos los documentos en la colección Restaurantes.
db.restaurant.find( );

//2.Escribe una consulta para mostrar el restaurante_id, name, borough y cuisine de todos los documentos en la colección Restaurantes.
db.restaurant.find( { }, {'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1 } );

//3.Escribe una consulta para mostrar el restaurante_id, name, borough y cuisine, pero excluyendo el campo _id por todos los documentos en la colección Restaurantes.
db.restaurant.find( { }, {'_id':0, 'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1 } );

//4.Escribe una consulta para mostrar restaurant_id, name, borough y zip code, pero excluyendo el campo _id por todos los documentos en la colección Restaurantes.
db.restaurant.find( { }, {'_id':0, 'restaurant_id': 1, 'name': 1, 'borough': 1, 'address.zipcode': 1 } );

//5.Escribe una consulta para mostrar todos los restaurantes que están en el Bronx.
db.restaurant.find( {'borough':  'Bronx'} )

//6.Escribe una consulta para mostrar los primeros 5 restaurantes que están en el Bronx.
db.restaurant.find( {'borough': 'Bronx'} ).limit(5);

//7.Escribe una consulta para mostrar los 5 restaurantes después de saltar los primeros 5 que sean del Bronx.
db.restaurant.find( {'borough': 'Bronx'}).skip(5).limit(5);

//8.Escribe una consulta para encontrar los restaurantes que tienen algún resultado mayor de 90.
db.restaurant.find( {'grades.score': {$gt: 90} } );

//9.Escribe una consulta para encontrar los restaurantes que tienen un resultado mayor que 80 pero menos que 100.
db.restaurant.find( {'grades':{$elemMatch: {'score': {$gt:80, $lt:100} } } } );

//10.Escribe una consulta para encontrar los restaurantes situados en una longitud inferior a -95.754168.
db.restaurant.find( {'address.coord.0': {$lt: -95.754168} } );

//11.Escribe una consulta de MongoDB para encontrar los restaurantes que no cocinan comida 'American' y tienen algún resultado superior a 70 y latitud inferior a -65.754168.
db.restaurant.find( { $and: [ { 'cuisine': { $not: /American/} }, { 'grades.score': { $gt: 70 } }, { 'address.coord.0': { $lt: -65.754168 } } ] } );

//12.Escribe una consulta para encontrar los restaurantes que no preparan comida 'American' y tienen algún resultado superior a 70 y que, además, se localizan en longitudes inferiores a -65.754168. Nota : Realiza esta consulta sin utilizar operador $and.
db.restaurant.find( { 'cuisine': { $not: /American/ } , 'grades.score': { $gt: 70 } , 'address.coord.0': { $lt: -65.754168 } } );

//13.Escribe una consulta para encontrar los restaurantes que no preparan comida 'American', tienen alguna nota 'A' y no pertenecen a Brooklyn. Se debe mostrar el documento según la cuisine en orden descendente.
db.restaurant.find( { 'cuisine': { $not: /American/ } , 'grades.grade': 'A' , 'borough': { $not:/Brooklyn/ } } ). sort( { cuisine: -1 } );

//14.Escribe una consulta para encontrar el restaurante_id, name, borough y cuisine para aquellos restaurantes que contienen 'Wil' en las tres primeras letras en su nombre.
db.restaurant.find( { 'name': /^Wil/ }, {'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1, '_id': 0 } );

//15.Escribe una consulta para encontrar el restaurante_id, name, borough y cuisine para aquellos restaurantes que contienen 'ces' en las últimas tres letras en su nombre.
db.restaurant.find( { 'name': /ces$/ }, {'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1, '_id': 0 } );

//16.Escribe una consulta para encontrar el restaurante_id, name, borough y cuisine para aquellos restaurantes que contienen 'Reg' en cualquier lugar de su nombre.
db.restaurant.find( { 'name': /Reg/ }, {'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1, '_id': 0 } );

//17.Escribe una consulta para encontrar los restaurantes que pertenecen al Bronx y preparan platos americanos o chinos.
b.restaurant.find({'borough': 'Bronx', $or: [ { 'cuisine': /American/}, { 'cuisine': /Chinese/} ] } );

//18.Escribe una consulta para encontrar el restaurante_id, name, borough y cuisine para aquellos restaurantes que pertenecen a Staten Island, Queens, Bronx o Brooklyn.
db.restaurant.find({$or: [ {'borough': 'Staten Island'}, {'borough': 'Queens'}, {'borough': 'Bronx'}, {'borough': 'Brooklyn'} ] }, {'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1, '_id': 0 } );

//19.Escribe una consulta para encontrar el restaurante_id, name, borough y cuisine para aquellos restaurantes que NO pertenecen a Staten Island, Queens, Bronx o Brooklyn.
db.restaurant.find( { $or: [ { borough: { $nin: [ 'Staten Island', 'Queens', 'Bronx' , 'Brooklyn' ] } } ] }, {'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1, '_id': 0 } );

//20.Escribe una consulta para encontrar el restaurante_id, name, borough y cuisine para aquellos restaurantes que consigan una nota menor que 10.
db.restaurant.find( {'grades.score': { $lt: 10} }, {'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1, '_id': 0 } );

//*21.Escribe una consulta para encontrar el restaurante_id, name, borough y cuisine para aquellos restaurantes que preparan marisco ('seafood') excepto si son 'American', 'Chinese' o el name del restaurante comienza con letras 'Wil’.
db.Restaurant.find( {$or:[ {'cuisine':{ $nin:['American','Chinese'] },'name':/^Wil/i},{'cuisine':'Seafood'} ] },{'restaurant_id': 1,'name':1,'borough': 1,'cuisine': 1,'_id':0});

//*22.Escribe una consulta para encontrar el restaurante_id, name y gradas para aquellos restaurantes que consigan un grade de "A" y un resultado de 11 con un ISODate "2014-08-11T00:00:00Z”.


//*23.Escribe una consulta para encontrar el restaurante_id, name y gradas para aquellos restaurantes donde el 2º elemento del array de grados contiene un grade de "A" y un score 9 con un ISODate "2014-08-11T00:00:00Z” .


//24.Escribe una consulta para encontrar el restaurante_id, name, dirección y ubicación geográfica para aquellos restaurantes donde el segundo elemento del array coord contiene un valor entre 42 y 52.

//25.Escribe una consulta para organizar los restaurantes por nombre en orden ascendente.
db.restaurant.find( ). sort( {name:1} );

//26.Escribe una consulta para organizar los restaurantes por nombre en orden descendente.
db.restaurant.find( ). sort( {name: -1} );

//27.Escribe una consulta para organizar los restaurantes por el nombre de la cuisine en orden ascendente y por el barrio en orden descendente.
db.restaurant.find( ). sort({name: 1, borough: -1});

//28.Escribe una consulta para saber si las direcciones contienen la calle.
//29.Escribe una consulta que seleccione todos los documentos en la colección de restaurantes donde los valores del campo coord es de tipo Double.
//30.Escribe una consulta que seleccione el restaurante_id, name y grade para aquellos restaurantes que devuelven 0 como residuo después de dividir alguno de sus resultados por 7.

//31.Escribe una consulta para encontrar el name de restaurante, borough, longitud, latitud y cuisine para aquellos restaurantes que contienen 'mon' en algún lugar de su name.
db.restaurant.find( { 'name': /mon/ }, { 'name': 1, 'borough': 1, 'address.coord': 1, 'cuisine': 1, '_id': 0} );

//32.Escribe una consulta para encontrar el name de restaurante, borough, longitud, latitud y cuisine para aquellos restaurantes que contienen 'Mad' como primeras tres letras de su name.
db.restaurant.find( { 'name': /^Mad/ }, { 'name': 1, 'borough': 1, 'address.coord': 1, 'cuisine': 1, '_id': 0} );