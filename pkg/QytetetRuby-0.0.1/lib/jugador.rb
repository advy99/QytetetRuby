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
            
            @carta_libertad = nil
        end
        
        def cancelar_hipoteca(titulo) # : boolean
            raise NotImplementedError
        end
        
        def comprar_titulo_propiedad() # : boolean
            raise NotImplementedError
        end
        
        def cuantas_casas_hoteles_tengo() # : int
            
            total = 0
            
            for p in @propiedades
                total += p.num_casas + p.num_hoteles;
            end
            
            return total
        end
        
        def debo_pagar_alquiler() # : boolean
            raise NotImplementedError
        end
        
        def devolver_carta_libertad() # : Sorpresa
            carta_l = @carta_libertad
            @carta_libertad = nil
            return carta_l
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
            lo_es = false
            
            for t in @propiedades and not lo_es
                if t == titulo
                    lo_es = true
                end
            end
            
            return lo_es
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
            @saldo = @saldo + cantidad
            
            return @saldo
        end
        
        def obtener_capital() # : int
            capital = @saldo
            
            for p in propiedades
                capital += p.precio_compra + p.precio_edificar*(p.num_casas+p.num_hoteles)
            end
            
            if p.hipotecada
                capital -= p.hipoteca_base
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
            raise NotImplementedError
        end
        
        def pagar_impuesto() # : void
            @saldo = @saldo - @casilla_actual.coste
        end
        
        def pagar_libertad(cantidad) # : void
            raise NotImplementedError
        end
        
        def tengo_carta_libertad() # : boolean
            return @cartal_libertad != nil
        end
        
        def tengo_saldo(cantidad) # : boolean
            return @saldo >= cantidad
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
       
        
        def <=>(otroJugador)
            otroJugador.obtener_capital <=> obtener_capital
        end
                
        private :eliminar_de_mis_propiedades, :es_de_mi_propiedad,
                :tengo_saldo
        
    end
end
