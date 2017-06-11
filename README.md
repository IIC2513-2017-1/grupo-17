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

### TODO's
- Mejorar validación al crear Bet
- Mejorar validación al crear Gees
- Enviar mensajes de error correctos para cada validación
- Unificar vista para ver mis amistades, mis solicitudes recibidas y mis solicitudes enviadas
- Arreglar queries n+1
- Agregar gráficos o estadísticas en index de bets
- Definir qué cosas pueden modificar el usuario de su perfil
- Revisar que funcione el cambio de contraseña
- Descomentar la validación de minimo 1 Field para cada Gee (y con ello cambiar las seeds para que no tiren error)
- Arreglar icono de notificaciones en producción (error de fontawesome en consola)