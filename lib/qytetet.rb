#encoding: utf-8

require "singleton"

require_relative "sorpresa"
require_relative "tablero"
require_relative "dado"
require_relative "jugador"

module ModeloQytetet
   
    class Qytetet
        
        include Singleton
        
        attr_reader :mazo,:tablero, :dado, :jugador_actual, :jugadores,
                    :MAX_JUGADORES, :NUM_SORPRESAS, :NUM_CASILLAS,
                    :PRECIO_LIBERTAD, :SALDO_SALIDA
                  
        attr_accessor :carta_actual
        
        
        @@MAX_JUGADORES = 4
        @@NUM_SORPRESAS = 10
        @@NUM_CASILLAS = 20
        @@PRECIO_LIBERTAD = 200
        @@SALDO_SALIDA = 1000
        
        
        #En la creacion, asignamos al mazo un Array vacio
        def initialize
            @mazo = Array.new
            @tablero = Tablero.new
            @dado = Dado.instance
            @carta_actual
            @jugador_actual
            @jugadores = Array.new
        end
        
        #Inicializamos el mazo con sorpresas
        def inicializar_cartas_sorpresa
            
            @mazo << Sorpresa.new("Un fan anónimo ha pagado tu fianza. Sales " +
                 "de la cárcel", 0, TipoSorpresa::SALIRCARCEL)
        
            @mazo << Sorpresa.new("Por ir tan rápido debes pagar una multa de" +
                    "500 euros", -500, TipoSorpresa::PAGARCOBRAR)

            @mazo << Sorpresa.new("Por ser tan buen programador te damos un " +
                    "premio de 1000 euros", 1000, TipoSorpresa::PAGARCOBRAR)

            @mazo << Sorpresa.new("Es tu cumpleaños y tus compañeros son" +
                   " generosos, cada jugador te da 200 euros", 200,
                    TipoSorpresa::PORJUGADOR)

            @mazo << Sorpresa.new("No era tu cumpleaños, ¡mentiroso!. Debes " +
                   "darle a los demás lo que te han dado con intereses, " + 
                   "300 euros a cada uno", -300, TipoSorpresa::PORJUGADOR)
             
            @mazo << Sorpresa.new("Eres muy emprendedor, obtienes 100 euros "+
                   "por cada casa y hotel que poseas",
                    100, TipoSorpresa::PORCASAHOTEL)

            @mazo << Sorpresa.new("Tienes demasiadas propiedades, deja algo " +
                   "para los demás. Paga 150 euros por cada casa y hotel", -150, 
                    TipoSorpresa::PORCASAHOTEL)

            @mazo << Sorpresa.new("Te hemos pillado con chanclas y calcetines," +
                    "lo sentimos, ¡debes ir a la carcel!",
                     @tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)

            @mazo << Sorpresa.new("Has tenido suerte, vas a cobrar sin trabajar." +
                    "Ve a la casilla de salida.", 0, TipoSorpresa::IRACASILLA)

            @mazo << Sorpresa.new("Encuentras un atajo en el camino.",
                    18, TipoSorpresa::IRACASILLA)
        end
        
                
        def inicializar_tablero
            @tablero = Tablero.new
        end
        
        def actuar_si_en_casilla_edificable()
            raise NotImplementedError
        end
        
        def actuar_si_en_casilla_no_edificable() 
            raise NotImplementedError
        end
        
        def aplicar_sorpresa()
            raise NotImplementedError
        end
        
        def cancelar_hipoteca(numero_casilla)# : boolean
            raise NotImplementedError
        end
        
        def comprar_titulo_propiedad()# : boolean
            raise NotImplementedError
        end
        
        def edificar_casa(numero_casilla) #: boolean
            raise NotImplementedError
        end
        
        def edificar_hotel(numero_casilla)# : boolean
            raise NotImplementedError
        end
        
        def encarcelar_jugador()# : void
            raise NotImplementedError
        end
        
        def hipotecar_propiedad(numero_casilla ) # : void
            raise NotImplementedError
        end 
        
        def inicializar_juego(nombres) # : void
            
            inicializar_jugadores(nombres)
            inicializar_tablero
            inicializar_cartas_sorpresa
            
            @jugador_actual = @jugadores.at(0)


        end
        
        def inicializar_jugadores(nombres) # : void
            
            for n in nombres
                @jugadores << Jugador.new(n, @tablero.casillas.at(0))
            end

        end
        
        def intentar_salir_carcel(metodo) # : boolean
            raise NotImplementedError
        end
        
        def jugar() # : void
            raise NotImplementedError
        end
        
        def mover(num_casilla_destino) # : void
            raise NotImplementedError
        end
        
        def obtener_casilla_jugador_actual() # : Casilla
            raise NotImplementedError
        end
        
        def obtener_casillas_tablero() # : Casilla [NUM_CASILLAS]
            raise NotImplementedError
        end
        
        def obtener_propiedades_jugador() # : int[0..*]
            raise NotImplementedError
        end
        
        def obtener_propiedades_jugador_segun_estado_hipoteca(estado_hipoteca) # : int[0..*]
            raise NotImplementedError
        end
        
        def obtener_ranking() # : void
            raise NotImplementedError
        end
        
        def obtener_saldo_jugador_actual() # : int
            raise NotImplementedError
        end
        
        def salida_jugadores() # : void
            raise NotImplementedError
        end
        
        def siguiente_jugador() # : void
            raise NotImplementedError
        end
        
        def tirar_dado() # : int
            raise NotImplementedError
        end
        
        def vender_propiedad(numero_casilla) # : boolean
            raise NotImplementedError
        end
        
        def to_s
            texto = ""

            texto += "Maximo de jugadores: " + @@MAX_JUGADORES.to_s + "\n"+
                     "Numero de cartas sorpresa: " + @@NUM_SORPRESAS.to_s + "\n"+
                     "Numero de casillas: " + @@NUM_CASILLAS.to_s + "\n" +
                     "Precio de libertad: " + @@PRECIO_LIBERTAD.to_s + "\n" +
                     "Saldo al pasar por Salida: " + @@SALDO_SALIDA.to_s + "\n\n"

            texto += dado.to_s

            texto += tablero.to_s

            for j in jugadores
                texto += j.to_s
            end

            texto += @carta_actual.to_s

            texto += "\nJugador actual: " + @jugador_actual.nombre + "\n"

            return texto
        end
    
                
        private :encarcelar_jugador, :inicializar_cartas_sorpresa,
                :inicializar_jugadores, :inicializar_tablero, :salida_jugadores,
                :carta_actual
        
        
    end

end