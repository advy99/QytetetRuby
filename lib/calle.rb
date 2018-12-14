# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


require_relative "tipo_casilla"

module ModeloQytetet
    class Calle < Casilla
        
        attr_accessor :titulo
        
        def initialize(n_casilla, n_titulo)
            super(n_casilla, n_titulo.precio_compra, TipoCasilla::CALLE)
            
            @titulo = n_titulo
            
        end
        
        
        def asignar_propietario(jugador) 
            @titulo.propietario = jugador
            
        end
        
        def pagar_alquiler() # int
            return @titulo.pagar_alquiler()
        end
        
        def soy_edificable() #booelan 
            return true
        end
        
        def tengo_propietario() # boolean
            return @titulo.tengo_propietario()
        end
        
        def to_s
            texto = super.to_s
            
            if @titulo != nil
                texto += @titulo.to_s
            end
            
            return texto
        end
        
        

        private :titulo=

    end
end
