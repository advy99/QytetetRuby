# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
    
    class TituloPropiedad
        
        attr_accessor :hipotecada, :propietario
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
            @propietario = nil
            
        end
        
        
        
        def calcular_coste_cancelar() # int
            raise NotImplementedError
        end
        
        def calcular_coste_hipotecar() # int
            raise NotImplementedError
        end
        
        def calcular_importe_alquiler() # int
            raise NotImplementedError
        end
        
        def calcular_precio_venta() # int
            raise NotImplementedError
        end
        
        def cancelar_hipoteca() # void
            raise NotImplementedError
        end
        
        def cobrar_alquiler(coste) # void
            raise NotImplementedError
        end
        
        def edificar_casa() # void
            raise NotImplementedError
        end
        
        def edificar_hotel() # void
            raise NotImplementedError
        end
        
        def hipotecar() # int
            raise NotImplementedError
        end
        
        def pagar_alquiler() # int
            raise NotImplementedError
        end
        
        def propietario_encarcelado() # boolean
            raise NotImplementedError
        end
        
        def tengo_propietario() # boolean
            raise NotImplementedError
        end
        
        
        def to_s()
            return "Titulo propiedad: \n" +
                    "\t Nombre: " + @nombre + "\n" +
                    "\t Hipotecada: " + @hipotecada.to_s + "\n" +
                    "\t Precio de compra: " + @precio_compra.to_s + "\n" +
                    "\t Alquiler base: " + @alquiler_base.to_s + "\n" +
                    "\t Factor revalorizacion: " + @factor_revalorizacion.to_s + "\n" +
                    "\t Hipoteca base: " + @hipoteca_base.to_s + "\n" +
                    "\t Precio para edificar: " + @precio_edificar.to_s + "\n" +
                    "\t Numero de casas: " + @num_casas.to_s + "\n" +
                    "\t Numero de hoteles: " + @num_hoteles.to_s + "\n\n"
        end        
        
    end
    
end
