#encoding: utf-8

require_relative "sorpresa"
require_relative "qytetet"

module ModeloQytetet
  
    class PruebaQytetet
        @@juego = Qytetet.new
        
        def self.main
            
            @@juego.inicializarCartasSorpresa()
            
            puts "Cartas positivas: \n "
            
            for sorpresa in sorpresas_positivas(@@juego.mazo)
                puts sorpresa.to_s
            end
            
            puts "FIN CARTAS POSITIVAS \n\n"
            
            
            puts "Cartas tipo IrACasilla:"
            
            for sorpresa in sorpresas_ir_a_casilla(@@juego.mazo)
                puts sorpresa.to_s
            end
            
            puts "FIN CARTAS IrACasilla \n\n"
            
            for tipo in TipoSorpresa::constants
                puts "\nCartas tipo #{tipo} \n"
                
                for sorpresa in sorpresas_tipo(@@juego.mazo, tipo)
                    puts sorpresa.to_s
                end
                
                puts "\nFIN CARTAS #{tipo} \n\n"
            end
            
            
        end
        
        def self.sorpresas_positivas(sorpresas)
            
            sorpresas_positivas = Array.new
            
            for sorpresa in sorpresas
                if sorpresa.valor > 0
                    sorpresas_positivas << sorpresa
                end
            end
            
            return sorpresas_positivas
        end
        
        def self.sorpresas_ir_a_casilla(sorpresas)
            
            sorpresas_ir = Array.new
            
            for sorpresa in sorpresas
                if sorpresa.tipo == TipoSorpresa::IRACASILLA
                    sorpresas_ir << sorpresa
                end
            end
            
            return sorpresas_ir
            
        end
        
        def self.sorpresas_tipo(sorpresas, tipo_sorpresa)
            sorpresas_t = Array.new
            
            tipo_sorpresa = TipoSorpresa.const_get(tipo_sorpresa)
            
            for sorpresa in sorpresas
                if sorpresa.tipo == tipo_sorpresa
                    sorpresas_t << sorpresa
                end
            end
            
            return sorpresas_t
            
        end
        
    end
    
    PruebaQytetet.main
  
end