module Menge
  class Or < Set
    def contained?(set)
      any? { |cond| JUDGEMENT.(cond, set) }
    end
  end
end
