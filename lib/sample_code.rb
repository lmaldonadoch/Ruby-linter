def bubble_sort(arr)
  ordered = 1
  cont = 1
  while ordered.positive?
    ordered = 0
    (arr.length - cont).times do |i|
      next unless arr[i] > arr[i + 1]

      temp = arr[i + 1]
      arr[i + 1] = arr[i]
      arr[i] = temp
      ordered += 1
    end
    cont += 1
  end
  p arr
end

def bubble_sort_by(arr)
  ordered = 1
  cont = 1
  while ordered.positive?
    ordered = 0
    (arr.length - cont).times do |i|
      next unless yield(arr[i], arr[i + 1]).positive?

      temp = arr[i + 1]
      arr[i + 1] = arr[i]
      arr[i] = temp
      ordered += 1
    end
    cont += 1
  end
  p arr
end

bubble_sort_by %w[hi hello hey] do |left, right|
  right.length - left.length
end

bubble_sort([4, 3, 78, 2, 0, 2])
