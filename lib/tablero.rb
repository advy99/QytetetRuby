# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "titulo_propiedad"
require_relative "casilla"
require_relative "calle"

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
            
            t1  = TituloPropiedad.new( "DEIIT", 713, 207,
                                                 1.3, 3000, 300);
        
            t2  = TituloPropiedad.new( "OSL", 1300, 400,
                                                 1.9, 4000, 600);
        
            t3  = TituloPropiedad.new( "UGR", 599, 150,
                                                 0.9, 1400, 1975);
        
            t4  = TituloPropiedad.new( "Matematica Aplicada", 1720, 450,
                                                 1, 4000, 1999);
        
            t5  = TituloPropiedad.new( "EIO", 502, 130,
                                                 0.6, 900, 800);
        
            t6  = TituloPropiedad.new( "ETC", 912, 234,
                                                 0.8, 1800, 1120);
        
            t7  = TituloPropiedad.new( "TSCS", 3290, 700,
                                                 2.5, 6000, 2800);
        
            t8  = TituloPropiedad.new( "Analisis Matematico", 560, 140,
                                                 2.9, 1200, 600);
        
            t9  = TituloPropiedad.new( "Algebra", 1543, 320,
                                                 1.2, 3500, 2000);

            t10 = TituloPropiedad.new( "DECSAI", 3198, 690,
                                                 2.2, 10000, 1790);

            t11 = TituloPropiedad.new( "LSI", 587, 100,
                                                 0.2, 10000, 400);

            t12 = TituloPropiedad.new( "ATC", 890, 300,
                                                 3.2, 10000, 200);



            @casillas << (Casilla.new(0,1000, TipoCasilla::SALIDA));
            @casillas << (Calle.new(1, t1));
            @casillas << (Calle.new(2, t2));
            @casillas << (Calle.new(3, t3));
            @casillas << (Casilla.new(4, 0, TipoCasilla::SORPRESA));
            @casillas << (Calle.new(5, t4));
            @casillas << (Casilla.new(6, 700, TipoCasilla::IMPUESTO));
            @casillas << (Calle.new(7, t5));
            @casillas << (Calle.new(8, t6));
            @casillas << (Casilla.new(9, 0, TipoCasilla::CARCEL));
            @casillas << (Calle.new(10, t7));
            @casillas << (Calle.new(11, t8));
            @casillas << (Casilla.new(12, 0, TipoCasilla::SORPRESA));
            @casillas << (Calle.new(13, t9));
            @casillas << (Casilla.new(14, 0, TipoCasilla::PARKING));
            @casillas << (Calle.new(15, t10));
            @casillas << (Casilla.new(16, 0, TipoCasilla::SORPRESA));
            @casillas << (Calle.new(17, t11));
            @casillas << (Casilla.new(18, 0, TipoCasilla::JUEZ));
            @casillas << (Calle.new(19, t12));
            
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
