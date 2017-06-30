# Grupo 17 - Gees

## Sitio web
https://tecweb-grupo17.herokuapp.com

## Integrantes
- Martín De la Fuente
- Andrés Espinosa

## Tema del proyecto
- Gestor de apuestas

## Introducción a Gees
Gees es una plataforma donde los usuarios crean sus propias apuestas y
las demás personas pueden apostar. A cada una de estas apuestas que crean
los usuarios se les llama Gee.

### ¿Cómo probar la aplicación?
En las _seeds_ se han creado 3 usuarios para hacer pruebas:

| Username | Password | Rol    |
| :------: | :------: | :----: |
| betgod   | dificil       | administrador   |
| testuser1   | dificil     | usuario |
| testuser2   | dificil     | usuario |

También es posible crearse una cuenta nueva, pero debe ingresarse un correo válido
ya que el registro requiere confirmación del correo.

## API

Para todas las consultas a la API debe enviarse el api-token del usuario en el 
header `Authorization`.

Ejemplo: `Authorization: Token asM3NS-aswWSWda`

### Endpoints válidos

- GET /users (retorna lista de todos los usuarios)
- GET /users/1 (retorna información de un usuario)
- GET /notifications (retorna la lista de notificaciones del usuario)
- GET /gees (retorna la lista de Gees visibles por el usuario)
- POST /gees (crea un Gee)
- GET /gees/1 (retorna información sobre un Gee específico)
- GET /gees/1/bets (retorna la lista de Bets para un Gee específico)
- POST /gees/1/bets (crea un Bet)
- GET /gees/1/bets/1 (retorna la información de un Bet determinado)
- GET /categories (retorna la lista de categorías existentes)

#### POST /gees/1/bets
El body debe contener:
- `quantity (int)`: la cantidad de dinero a apostar
- `fields (array)`: lista de los nombres de los campos que tiene el gee
- `values (array)`: lista de los valores para cada campo (en el mismo orden)

Ejemplo:
```
{
	"quantity": 5,
	"fields": ["Locale", "Visit"],
	"values": [2,4]
}
```

#### POST /gees

Ejemplo:
```
{
	"name": "Soccer match",
	"description": "A simple match",
	"category_id": 1,
	"is_public": true,
	"expiration_date": "2017/12/12",
	"fields": [
		{
			"name": "Score",
			"type": "number",
			"min_value": 0,
			"max_value": 100
		},
		{
			"name": "Winner",
			"type": "alternatives",
			"alternatives": [
				"first",
				"second"
			]
		}
	]
}
```
