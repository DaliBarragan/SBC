(deftemplate smartphone
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio))

(deftemplate computadora
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio))

(deftemplate accesorio
   (slot tipo)
   (slot marca)
   (slot modelo)
   (slot precio))

(deftemplate cliente
   (slot nombre)
   (slot tipo))

(deftemplate orden
   (multislot items)
   (slot cliente)
   (slot tipo-pago))

(deftemplate tarjeta-credito
   (slot banco)
   (slot tipo)
   (slot fecha-expiracion))

(deftemplate vale
   (slot valor))

(deffacts base-conocimiento
   (smartphone (marca apple) (modelo iPhone15) (color rojo) (precio 17000))
   (smartphone (marca samsung) (modelo Note12) (color negro) (precio 15000))
   (computadora (marca apple) (modelo MacBookAir) (color gris) (precio 25000))
   (accesorio (tipo funda) (marca apple) (modelo iPhone15) (precio 1000))
   (accesorio (tipo mica) (marca apple) (modelo iPhone15) (precio 500))
   (cliente (nombre "Juan Perez") (tipo menudista))
   (cliente (nombre "Empresa XYZ") (tipo mayorista))
   (tarjeta-credito (banco bbva) (tipo visa) (fecha-expiracion 01-12-23))
   (tarjeta-credito (banco liverpool) (tipo visa) (fecha-expiracion 01-12-25))
   (tarjeta-credito (banco banamex) (tipo mastercard) (fecha-expiracion 01-12-24)))

(defrule oferta-iphone15-bbva
   (orden (items $? (smartphone (marca apple) (modelo iPhone15) ?color ?precio) $?)
          (cliente ?cliente)
          (tipo-pago (banco bbva) (tipo visa)))
   =>
   (printout t "Oferta: 24 meses sin intereses para iPhone 15 con tarjeta BBVA VISA" crlf))

(defrule oferta-note12-liverpool
   (orden (items $? (smartphone (marca samsung) (modelo Note12) ?color ?precio) $?)
          (cliente ?cliente)
          (tipo-pago (banco liverpool) (tipo visa)))
   =>
   (printout t "Oferta: 12 meses sin intereses para Samsung Note 12 con tarjeta Liverpool VISA" crlf))

(defrule oferta-macbookair-iphone15-contado
   (orden (items $? (smartphone (marca apple) (modelo iPhone15) ?color ?precio1)
                 (computadora (marca apple) (modelo MacBookAir) ?color2 ?precio2) $?)
          (cliente ?cliente)
          (tipo-pago contado))
   =>
   (bind ?total (+ ?precio1 ?precio2))
   (bind ?vales (floor (/ ?total 1000)))
   (printout t "Oferta: " (* ?vales 100) " pesos en vales para la compra de MacBook Air y iPhone 15 al contado" crlf))

(defrule oferta-funda-mica-smartphone
   (orden (items $? (smartphone ?marca ?modelo ?color ?precio) $?)
          (cliente ?cliente)
          (tipo-pago ?tipo-pago))
   =>
   (printout t "Oferta: 15% de descuento en funda y mica para cualquier smartphone" crlf))

(defrule segmentar-cliente-menudista
   (orden (cliente (nombre ?nombre) (tipo menudista)))
   =>
   (printout t "Segmento: Cliente menudista - " ?nombre crlf))

(defrule segmentar-cliente-mayorista
   (orden (cliente (nombre ?nombre) (tipo mayorista)))
   =>
   (printout t "Segmento: Cliente mayorista - " ?nombre crlf))

(defrule aplicar-ofertas
   (declare (salience 10))
   (order ?orden <- (orden (items $? ?item $?)))
   =>
   (printout t "Aplicando ofertas para la orden: " ?orden crlf)
   (run))
