; Definir la plantilla para enfermedades
(deftemplate enfermedad
   (slot id)
   (slot nombre)
   (multislot signos)
   (multislot sintomas))

; Definir los hechos iniciales de las enfermedades
(deffacts enfermedades
   (enfermedad (id 1) (nombre "Gripe") (signos "fiebre" "escalofrios") (sintomas "tos" "dolor de garganta"))
   (enfermedad (id 2) (nombre "COVID-19") (signos "fiebre" "tos seca") (sintomas "fatiga" "dificultad para respirar"))
   (enfermedad (id 3) (nombre "Varicela") (signos "erupciones" "fiebre") (sintomas "picazon" "fatiga"))
   (enfermedad (id 4) (nombre "Resfriado común") (signos "congestión nasal" "estornudos") (sintomas "dolor de garganta" "tos"))
   (enfermedad (id 5) (nombre "Migraña") (signos "dolor de cabeza" "náuseas") (sintomas "sensibilidad a la luz" "vómitos"))
   (enfermedad (id 6) (nombre "Gastritis") (signos "dolor abdominal" "hinchazón") (sintomas "náuseas" "vómitos")))

; Regla para consultar una enfermedad por nombre
(defrule consultar-enfermedad-por-nombre
   ?request <- (request (tipo "consulta-enfermedad") (nombre ?nombre))
   ?e <- (enfermedad (nombre ?nombre) (signos $?signos) (sintomas $?sintomas))
   =>
   (printout t "Enfermedad: " ?nombre crlf)
   (printout t "Signos: " ?signos crlf)
   (printout t "Síntomas: " ?sintomas crlf)
   (retract ?request))

; Regla para consultar enfermedades por signo
(defrule consultar-enfermedades-por-signo
   ?request <- (request (tipo "consulta-signo") (signo ?signo))
   ?e <- (enfermedad (nombre ?nombre) (signos $?signos) (sintomas $?sintomas))
   (member$ ?signo ?signos)
   =>
   (printout t "Enfermedad: " ?nombre crlf)
   (printout t "Signos: " ?signos crlf)
   (printout t "Síntomas: " ?sintomas crlf)
   (retract ?request))

; Regla para consultar enfermedades por síntoma
(defrule consultar-enfermedades-por-sintoma
   ?request <- (request (tipo "consulta-sintoma") (sintoma ?sintoma))
   ?e <- (enfermedad (nombre ?nombre) (signos $?signos) (sintomas $?sintomas))
   (member$ ?sintoma ?sintomas)
   =>
   (printout t "Enfermedad: " ?nombre crlf)
   (printout t "Signos: " ?signos crlf)
   (printout t "Síntomas: " ?sintomas crlf)
   (retract ?request))

; Regla para eliminar una enfermedad por ID
(defrule eliminar-enfermedad-por-id
   ?request <- (request (tipo "eliminar-enfermedad") (id ?id))
   ?e <- (enfermedad (id ?id))
   =>
   (retract ?e)
   (printout t "Enfermedad con ID " ?id " eliminada." crlf)
   (retract ?request))

; Ejemplos de solicitudes para probar las reglas
(assert (request (tipo "consulta-enfermedad") (nombre "Gripe")))
(assert (request (tipo "consulta-signo") (signo "fiebre")))
(assert (request (tipo "consulta-sintoma") (sintoma "tos")))
(assert (request (tipo "eliminar-enfermedad") (id 1)))

; Ejecutar las reglas
(run)
