# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "singleton"

require_relative "qytetet"
require_relative "metodo_salir_carcel"
require_relative "estado_juego"
require_relative "opcion_menu"


module ControladorQytetet
    class ControladorQytetet
        
        include Singleton
        include ModeloQytetet
        
        attr_reader :modelo
        
        attr_accessor :nombre_jugadores
        
        def initialize
            @modelo = Qytetet.instance
            @nombre_jugadores = Array.new
        end
        
        
        def obtener_operaciones_juego_validas # arraylist integer
            
            operaciones_validas = Array.new
            
            if @modelo.jugadores == nil or @modelo.jugadores.empty?
                operaciones_validas << OpcionMenu.index(:INICIARJUEGO)
            else
                
                estado = @modelo.estado_juego
                
                if estado == EstadoJuego::JA_PREPARADO
                operaciones_validas << OpcionMenu.index(:JUGAR)

                elsif estado == EstadoJuego::ALGUNJUGADORENBANCARROTA
                    operaciones_validas << OpcionMenu.index(:OBTENERRANKING)

                elsif estado == EstadoJuego::JA_CONSORPRESA
                    operaciones_validas << OpcionMenu.index(:APLICARSORPRESA)

                elsif estado == EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
                    operaciones_validas << OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD)
                    operaciones_validas << OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO)

                elsif estado == EstadoJuego::JA_ENCARCELADO
                    operaciones_validas << OpcionMenu.index(:PASARTURNO)

                elsif estado == EstadoJuego::JA_PUEDEGESTIONAR
                    operaciones_validas << OpcionMenu.index(:VENDERPROPIEDAD)
                    operaciones_validas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
                    operaciones_validas << OpcionMenu.index(:CANCELARHIPOTECA)
                    operaciones_validas << OpcionMenu.index(:EDIFICARCASA)
                    operaciones_validas << OpcionMenu.index(:EDIFICARHOTEL)
                    operaciones_validas << OpcionMenu.index(:PASARTURNO)

                elsif estado == EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
                    operaciones_validas << OpcionMenu.index(:COMPRARTITULOPROPIEDAD)
                    operaciones_validas << OpcionMenu.index(:VENDERPROPIEDAD)
                    operaciones_validas << OpcionMenu.index(:HIPOTECARPROPIEDAD)
                    operaciones_validas << OpcionMenu.index(:CANCELARHIPOTECA)
                    operaciones_validas << OpcionMenu.index(:EDIFICARCASA)
                    operaciones_validas << OpcionMenu.index(:EDIFICARHOTEL)
                    operaciones_validas << OpcionMenu.index(:PASARTURNO)


                end

                operaciones_validas << OpcionMenu.index(:TERMINARJUEGO)
                operaciones_validas << OpcionMenu.index(:MOSTRARJUGADORACTUAL)
                operaciones_validas << OpcionMenu.index(:MOSTRARJUGADORES)
                operaciones_validas << OpcionMenu.index(:MOSTRARTABLERO)

                
            end
            
        end
        
        def realizar_operacion(opcion_elegida, casilla_elegida) #string
            a_devolver = ""
            
            
            
            if opcion_elegida == 0 
                @modelo.inicializar_juego(@nombre_jugadores)
                a_devolver = "\nIniciando el juego \n"
            elsif opcion_elegida == 1
                a_devolver = @modelo.jugador_actual.to_s
                @modelo.jugar()
                a_devolver += "\nHa salido un " + @modelo.obtener_valor_dado().to_s
                a_devolver += "\nEl jugador se ha movido a la casilla " + @modelo.obtener_casilla_jugador_actual().to_s

            elsif opcion_elegida == 2
                a_devolver = "\nSe va a aplicar la siguiente carta sorpresa:" + @modelo.carta_actual.to_s
                @modelo.aplicar_sorpresa()
            elsif opcion_elegida == 3
                if @modelo.intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
                    a_devolver = "\nHas conseguido salir de la carcel\n"
                else
                    a_devolver = "\nNo has conseguido salir de la carcel\n"
                end
            elsif opcion_elegida == 4
                if @modelo.intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
                    a_devolver = "\nHas conseguido salir de la carcel\n"
                else
                    a_devolver = "\nNo has conseguido salir de la carcel\n"
                end
            elsif opcion_elegida == 5
                if @modelo.comprar_titulo_propiedad()
                    a_devolver = "\nSe ha comprado el titulo correctamente\n"
                else
                    a_devolver = "\nNo se ha podido comprar el titulo\n"
                end
            elsif opcion_elegida == 6
                @modelo.hipotecar_propiedad(casilla_elegida)
            elsif opcion_elegida == 7
                @modelo.cancelar_hipoteca(casilla_elegida)
            elsif opcion_elegida == 8
                if @modelo.edificar_casa(casilla_elegida)
                    a_devolver = "\nSe ha edificado la casa correctamente\n"
                else
                    a_devolver = "\nNo se ha podido edificar la casa\n"
                end
            elsif opcion_elegida == 9
                if @modelo.edificar_hotel(casilla_elegida)
                    a_devolver = "\nSe ha edificado el hotel correctamente\n"
                else
                    a_devolver = "\nNo se ha podido edificar el hotel\n"
                end

            elsif opcion_elegida == 10
                @modelo.vender_propiedad(casilla_elegida)
            elsif opcion_elegida == 11
                @modelo.siguiente_jugador()
            elsif opcion_elegida == 12
                @modelo.obtener_ranking()
            elsif opcion_elegida == 13
                exit()
            elsif opcion_elegida == 14
                a_devolver = @modelo.jugador_actual.to_s
            elsif opcion_elegida == 15
                a_devolver = @modelo.jugadores.to_s
            elsif opcion_elegida == 16
                a_devolver = @modelo.tablero.to_s
            end

            
            
            
            
            
            return a_devolver
        end
        
        def obtener_casillas_validas(opcion_menu) # arraylist integer
            casillas_validas = Array.new
            
            opcion = OpcionMenu[opcion_menu]

            if opcion == OpcionMenu::CANCELARHIPOTECA
                casillas_validas = @modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true)
            elsif opcion == OpcionMenu::COMPRARTITULOPROPIEDAD
                casillas_validas << @modelo.obtener_casilla_jugador_actual.numero_casilla
            elsif opcion == OpcionMenu::EDIFICARCASA or opcion == OpcionMenu::EDIFICARHOTEL
                casillas_validas = @modelo.obtener_propiedades_jugador
            elsif opcion == OpcionMenu::HIPOTECARPROPIEDAD
                casillas_validas = @modelo.obtener_propiedades_jugador_segun_estado_hipoteca(false)
            elsif opcion == OpcionMenu::VENDERPROPIEDAD
                casillas_validas = @modelo.obtener_propiedades_jugador
            end
            
            return casillas_validas
        end
        
        
        def necesita_elegir_casilla(valor) #boolean
            return  (valor == OpcionMenu.index(:HIPOTECARPROPIEDAD) or
                    valor == OpcionMenu.index(:CANCELARHIPOTECA)   or
                    valor == OpcionMenu.index(:EDIFICARCASA)       or
                    valor == OpcionMenu.index(:EDIFICARHOTEL)      or
                    valor == OpcionMenu.index(:VENDERPROPIEDAD) )
            
        end
        
        
        private :modelo, :nombre_jugadores
        
        private_class_method :new
    end
end
