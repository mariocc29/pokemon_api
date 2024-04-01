require 'open-uri'
require 'csv'

CSV.new(
  URI.open(Rails.application.config.pokemon[:url]), 
  :headers => :first_row).each do |line|
    Pokemon.create({
      name: line[1],
      primary_type: line[2],
      secondary_type: line[3],
      total: line[4],
      hp: line[5],
      attack: line[6],
      defense: line[7],
      sp_atk: line[8],
      sp_def: line[9],
      speed: line[10],
      generation: line[11],
      legendary: line[12]
    })
end