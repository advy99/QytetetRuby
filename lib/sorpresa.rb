#encoding: utf-8

require_relative "tipo_sorpresa"

module ModeloQytetet
  
  class Sorpresa
    
    attr_reader :texto,:tipo,:valor
    
    def initialize(text, val, type)
      @texto = text
      @tipo = type
      @valor = val
    end
    
    def to_s
      return "Texto: #{@texto} \n Valor: #{@valor} \n Tipo: #{@tipo}"
    end
    
    
  end

end
