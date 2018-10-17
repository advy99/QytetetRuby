# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "tipo_casilla"

module ModeloQytetet
    class Casilla
        
        attr_accessor :titulo
        
        attr_reader :numero_casilla, :coste, :tipo
        
                
        def initialize(n_casilla, n_coste, n_tipo, n_titulo )
            @numero_casilla = n_casilla
            @coste = n_coste
            @tipo = n_tipo
            @titulo = n_titulo
        end
        
        def self.crear_casilla(n_casilla, n_coste, n_tipo)
            new(n_casilla, n_coste, n_tipo, nil)
        end
        
        def self.crear_casilla_calle(n_casilla, n_titulo)
            new(n_casilla, n_titulo.precio_compra,
                     TipoCasilla::CALLE, n_titulo)
        end
    
        def to_s
            texto = ""

            texto += "Numero de casilla: " + @numero_casilla.to_s + "\n" +
                     "Tipo de casilla: " + @tipo.to_s + "\n" +
                     "Coste: " + @coste.to_s + "\n "

            if @tipo == TipoCasilla::CALLE and @titulo != nil
                texto += @titulo.to_s
            end
            

            return texto;
        end
        
        def asignar_propietario(jugador) # titulo_propiedad
            raise NotImplementedError
        end
        
        def pagar_alquiler() # int
            raise NotImplementedError
        end
        
        def propietario_encarcelado() #boolean
            raise NotImplementedError
        end
        
        def soy_edificable() #booelan 
            raise NotImplementedError
        end
        
        def tengo_propietario() #boolean
            raise NotImplementedError
        end
        
        private :titulo
        
        private_class_method :new

         
    end
end
