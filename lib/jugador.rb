# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
    class Jugador
        
        attr_reader :saldo, :nombre, :propiedades, :saldo
                  
        attr_accessor :carta_libertad, :casilla_actual, :encarcelado
        
        def initialize(n_nombre, c_inicio)
            @encarcelado = false
            @nombre = n_nombre
            @saldo = 7500
            
            @propiedades = Array.new
            @casilla_actual = c_inicio
            
            @carta_libertad
        end
        
        def cancelar_hipoteca(titulo) # : boolean
            raise NotImplementedError
        end
        
        def comprar_titulo_propiedad() # : boolean
            raise NotImplementedError
        end
        
        def cuantas_casas_hoteles_tengo() # : int
            raise NotImplementedError
        end
        
        def debo_pagar_alquiler() # : boolean
            raise NotImplementedError
        end
        
        def devolver_carta_libertad() # : Sorpresa
            raise NotImplementedError
        end
        
        def edificar_casa(titulo) # : boolean
            raise NotImplementedError
        end
        
        def edificar_hotel(titulo) # : boolean
            raise NotImplementedError
        end
        
        def eliminar_de_mis_propiedades(titulo) # : void
            raise NotImplementedError
        end
        
        def es_de_mi_propiedad(titulo) # : boolean
            raise NotImplementedError
        end
        
        def estoy_en_calle_libre() # : boolean
            raise NotImplementedError
        end
        
        def hipotecar_propiedad(titulo) # : boolean
            raise NotImplementedError
        end
        
        def ir_a_carcel(casilla) # : void
            raise NotImplementedError
        end
        
        def modificar_saldo(cantidad) # : int
            raise NotImplementedError
        end
        
        def obtener_capital() # : int
            raise NotImplementedError
        end
        
        def obtener_propiedades(hipotecada) # : TituloPropiedad[0..*]
            raise NotImplementedError
        end
        
        def pagar_alquiler() # : void
            raise NotImplementedError
        end
        
        def pagar_impuesto() # : void
            raise NotImplementedError
        end
        
        def pagar_libertad(cantidad) # : void
            raise NotImplementedError
        end
        
        def tengo_carta_libertad() # : boolean
            raise NotImplementedError
        end
        
        def tengo_saldo(cantidad) # : boolean
            raise NotImplementedError
        end
        
        def vender_propiedad(casilla) # : boolean
            raise NotImplementedError
        end
        
        
        def to_s()
    
            texto = ""

            texto += "\nNombre: " + @nombre + "\n" +
                     "Encarcelado: " + @encarcelado.to_s + "\n" +
                     "Saldo: " + @saldo.to_s + "\n\n"

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
       
                
        private :eliminar_de_mis_propiedades, :es_de_mi_propiedad,
                :tengo_saldo
        
    end
end
