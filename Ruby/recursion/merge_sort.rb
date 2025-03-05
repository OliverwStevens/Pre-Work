def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..])

  sorted = []
  sorted.push(left.first <= right.first ? left.shift : right.shift) until left.empty? || right.empty?

  sorted + left + right
end

p merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
p merge_sort([105, 79, 100, 110])
