class Appointment < ActiveRecord::Base

  TIME_FORMAT = /\A\d{2}[\/-]\d{2}[\/-]\d{2}\s+\d{2}:\d{2}\z/

  validates_presence_of :start_time, :end_time, :first_name, :last_name
  validates_format_of :start_time, :end_time, with: TIME_FORMAT

  validate :start_before_end

  before_validation :normalize_time

  def self.time_parser(time)
    v = time.to_s.scan(/\d+/)
    return nil if v.length != 5
    shifted = [v[2], v[0], v[1], v[3], v[4]]
    Time.parse("%s/%s/%s %s:%s" %shifted)
  end

  def self.normalize_time(time)
    values = time.to_s.scan(/\d+/)
    return time if values.length != 5
    "%s/%s/%s %s:%s" %values.map {|v| v.rjust(2,'0')}
  end

  private

  def start_before_end
    return if start_datetime.blank? || end_datetime.blank?
    return if start_datetime < end_datetime
    errors.add(:start_time, "can't be before end time")
  end

  def start_datetime
    self.class.time_parser(start_time)
  rescue ArgumentError => e
    nil
  end

  def end_datetime
    self.class.time_parser(end_time)
  rescue ArgumentError => e
    nil
  end

  def normalize_time
    self.start_time = self.class.normalize_time(start_time)
    self.end_time = self.class.normalize_time(end_time)
  end

end