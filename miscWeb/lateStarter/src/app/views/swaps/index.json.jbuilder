json.array!(@swaps) do |swap|
  json.extract! swap, :id
  json.url swap_url(swap, format: :json)
end
