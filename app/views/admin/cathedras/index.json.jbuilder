json.array!(@admin_cathedras) do |admin_cathedra|
  json.extract! admin_cathedra, :id
  json.url admin_cathedra_url(admin_cathedra, format: :json)
end
