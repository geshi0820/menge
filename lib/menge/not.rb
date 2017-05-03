module Menge
  class Or < Set
    def contained?(set)
      none? { |cond| JUDGEMENT.(cond, set) }
    end
  end
end
