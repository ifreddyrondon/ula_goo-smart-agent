# Goo agente inteligente inferencia y conocimiento prolog

### [Goo agente inteligente](http://spantons.github.io/Goo-agente-inteligente-inferencia-y-conocimiento-prolog/)

**Motor de inferencias y base de conocimiento para un agente inteligente**

## ¿Qué es esto?
Es el motor de inferencia de un agente inteligente basado en un mayordomo universitario y representación de la base de conocimiento a traves de Prolog.

La eficacia a la hora de responder cualquier solicitud del usuario va a depender directamente de lo que el agente tenga como conocimiento.

Este agente tendrá conocimiento cambiante y  muy expansivo con el tiempo ya que el usuario es un ser humano lleno de contradicciones y nuevas experiencias día a día.

La eficacia a la hora de responder cualquier solicitud del usuario va a depender directamente de lo que el agente universitario tenga como conocimiento.

Inducción : Dependiendo las actividades que se le informen al agente podrá predecir patrones de rutina.
    *Si el lunes estudio en la noche ^ el martes estudio en la noche ^... el jueves estudio en la noche
     ^ hoy es viernes => sugerir apartar agenda para estudiar en la noche.

-Abducción: No le gusta la comida árabe ^ busca sitios de comida árabe => comerá con alguien que le gusta la comida árabe

Como es de esperarse, un agente de esta categoría no podrá aprender todo desde cero, es por ello que al iniciar su ejecución le sean pre-cargados algunos valores básicos por parte del usuario (hechos/default_hechos.pl).

Algunos casos el agente se encontrara en la situación de  no saber explícitamente cuales son todas las preferencias del usuario, por tanto deberá tomar definiciones a ciegas para poder ofrecerle sugerencias de actividades.


## ¿Qué necesito?
Debes tener instalado [SWI-Prolog](http://www.swi-prolog.org/)

## ¿Cómo ejecuto la aplicación?
 1. Debes navegar en un terminal hasta la carpeta raiz del repositorio y correr '$ swipl'
 2. Compilar y cargar en memoria todas las sentencias de el Agente '[Goo].'
 3. Correr 'goo.' 
 4. Ingresar alguna petición como 'tengo hambre', para ver todas las peticiones que se pueden hacer revisar el archivo (gramatica/gramatica.pl)
