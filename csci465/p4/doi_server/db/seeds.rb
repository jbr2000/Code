5.times do |i|
  Doi.create(name: "doi#{i}", description: "desc-ph-#{i}")
end

5.times do |i|
  Url.create(url: "url-ph-#{i}", doi_id: 1)
  Url.create(url: "url-ph-#{i}", doi_id: 2)
end
