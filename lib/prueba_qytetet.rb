#encoding: utf-8


#Antonio David Villegas Yeguas

#plugin ruby
#~/Escritorio/Departamentos/lsi/pdoo/pluginNetbeansRuby/

require_relative "sorpresa"
require_relative "qytetet"

module ModeloQytetet
  
    class PruebaQytetet
        #definimos una instancia de Qytetet, que sera el juego
        @@juego = Qytetet.instance
        
        def self.main
            
            
            
            #Pruebas para mostrar cartas
            #puts "Cartas positivas: \n "
            
            #for sorpresa in sorpresas_positivas(@@juego.mazo)
            #    puts sorpresa.to_s
            #end
            
            #puts "FIN CARTAS POSITIVAS \n\n"
            
            
            #puts "Cartas tipo IrACasilla:"
            
            #for sorpresa in sorpresas_ir_a_casilla(@@juego.mazo)
            #    puts sorpresa.to_s
            #end
            
            #puts "FIN CARTAS IrACasilla \n\n"
            
            #for tipo in TipoSorpresa::constants
            #    puts "\nCartas tipo #{tipo} \n"
                
            #    for sorpresa in sorpresas_tipo(@@juego.mazo, tipo)
            #        puts sorpresa.to_s
            #    end
                
            #    puts "\nFIN CARTAS #{tipo} \n\n"
            #end
            
            @@juego.inicializar_juego(get_nombre_jugadores)
            
            puts @@juego.to_s
           
            
        end
        
        def self.get_nombre_jugadores
            num_jugadores = 0
            
            nombres = Array.new
            
            while num_jugadores < 2 or num_jugadores > 4 do
                puts "Introduce el numero de jugadores (entre 2 y 4): "
                num_jugadores = gets.chomp.to_i
            end
            
            for i in 1..num_jugadores
                puts "Introduce el nombre del jugador:" + i.to_s + "\n"
                nombres << gets
            end
            
            return nombres
            
        end
        
        #funcion para mostrar cartas con valor > 0
        def self.sorpresas_positivas(sorpresas)
            
            sorpresas_positivas = Array.new
            
            for sorpresa in sorpresas
                if sorpresa.valor > 0
                    sorpresas_positivas << sorpresa
                end
            end
            
            return sorpresas_positivas
        end
        
        #Cartas de tipo IrACasilla
        def self.sorpresas_ir_a_casilla(sorpresas)
            
            sorpresas_ir = Array.new
            
            for sorpresa in sorpresas
                if sorpresa.tipo == TipoSorpresa::IRACASILLA
                    sorpresas_ir << sorpresa
                end
            end
            
            return sorpresas_ir
            
        end
        
        #Cartas de tipo @argumento2
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