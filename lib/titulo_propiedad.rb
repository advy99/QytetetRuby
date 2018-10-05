# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
    
    class TituloPropiedad
        
        attr_accessor :hipotecada
        attr_reader :nombre,:precio_compra,:alquiler_base,:factor_revalorizacion,
                    :hipoteca_base,:precio_edificar,:num_casas,:num_hoteles
        
        
        def initialize(n_nombre, n_p_compra, n_alquiler, n_revalorizacion,
                       n_h_base, n_p_edificar)
            @nombre = n_nombre
            @hipotecada = false
            @precio_compra = n_p_compra
            @alquiler_base = n_alquiler
            @factor_revalorizacion = n_revalorizacion
            @hipoteca_base = n_h_base
            @precio_edificar = n_p_edificar
            @num_casas = 0
            @num_hoteles = 0
            
        end
        
        def to_s
            return "Titulo propiedad: \n" +
                    "\t Nombre: " + @nombre + "\n" +
                    "\t Hipotecada: " + @hipotecada + "\n" +
                    "\t Precio de compra: " + @precio_compra + "\n" +
                    "\t Alquiler base: " + @alquiler_base + "\n" +
                    "\t Factor revalorizacion: " + @factor_revalorizacion + "\n" +
                    "\t Hipoteca base: " + @hipoteca_base + "\n" +
                    "\t Precio para edificar: " + @precio_edificar + "\n" +
                    "\t Numero de casas: " + @num_casas + "\n" +
                    "\t Numero de hoteles: " + @num_hoteles + "\n\n"
    
        end
        
    end
    
end
