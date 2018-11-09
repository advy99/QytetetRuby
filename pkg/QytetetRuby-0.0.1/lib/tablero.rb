# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "titulo_propiedad"
require_relative "casilla"

module ModeloQytetet
    class Tablero
        
        attr_reader :casillas,:carcel
        
        def initialize
            @casillas
            @carcel
            inicializar()
        end
        
        
        
        def to_s
            texto = "\n\nTablero: \n"
            
            for c in @casillas
                texto += c.to_s
            end
            
            texto += "\n\n"
            
            return texto
        end
                
        def inicializar
            @casillas = Array.new
            
            t1  = TituloPropiedad.new( "Calle", 713, 207,
                                                 1.3, 3000, 300);
        
            t2  = TituloPropiedad.new( "Avenida", 1300, 400,
                                                 1.9, 4000, 600);
        
            t3  = TituloPropiedad.new( "Carretera", 599, 150,
                                                 0.9, 1400, 1975);
        
            t4  = TituloPropiedad.new( "Rotonda", 1720, 450,
                                                 1, 4000, 1999);
        
            t5  = TituloPropiedad.new( "Acera", 502, 130,
                                                 0.6, 900, 800);
        
            t6  = TituloPropiedad.new( "CarrilBici", 912, 234,
                                                 0.8, 1800, 1120);
        
            t7  = TituloPropiedad.new( "Metro", 3290, 700,
                                                 2.5, 6000, 2800);
        
            t8  = TituloPropiedad.new( "Bus", 560, 140,
                                                 2.9, 1200, 600);
        
            t9  = TituloPropiedad.new( "Taxi", 1543, 320,
                                                 1.2, 3500, 2000);

            t10 = TituloPropiedad.new( "Coche", 3198, 690,
                                                 2.2, 10000, 1790);

            t11 = TituloPropiedad.new( "Tranvia", 587, 100,
                                                 0.2, 10000, 400);

            t12 = TituloPropiedad.new( "Limusina", 890, 300,
                                                 3.2, 10000, 200);



            @casillas << (Casilla.crear_casilla(0,1000, TipoCasilla::SALIDA));
            @casillas << (Casilla.crear_casilla_calle(1, t1));
            @casillas << (Casilla.crear_casilla_calle(2, t2));
            @casillas << (Casilla.crear_casilla_calle(3, t3));
            @casillas << (Casilla.crear_casilla(4, 0, TipoCasilla::SORPRESA));
            @casillas << (Casilla.crear_casilla_calle(5, t4));
            @casillas << (Casilla.crear_casilla(6, 700, TipoCasilla::IMPUESTO));
            @casillas << (Casilla.crear_casilla_calle(7, t5));
            @casillas << (Casilla.crear_casilla_calle(8, t6));
            @casillas << (Casilla.crear_casilla(9, 0, TipoCasilla::CARCEL));
            @casillas << (Casilla.crear_casilla_calle(10, t7));
            @casillas << (Casilla.crear_casilla_calle(11, t8));
            @casillas << (Casilla.crear_casilla(12, 0, TipoCasilla::SORPRESA));
            @casillas << (Casilla.crear_casilla_calle(13, t9));
            @casillas << (Casilla.crear_casilla(14, 0, TipoCasilla::PARKING));
            @casillas << (Casilla.crear_casilla_calle(15, t10));
            @casillas << (Casilla.crear_casilla(16, 0, TipoCasilla::SORPRESA));
            @casillas << (Casilla.crear_casilla_calle(17, t11));
            @casillas << (Casilla.crear_casilla(18, 0, TipoCasilla::JUEZ));
            @casillas << (Casilla.crear_casilla_calle(19, t12));
            
            @carcel = @casillas[9]

        end
        
        def es_casilla_carcel (numero_casilla) #boolean
            return @carcel.numero_casilla == numero_casilla
        end
        
        def obtener_casilla_final (casilla, desplazamiento) # casilla
            return @casillas.at(( casilla.numero_casilla + desplazamiento ) % 20);
        end
        
        
        # PRE: 0 <= numero_casilla < NUM_CASILLAS
        def obtener_casilla_numero (numero_casilla) # casilla
            return @casillas.at(numero_casilla)
        end
        
        def to_s()
     
            texto = "\n"

            for s in casillas
                texto += s.to_s
            

            texto += "\n\n"

            end
            
            return texto

        end      
        
                
        private :inicializar
        
    end
end
