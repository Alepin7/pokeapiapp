# pokeapiapp
poke app paralelas

RESUMEN
El desarrollo de aplicaciones móviles es de vital importancia en el mundo actual, la facilidad de 
compartir información usando la accesibilidad de nuestros dispositivos móviles, permite mejorar 
la calidad de vida de todos nosotros, facilitar el proceso de aprendizaje, mejorar nuestra 
comunicación o hacer el trabajo de mejor manera.
Este trabajo es grupal.

Objetivos
1. Comprender el funcionamiento de las aplicaciones móviles.
2. Aprender a usar un framework híbrido para facilitar el desarrollo.
3. Reutilizar la API REST de consulta que obtenga los datos de los personajes Pokémon 
(POKEDEX) 

Ejecución.
Al igual que en el taller anterior se deben consumir las API/REST descritas:
• https://pokeapi.co/api/v2/pokemon?offset=[start]&limit=[end]
• https://pokeapi.co/api/v2/pokemon/[id]/
Al momento de consultar las API REST, estas deben entregar el listado total de personajes, los 
cuales deben ser desplegados en una APP paginada de a 10 objetos.

Dentro de la información que se debe mostrar por cada Pokémon se debe desplegar:
• ID
• Nombre
• Altura
• Peso
• Él o los tipos
• Formas
• Habilidades
• Ubicación
• Sprite o imagen
Splash Screen.

Usualmente el splash screen, se usa para precargar los elementos más usados en la aplicación, 
inicializar estados, comprobar el estado de la aplicación, analizar la persistencia y la red. En este 
punto se suele entregar cualquier información de error que se detectase.

Login
La aplicación debe loguearse contra la cuenta de correo electrónico de la utem usando la 
autenticación de Google (La operación Login del swagger permite usar la autenticación con el 
correo utem, https://api.sebastian.cl/vote/swagger-ui/index.html).

Observación: El swagger proporcionado para el Login es gracias a la colaboración del profesor 
Sebastián Salazar. (Sólo ocupar lo referente a la autenticación)
Como usuario se tiene que usar el correo electrónico de cada integrante de la UTEM y la 
contraseña válida para loguearse al sistema. Si las credenciales son correctas se tiene que 
presentar una nueva vista.

Votar.
Cuando se despliegan los pokemones en la APP, la idea es que el usuario pueda votar por los 3 
que más le gustan, esta información debe ser recopilada en una BD. Además, en una opción de 
la APP donde diga “Mostrar resultados de la votación”, debe desplegar el ranking de los 
pokemones votados en la APP.

Código.
El código debe ser entregado a más tardar, el 10/12/2022 hasta las 23:59:59.999 horas de 
Santiago de Chile, este proyecto debe estar respaldado en un repositorio personal github.
Debe ser programada en el framework híbrido Flutter. El diseño propuesto, es sólo 
representativo, el diseño gráfico es parte de la evaluación y se espera que cada grupo tenga una 
propuesta atractiva y funcional. La aplicación debe consumir los servicios REST 
proporcionados.

De la misma manera, se espera que cada grupo implemente todas las validaciones necesarias 
para no tener errores en las vistas y que se controlen todos los casos posibles.

EVALUACIÓN
Documentación.
Parte de la evaluación consiste en la documentación de las funciones. Que debe ser clara, concisa 
y descriptiva de lo que el código realiza.

Código
El código debe ser claro, fácil de leer, ordenado y cumplir con buenas prácticas de programación, 
se inspeccionará el código fuente.

Resultados.
Un criterio de evaluación que se tomará en consideración: el tiempo de ejecución de la tarea. 
Menos es mejor. La evaluación es porcentual. Además, cada grupo debe presentar en la clase los 
resultados del problema y como lo resolvieron.

INTEGRANTES GRUPO COMP. PARALELA:

Lukas Poffal Munita (lukas.poffalm@utem.cl),
Martín Martínez Allende (martin.martineza@utem.cl),
Alex Pino Moya (alex.pinom@utem.cl),
Marcelo Silva Escala (marcelo.silvae@utem.cl),
Marcelo Tapia Riquelme (marcelo.tapiar@utem.cl)
