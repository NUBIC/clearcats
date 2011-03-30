require 'yaml'

ENUMS = [:institution_positions, :metric_items]

namespace :setup do
  
  desc 'Load the database with values from yml files in lib/setup/data'
  task(:enums => :environment) do
    ENUMS.each do |enum|
      setup_enum(enum)
    end
  end
  
  ENUMS.each do |enum|
    desc "Load the database with #{enum} values"
    task("#{enum}" => :environment) do
      setup_enum("#{enum}")
    end
  end

  def setup_enum(enum)
    enum_data = YAML.load(ERB.new(File.read("lib/setup/data/#{enum.to_s}.yml")).result)
    enum_model = enum.to_s.classify.constantize
    enum_data.each_pair do |k, v|
      enum_row = enum_model.find(:first, :conditions => { :name => v['name'] })

      if enum_row
        puts "#{v['name']} in #{enum.to_s} already exists"
      else
        puts "Creating #{v['name']} for #{enum.to_s} "
        attrs = {}
        v.each { |n| attrs[n[0].to_sym] = v[n[0]] }
        enum_model.create!(attrs)
      end
    end
  end
  
end