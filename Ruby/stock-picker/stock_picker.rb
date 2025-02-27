def stock_picker(prices)
  best_value = 0
  best_buy_day = 0
  best_sell_day = 0

  prices.each_with_index do |sell_price, sell_day|
    (0...sell_day).each do |buy_day|
      profit = sell_price - prices[buy_day]
      if profit > best_value
        best_value = profit
        best_buy_day = buy_day
        best_sell_day = sell_day
      end
    end
  end

  [best_buy_day, best_sell_day]
end

puts stock_picker([17,3,6,9,15,8,6,1,10])
