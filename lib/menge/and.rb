module Menge
  class And < Set
    def contained?(set)
      all? { |cond| JUDGEMENT.(cond, set) }
    end
  end
end
