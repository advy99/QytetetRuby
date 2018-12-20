# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "jugador"

module ModeloQytetet
    class Jugador
        
        attr_reader :saldo, :nombre, :propiedades
                  
        attr_accessor :carta_libertad, :casilla_actual, :encarcelado
        
        def initialize(n_nombre)
            @encarcelado = false
            @nombre = n_nombre
            @saldo = 7500
            
            @propiedades = Array.new
            @casilla_actual = nil
            
            @carta_libertad = nil
        end
        
        def self.nuevo(n_nombre)
            new(n_nombre)
        end
        
        def copia(otro_jugador)
            
            #new(otro_jugador.nombre)

            
            @nombre = otro_jugador.nombre
            @saldo = otro_jugador.saldo
            @propiedades = otro_jugador.propiedades
            @carta_libertad = otro_jugador.carta_libertad
            @casilla_actual = otro_jugador.casilla_actual
            @encarcelado = otro_jugador.encarcelado
           
        end
        
        def cancelar_hipoteca(titulo) # : boolean
            cancelada = false
        
            coste_cancelar = titulo.calcular_coste_cancelar

            if @saldo >= coste_cancelar
                modificar_saldo(-coste_cancelar)


                titulo.cancelar_hipoteca

                cancelada = true
            end

            return cancelada
        end
        
        def convertirme(fianza) #especulador
            
            especulador = Especulador.new(self, fianza)
            
            return especulador
            
            
        end
        
        def comprar_titulo_propiedad() # : boolean
            comprado = false
            
            coste_compra = @casilla_actual.coste
            
            if (coste_compra < @saldo)
                @casilla_actual.asignar_propietario(self)
                
                comprado = true
                
                @propiedades << @casilla_actual.titulo
                
                modificar_saldo(-coste_compra)
            end
            
            return comprado
        end
        
        def cuantas_casas_hoteles_tengo() # : int
            
            total = 0
            
            for p in @propiedades
                total += p.num_casas + p.num_hoteles;
            end
            
            return total
        end
        
        def debo_ir_a_carcel() # boolean
            return !tengo_carta_libertad
        end
        
        def debo_pagar_alquiler() # : boolean
            titulo = @casilla_actual.titulo
            
            es_de_mi_propiedad = es_de_mi_propiedad(titulo)
            
            if( !es_de_mi_propiedad)
                tiene_propietario = titulo.tengo_propietario()
                
                if (tiene_propietario)
                    encarcelado = titulo.propietario_encarcelado()
                    
                    if (!encarcelado)
                        esta_hipotecada = titulo.hipotecada
                    end
                    
                end
                
            end
            
            return (!es_de_mi_propiedad && tiene_propietario && !encarcelado && !esta_hipotecada)
            
            
        end
        
        def devolver_carta_libertad() # : Sorpresa
            carta_l = @carta_libertad
            @carta_libertad = nil
            return carta_l
        end
        
        def edificar_casa(titulo) # : boolean
            
            edificada = false
            
            if puedo_edificar_casa(titulo)
                
                titulo.edificar_casa()
                
                modificar_saldo(-titulo.precio_edificar)

                edificada = true
     
                
            end
            
            return edificada
        end
        
        def edificar_hotel(titulo) # : boolean
            edificado = false;
        
            

            if puedo_edificar_hotel(titulo)

              
                titulo.edificar_hotel()

                modificar_saldo(-titulo.precio_edificar)

                edificado = true


            end

            return edificado;
        end
        
        def eliminar_de_mis_propiedades(titulo) # : void
            @propiedades.delete(titulo)
            
            titulo.propietario = false
        end
        
        def es_de_mi_propiedad(titulo) # : boolean
            return @propiedades.include?(titulo)
        end
        
        
        #def estoy_en_calle_libre() # : boolean
        #    raise NotImplementedError
        #end
        
        def hipotecar_propiedad(titulo) # : boolean
            coste_hipoteca = titulo.hipotecar()
            
            modificar_saldo(coste_hipoteca)
        end
        
        def ir_a_carcel(casilla) # : void
            @casilla_actual = casilla
        
            @encarcelado = true
        end
        
        def modificar_saldo(cantidad) # : int
            @saldo = @saldo + cantidad
            
            return @saldo
        end
        
        def obtener_capital() # : int
            capital = @saldo
            
            for p in propiedades
                capital += p.precio_compra + p.precio_edificar*(p.num_casas+p.num_hoteles)
            
            
                if p.hipotecada
                    capital -= p.hipoteca_base
                end
            
            end
            
            return capital

        end
        
        def obtener_propiedades(hipotecada) # : TituloPropiedad[0..*]
            pro = Array.new
            
            for p in @propiedades
                if p.hipotecada == hipotecada
                    pro << p
                end
            end
            
            return p
        end
        
        def pagar_alquiler() # : void
            coste_alquiler = @casilla_actual.pagar_alquiler()

            modificar_saldo(-coste_alquiler)
        end
        
        def pagar_impuesto() # : void
            @saldo = @saldo - @casilla_actual.coste
        end
        
        def pagar_libertad(cantidad) # : void
            tengo_saldo = tengo_saldo(cantidad)
            
            if (tengo_saldo)
                @encarcelado = false
                
                modificar_saldo (-cantidad_int)
            end
        end
        
        
        def puedo_edificar_casa(titulo)
            puedo = tengo_saldo(titulo.precio_edificar) && titulo.num_casas < 4
            
            return puedo
        end
        
        def puedo_edificar_hotel(titulo)
            puedo = tengo_saldo(titulo.precio_edificar) && titulo.num_casas >= 4 && titulo.num_hoteles < 4
            
            return puedo
        end
        
        def tengo_carta_libertad() # : boolean
            return @cartal_libertad != nil
        end
        
        def tengo_saldo(cantidad) # : boolean
            return @saldo >= cantidad
        end
        
        def vender_propiedad(casilla) # : void
            titulo = casilla.titulo()
            
            eliminar_de_mis_propiedades(titulo)
            
            precio_venta = titulo.calcular_precio_venta()
            
            modificar_saldo(precio_venta)
            
            
        end
        
        
        def to_s()
    
            texto = ""

            texto += "\nNombre: " + @nombre + "\n" +
                     "Encarcelado: " + @encarcelado.to_s + "\n" +
                     "Saldo: " + @saldo.to_s + "\n" +
                     "Capital: " + obtener_capital().to_s + "\n\n"

            if @carta_libertad != nil
              texto += @carta_libertad.to_s
            end

            texto += "\nLas siguientes propiedades pertenecen a " + @nombre + "\n"
            for t in @propiedades
                texto += "\t" + t.nombre + "\n"
            end

            texto += "\n\nLa casilla actual del jugador es: "

            texto += "\n" + @casilla_actual.to_s + "\n"




            return texto
        end
       
        
        def <=>(otroJugador)
            otroJugador.obtener_capital <=> obtener_capital
        end
                
        private :eliminar_de_mis_propiedades, :es_de_mi_propiedad
        
        # copia, pagar_impuesto, :debo_ir_a_carcel, :convertirme no pueden ser protected
        
        protected :puedo_edificar_casa, :puedo_edificar_hotel, :tengo_saldo
        
        
        #private_class_method :new
        
    end
end
