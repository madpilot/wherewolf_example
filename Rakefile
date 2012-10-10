#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

WherewolfExample::Application.load_tasks

if Rails.env == "development"
  require 'nokogiri' 
  require 'open-uri'

  namespace :example_app do
    desc 'Fetch data from Wikipedia'
    task 'fetch_seed_data' do
      puts "Fetching Australian Rugby Union Player names"
      doc = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/List_of_Australia_national_rugby_union_players')) 
      
      output = ''
      doc.css('table.wikitable tr').each do |row|
        object = {
          :number => row.element_children[0].css('> span').text.gsub(/^0/, '').to_i,
          :name => row.element_children[1].css('> a').text,
          :position => row.element_children[2].text.gsub(/\(|\)/, ''),
          :first_cap => row.element_children[3].text,
          :opposition => row.element_children[4].text
        }
        output += "Player.create!(:number => #{object[:number]}, :name => \"#{object[:name].gsub(/"/, '\"')}\", :position => \"#{object[:position]}\", :first_cap => \"#{object[:first_cap]}\", :opposition => \"#{object[:opposition]}\")\n"
        File.open("db/seeds.rb", 'w') {|f| f.write(output) }
      end
    end
  end
end
