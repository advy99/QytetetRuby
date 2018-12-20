# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "controlador_qytetet"


module VistaTextualQytetet
    class VistaTextualQytetet
        
        include ControladorQytetet
        
        attr_reader :controlador
        
        def initialize
            @controlador = ControladorQytetet.instance
        end
        
        
        def elegir_casilla(ordinal_opcion_menu) #int
            casillas_validas = @controlador.obtener_casillas_validas(ordinal_opcion_menu)
            
            casillas = Array.new
            
            valor_devolver = -1
            
            if casillas_validas.empty?
                return valor_devolver
            else
                for i in casillas_validas
                    puts " \n " + i.to_s + " \n "
                    casillas << i.to_s

                end
               
                valor_devolver = leer_valor_correcto(casillas).to_i
                
            end
            
            return valor_devolver
            
        end
        
        
        def obtener_nombre_jugadores
            num_jugadores = 0
            
            nombres = Array.new
            
            num_jugadores_validos = Array.new 
            
            num_jugadores_validos << "2"
            num_jugadores_validos << "3"
            num_jugadores_validos << "4"
            
            puts "\nIntroduce el numero de jugadores (de 2 a 4):\n"
            
            num_jugadores = leer_valor_correcto(num_jugadores_validos).to_i
            
            
            for i in 1..num_jugadores
                puts "Introduce el nombre del jugador:" + i.to_s + "\n"
                nombres << gets
            end
            
            return nombres
            
        end
        
        def leer_valor_correcto(valores_correctos) #string

            valor = gets.chomp
            
            until valores_correctos.include?(valor)
                puts "\nERROR: No has introducido un valor correcto, vuelve a probar.\n"
                valor = gets.chomp
            end
            
            return valor
            
            
        end
        
        
        def elegir_operacion() #int
            operaciones_validas_entero = @controlador.obtener_operaciones_juego_validas()
                        
            operaciones_validas = Array.new
            
            for i in operaciones_validas_entero
                operaciones_validas << i.to_s
                
                
                puts i.to_s + " : " + OpcionMenu.at(i).to_s
               
            end
            
            operacion = leer_valor_correcto(operaciones_validas).to_i
            
            return operacion
        end
        
        
        
        def self.main
            ui = VistaTextualQytetet.new
            
            ui.controlador.nombre_jugadores = ui.obtener_nombre_jugadores()
            
            operacion_elegida = 0
            casilla_elegida = 0
                        
            while 1 == 1
                operacion_elegida = ui.elegir_operacion()
                necesita_elegir_casilla = ui.controlador.necesita_elegir_casilla(operacion_elegida)
                
                if necesita_elegir_casilla
                    casilla_elegida = ui.elegir_casilla(operacion_elegida)
                end
                
                if (not necesita_elegir_casilla) or casilla_elegida >= 0
                    puts "\n" + ui.controlador.realizar_operacion(operacion_elegida, casilla_elegida) + "\n"
                end
                
            end
        end
        
        
    end
    
    VistaTextualQytetet.main
    
end
