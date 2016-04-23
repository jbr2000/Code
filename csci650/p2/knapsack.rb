require 'matrix'

def get_input
  input = gets.split
  return {"num_items" => input.first.to_i,
          "capacity" => input.last.to_i,
          "values" => gets.split.map(&:to_i),
          "weights" => gets.split.map(&:to_i)}
end

def main
  params = get_input
  v = Matrix.build(params["num_items"]+1, params["capacity"]) {|row, col| 0}
  b = Matrix.build(params["num_items"]+1, params["capacity"]) {|row, col| 0}
  puts "V:"
  puts v.to_a.map(&:inspect)
  puts "B:"
  puts b.to_a.map(&:inspect)

  (1..params["num_items"]).each do |cur_item_index|
    p "Testing item: #{cur_item_index}"
    item = {"value" => params["values"][cur_item_index-1], "weight" => params["weights"][cur_item_index-1]}
    p item
    (1..params["capacity"]).each do |current_capacity|
      remaining_capacity = current_capacity - item["weight"]
      if remaining_capacity >= 0 # we can take item
        take_value = item["value"]+v[cur_item_index-1, remaining_capacity]
        leave_value = v[cur_item_index-1, current_capacity]
        if  take_value >= leave_value
          v[cur_item_index, current_capacity] = take_value
          puts "taking item!"
          p v
          #b[cur_item_index, current_capacity] = remaining_capacity
        else
        end
      end
    end
  end

=begin
  num_items.times do |item|
    p "item #{item}"
    capacity.times do |cap_index|
      cap = cap_index+1
      remaining_weight = cap - weight[item]
      p "rem: #{remaining_weight}"
      if item == 0 # first item
        if remaining_weight >= 0 
          v[item][cap_index] = value[item]
          b[item][cap_index] = remaining_weight
          p v
        else
          b[item][cap_index] = cap
        end
      else # not first item
        value_if_taken = weight[item]+v[item-1][remaining_weight] 
        value_if_not_taken = v[item-1][cap_index]
        if remaining_weight >= 0 and value_if_taken >= value_if_not_taken
            v[item][cap_index] = value_if_taken
            b[item][cap_index] = remaining_weight
        else
          v[item][cap_index] = value_if_not_taken
          b[item][cap_index] = cap
        end
      end
    end
  end
=end
end

main
