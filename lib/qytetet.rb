#encoding: utf-8

require_relative "sorpresa"

module ModeloQytetet
   
    class Qytetet
        
        #consultor de mazo
        attr_reader :mazo
        
        #En la creacion, asignamos al mazo un Array vacio
        def initialize
            @mazo = Array.new
        end
        
        #Inicializamos el mazo con sorpresas
        def inicializarCartasSorpresa
            
            @mazo << Sorpresa.new("Un fan anónimo ha pagado tu fianza. Sales " +
                 "de la cárcel", 0, TipoSorpresa::SALIRCARCEL);
        
            @mazo << Sorpresa.new("Por ir tan rápido debes pagar una multa de" +
                    "500 euros", -500, TipoSorpresa::PAGARCOBRAR);

            @mazo << Sorpresa.new("Por ser tan buen programador te damos un " +
                    "premio de 1000 euros", 1000, TipoSorpresa::PAGARCOBRAR);

            @mazo << Sorpresa.new("Es tu cumpleaños y tus compañeros son" +
                   " generosos, cada jugador te da 200 euros", 200,
                    TipoSorpresa::PORJUGADOR);

            @mazo << Sorpresa.new("No era tu cumpleaños, ¡mentiroso!. Debes " +
                   "darle a los demás lo que te han dado con intereses, " + 
                   "300 euros a cada uno", -300, TipoSorpresa::PORJUGADOR);
             
            @mazo << Sorpresa.new("Eres muy emprendedor, obtienes 100 euros "+
                   "por cada casa y hotel que poseas",
                    100, TipoSorpresa::PORCASAHOTEL);

            @mazo << Sorpresa.new("Tienes demasiadas propiedades, deja algo " +
                   "para los demás. Paga 150 euros por cada casa y hotel", -150, 
                    TipoSorpresa::PORCASAHOTEL);

            @mazo << Sorpresa.new("Te hemos pillado con chanclas y calcetines," +
                    "lo sentimos, ¡debes ir a la carcel!",
                     9, TipoSorpresa::IRACASILLA);

            @mazo << Sorpresa.new("Has tenido suerte, vas a cobrar sin trabajar." +
                    "Ve a la casilla de salida.", 0, TipoSorpresa::IRACASILLA);

            @mazo << Sorpresa.new("Encuentras un atajo en el camino.",
                    18, TipoSorpresa::IRACASILLA);
        end
        
    end

end