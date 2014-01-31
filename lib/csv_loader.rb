class CSVLoader

  require 'csv'

  def initialize(filename)
    @filename = "#{Rails.root}/#{filename}"
  end

  def parsed_file
    @parsed_file ||= if File.exist?(@filename)
      CSV.parse(File.read(@filename), :headers => true)
    else
      []
    end
  end

  def get_row(num)
    parsed_file[num].to_hash
  end

  def row_count
    parsed_file.length
  end

  def load
    0.upto(row_count-1).each do |num|
      Appointment.create!(get_row(num))
    end
  end

  def self.load(filename)
    loader = new(filename)
    loader.load
  end
end