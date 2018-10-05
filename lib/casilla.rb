# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "tipo_casilla"

module ModeloQytetet
    class Casilla
        
        attr_reader :numero_casilla, :coste,:tipo,:titulo
        
        private_class_method :new
                
        def initialize(n_casilla, n_coste, n_tipo, n_titulo )
            @numero_casilla = n_casilla
            @coste = n_coste
            @tipo = n_tipo
            set_titulo(n_titulo)
        end
        
        def self.crear_casilla(n_casilla, n_coste, n_tipo)
            self.new(n_casilla, n_coste, n_tipo, nil)
        end
        
        def self.crear_casilla_calle(n_casilla, n_titulo)
            self.new(n_casilla, n_titulo.precio_compra,
                     TipoCasilla::CALLE, n_titulo)
        end
    
        def to_s
            texto = "";

            texto += "Numero de casilla: " + @numero_casilla + "\n" +
                     "Tipo de casilla: " + @tipo + "\n" +
                     "Coste: " + @coste + "\n ";

            if @tipo == TipoCasilla::CALLE and @titulo != nil
                texto += @titulo.to_s
            end
            

            return texto;
        end
        
        private
          def set_titulo(n_titulo)
            @titulo = n_titulo
          end
         
    end
end
