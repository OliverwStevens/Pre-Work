def bubble_sort(data)
  n = data.length

  loop do
    swapped = false    
    (n - 1).times do |i|
      if (data[i] > data[i + 1])
        data[i], data[i + 1] = data[i + 1], data[i]  # Swap elements
        swapped = true
      end
    end
    break unless swapped  # Stop if no swaps were made
  end
  
  puts data
end

bubble_sort([4,3,78,2,0,2])