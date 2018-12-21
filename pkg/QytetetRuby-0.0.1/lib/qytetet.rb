#encoding: utf-8

require "singleton"

require_relative "sorpresa"
require_relative "tablero"
require_relative "dado"
require_relative "jugador"
require_relative "especulador"
require_relative "estado_juego"
require_relative "metodo_salir_carcel"

module ModeloQytetet
   
    class Qytetet
        
        include Singleton
        
        attr_reader :mazo,:tablero, :dado, :jugador_actual, :jugadores,
                    :MAX_JUGADORES, :NUM_SORPRESAS, :NUM_CASILLAS,
                    :PRECIO_LIBERTAD, :SALDO_SALIDA
                  
        attr_accessor :carta_actual, :estado_juego
        
        
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
            @estado_juego
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
                   "300 euros a cada uno", 300, TipoSorpresa::PORJUGADOR)
             
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
                    15, TipoSorpresa::IRACASILLA)
                
            @mazo << Sorpresa.new("Tienes buen ojo para los negocios " +
                 "inmobiliarios, te dedicas a ello  ", 3000, TipoSorpresa::CONVERTIRME)
        
            @mazo << Sorpresa.new("Te aburres y decides dedicarte al sector inmobiliario",
                               5000, TipoSorpresa::CONVERTIRME)
            
            
            
            
            @mazo = @mazo.shuffle
            
        end
        
                
        def inicializar_tablero
            @tablero = Tablero.new
        end
       
        
        
        def actuar_si_en_casilla_edificable()
            debo_pagar = @jugador_actual.debo_pagar_alquiler()
          
            
            if (debo_pagar)
                @jugador_actual.pagar_alquiler()
                
                if (@jugador_actual.saldo <= 0)
                    @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                end
            end
            
            casilla = obtener_casilla_jugador_actual()
            
            tengo_propietario = casilla.tengo_propietario()
            
            if(@estado_juego != EstadoJuego::ALGUNJUGADORENBANCARROTA)
                if (tengo_propietario)
                    @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
                else
                    @estado_juego = EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
                end
                
            end
            
        end
        
        def actuar_si_en_casilla_no_edificable() 
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
            
            casilla_actual = @jugador_actual.casilla_actual
            
            if (casilla_actual.tipo == TipoCasilla::IMPUESTO)
                @jugador_actual.pagar_impuesto()
                
                if(@jugador_actual.saldo <= 0)
                    @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                end
            else
               if (casilla_actual.tipo == TipoCasilla::JUEZ)
                   encarcelar_jugador()
               else if (casilla_actual.tipo == TipoCasilla::SORPRESA )
                        @carta_actual = @mazo.at(0);
                       
                        @mazo.delete_at(0);
                       
                        @estado_juego = EstadoJuego::JA_CONSORPRESA
                    end
               end
            end
        end
        
        def aplicar_sorpresa()
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
            
            
            if (@carta_actual.tipo == TipoSorpresa::SALIRCARCEL)
                
                @jugador_actual.carta_libertad = @carta_actual
                
            else
                
                @mazo << @carta_actual
               
                if (@carta_actual.tipo == TipoSorpresa::PAGARCOBRAR)
                    
                    @jugador_actual.modificar_saldo(@carta_actual.valor)
                    
                    if (@jugador_actual.saldo <= 0)
                        @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                    end
                    
                elsif (@carta_actual.tipo == TipoSorpresa::IRACASILLA)
                        
                        valor = @carta_actual.valor
                        
                        casilla_carcel = @tablero.es_casilla_carcel(valor)
                        
                        if(casilla_carcel)
                            encarcelar_jugador()
                        else
                           mover(valor) 
                        end
                        
                        
                        
                elsif (@carta_actual.tipo == TipoSorpresa::PORCASAHOTEL)
                        
                        cantidad = @carta_actual.valor
                        
                        numero_total = @jugador_actual.cuantas_casas_hoteles_tengo()
                        
                        @jugador_actual.modificar_saldo(cantidad * numero_total)
                    
                        if (@jugador_actual.saldo <= 0)
                            @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                        end
                    
                            
                elsif (@carta_actual.tipo == TipoSorpresa::PORJUGADOR)
                        
                        for j in @jugadores
                            if (j != @jugador_actual)
                                j.modificar_saldo(@carta_actual.valor)
                                
                                if (j.saldo <= 0)
                                    @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                                end
                                
                                @jugador_actual.modificar_saldo(-@carta_actual.valor)
                                
                                if (@jugador_actual.saldo <= 0)
                                    @estado_juego = EstadoJuego::ALGUNJUGADORENBANCARROTA
                                end
                                        
                                        
                            end
                        end
                        
                     
                elsif (@carta_actual.tipo == TipoSorpresa::CONVERTIRME)    
                    posicion = @jugadores.index(@jugador_actual);
                
                    especulador = @jugador_actual.convertirme(@carta_actual.valor);

                    @jugadores[posicion] = especulador

                    @jugador_actual = especulador
                    
                    
                end         

                
            end
            
        end
        
        def cancelar_hipoteca(numero_casilla)# : boolean
            cancelada = false

            casilla = @tablero.obtener_casilla_numero(numero_casilla)

            titulo = casilla.titulo()

            cancelada = @jugador_actual.cancelar_hipoteca(titulo)

            @estadoJuego = EstadoJuego::JA_PUEDEGESTIONAR

            return cancelada
        end
        
        def comprar_titulo_propiedad()# : boolean
            comprado = @jugador_actual.comprar_titulo_propiedad()
            
            if (comprado)
                @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
            end
            
            return comprado
        end
        
        def edificar_casa(numero_casilla) #: boolean
            casilla = @tablero.obtener_casilla_numero(numero_casilla)
            
            titulo = casilla.titulo;
            
            edificada = @jugador_actual.edificar_casa(titulo)
            
            if (edificada)
                @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
            end
            
            return edificada
            
        end
        
        def edificar_hotel(numero_casilla)# : boolean
            casilla = @tablero.obtener_casilla_numero(numero_casilla)
            
            titulo = casilla.titulo
            
            edificado = @jugador_actual.edificar_hotel(titulo)
            
            if (edificado)
                @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
            end
            
            return edificado
            
        end
        
        def encarcelar_jugador()# : void
            if (@jugador_actual.debo_ir_a_carcel())
                casilla_carcel = @tablero.carcel

                @tablero.ir_a_carcel(casilla_carcel)
                
                @estado_juego = EstadoJuego::JA_ENCARCELADO
            else
                carta = @jugador_actual.devolver_carta_libertad()
                
                @mazo << carta
                
                @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
                
                
            end
            
            
        end
        
        def hipotecar_propiedad(numero_casilla ) # : void
            casilla = @tablero.obtener_casilla_numero(numero_casilla)
            
            titulo = casilla.titulo
            
            @jugador_actual.hipotecar_propiedad(titulo)
            
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
            
            
        end 
        
        def inicializar_juego(nombres) # : void
            
            inicializar_jugadores(nombres)
            inicializar_tablero
            inicializar_cartas_sorpresa
            salida_jugadores
            

        end
        
        def inicializar_jugadores(nombres) # : void
            
            for n in nombres
                @jugadores << Jugador.nuevo(n)
            end

        end
        
        def intentar_salir_carcel(metodo) # : boolean
            if (metodo == MetodoSalirCarcel::TIRANDODADO)
                
                resultado = tirar_dado()
                
                if (resultado >= 5)
                    @jugador_actual.encarcelado = false
                end
                
            elsif (metodo == MetodoSalirCarcel::PAGANDOLIBERTAD)
                
                @jugador_actual.pagar_libertad(@@PRECIO_LIBERTAD)
                
            end
            
            encarcelado = @jugador_actual.encarcelado
            
            if (encarcelado)
                @estado_juego = EstadoJuego::JA_ENCARCELADO
            else
                @estado_juego = EstadoJuego::JA_PREPARADO
            end
            
            return !encarcelado
        end
        
        def jugar() # : void
            v_dado = tirar_dado()
            
            c_final = @tablero.obtener_casilla_final(@jugador_actual.casilla_actual, v_dado)
        
          
            mover(c_final.numero_casilla)
            
        end
        
        def mover(num_casilla_destino) # : void
            casilla_inicial = @jugador_actual.casilla_actual
            
            casilla_final = @tablero.obtener_casilla_numero(num_casilla_destino)
            
            @jugador_actual.casilla_actual = casilla_final
            
            if (num_casilla_destino < casilla_inicial.numero_casilla)
                @jugador_actual.modificar_saldo(@@SALDO_SALIDA)
            end
            
            if (casilla_final.soy_edificable())
                actuar_si_en_casilla_edificable()
            else
                actuar_si_en_casilla_no_edificable()
            end
            
        end
        
        def obtener_casilla_jugador_actual() # : Casilla
            return @jugador_actual.casilla_actual
        end
        
        #def obtener_casillas_tablero() # : Casilla [NUM_CASILLAS]
        #    raise NotImplementedError
        #end
        
        def obtener_propiedades_jugador() # : int[0..*]
            pro = Array.new
            
            for c in @tablero.casillas
                if @jugador_actual.propiedades.include?(c.titulo)
                    pro << c.numero_casilla
                end
            end
            
            return pro
        end
        
        def obtener_propiedades_jugador_segun_estado_hipoteca(estado_hipoteca) # : int[0..*]
            pro = obtener_propiedades_jugador
            
            for i in pro
                if @tablero.obtener_casilla_numero(i).titulo != nil
                    if @tablero.obtener_casilla_numero(i).titulo.hipotecada != estado_hipoteca
                        pro.delete_at(i)
                    end
                end
            end
            
            return pro
            
        end
        
        def obtener_ranking() # : void
            @jugadores = @jugadores.sort
        end
        
        def obtener_saldo_jugador_actual() # : int
            return @jugador_actual.saldo
        end
        
        def obtener_valor_dado
            return @dado.valor
        end
        
        def salida_jugadores() # : void
            for j in @jugadores
                j.casilla_actual = @tablero.obtener_casilla_numero(0)
            end
            
            @jugador_actual = @jugadores.at(rand(@jugadores.length))
                        
            
            @estado_juego = EstadoJuego::JA_PREPARADO
            
            
        end
        
        def siguiente_jugador() # : void
            
            i = 0
            for j in @jugadores
                if j == @jugador_actual
                    n_jugador = i
                end
                
                i = i + 1 
            end
                        
            
            @jugador_actual = @jugadores.at( (n_jugador + 1) % @jugadores.length )
            
            if @jugador_actual.encarcelado
                @estado_juego = EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
            else
                @estado_juego = EstadoJuego::JA_PREPARADO
            end
            
        end
        
        def tirar_dado() # : int
            return @dado.tirar()
        end
        
        def valor_dado()
            return @dado.valor
        end
        
        def vender_propiedad(numero_casilla) # 
            casilla = @tablero.obtener_casilla_numero(numero_casilla)
            
            @jugador_actual.vender_propiedad(casilla)
            
            @estado_juego = EstadoJuego::JA_PUEDEGESTIONAR
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
                :carta_actual=
        
        private_class_method :new
        
    end

end