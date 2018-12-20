# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "jugador"

module ModeloQytetet
    class Especulador < Jugador
        
        attr_reader :fianza
        
        def initialize(jugador, fianza)
            copia(jugador)
            @fianza = fianza
        
        end
        
        #def self.copia(jugador, fianza)
        #    super(jugador)
            
        #    @fianza = fianza
            
        #end
        
        
        
        def debo_ir_a_carcel
            
            debo = super.debo_ir_a_carcel() && !pagar_fianza()
            
            return debo
            
        end
        
        def pagar_fianza
            
            pagada = false
            
            if(tengo_saldo(@fianza))
                modificar_saldo(-@fianza)
            end
            
            return pagada
            
        end
        
        
        def pagar_impuesto
            modificar_saldo( -( @saldo - @casilla_actual.coste)/2 )
        end
        
         def puedo_edificar_casa(titulo)
            puedo = tengo_saldo(titulo.precio_edificar) && titulo.num_casas < 8
            
            return puedo
        end
        
        def puedo_edificar_hotel(titulo)
            puedo = tengo_saldo(titulo.precio_edificar) && titulo.num_casas >= 4 && titulo.num_hoteles < 8
            
            return puedo
        end
        
        
        def convertirme(fianza)
            @fianza = fianza
            return self
        end
        
        
        def to_s
            
            texto = "\nFianza: " + @fianza.to_s
            texto += super.to_s()
            
            
            return texto
        end
        
        
        private :fianza, :pagar_fianza
        
        
        
        
    end
end
