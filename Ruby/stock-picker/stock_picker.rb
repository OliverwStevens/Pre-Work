def stock_picker(prices)
  best_value = 0
  days = []
  #loop over each index
  prices.each_with_index do |price, index|
    #then loop over each index comparing for the best value in relation to the prior days
    index.times do |sub_index|
      value = price - prices[sub_index]
      if (value > best_value)
        best_value = value
        days = [sub_index, index]
      end
    end
  end
  puts(days)
end

stock_picker([17,3,6,9,15,8,6,1,10])