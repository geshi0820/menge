module Menge
  class Set < ::Set
    JUDGEMENT = ->(obj, set) { obj.is_a?(Set) ? obj.contained?(set) : set.include?(obj) }

    def contained?(set)
      set.subset?(self)
    end
  end
end
