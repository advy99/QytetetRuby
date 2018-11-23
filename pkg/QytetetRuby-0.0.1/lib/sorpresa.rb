#encoding: utf-8

require_relative "tipo_sorpresa"

module ModeloQytetet
  
  class Sorpresa
    
    #consultor de texto, tipo y valor
    attr_reader :texto,:tipo,:valor
    
    #constructor basico
    def initialize(text, val, type)
      @texto = text
      @tipo = type
      @valor = val
    end
    
    #Pasar una sorpresa a string
    def to_s
      return "\nTexto: #{@texto} \n Valor: #{@valor} \n Tipo: #{@tipo}"
    end
    
        
  end

end
