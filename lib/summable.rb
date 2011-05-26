module Summable  
  class << self

    def total_cost(arr)
      to_sum(arr, :cost)
    end
  
    def total_effort(arr)
      to_sum(arr, :effort)
    end
  
    def hours(time)
      time.to_i.divmod(60)[0]
    end
  
    def minutes(time)
      time.to_i.divmod(60)[1]    
    end
  
    def to_sum(arr, meth)
      arr.map(&meth).compact.inject { |sum, n| sum + n.to_f }
    end

  end
  
end