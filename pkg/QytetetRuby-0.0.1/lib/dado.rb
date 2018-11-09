# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "singleton"

module ModeloQytetet
    class Dado
        include Singleton
        
        attr_reader :valor
        
        def initialize
            @valor
        end
        
        def tirar
            @valor = rand(1..6)
            
            return @valor
        end
        
        
        def to_s()
            texto = ""
        
            texto += "\nValor del dado: " + @valor.to_s + "\n"
        
            return texto
        end
        
        
        private :valor
        
    end
end
