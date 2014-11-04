[
  "JavaScript",
  "Ruby",
  "Vim",
].each do |name|
  Tag.find_or_create_by name: name
end
