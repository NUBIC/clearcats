module ServicesHelper
  include Summable
  
  def user_can_edit_service?(service, organizational_units)
    return false if service.blank? or organizational_units.blank?
    !service.service_line.blank? && organizational_units.include?(service.service_line.organizational_unit)
  end
  
  def total_cost(services)
    Summable.total_cost(services)
  end
  
  def total_effort(services)
    effort  = Summable.total_effort(services)
    hours   = Summable.hours(effort)
    minutes = Summable.minutes(effort)
    "#{pluralize(hours, 'Hour')} #{pluralize(minutes, 'Minute')}"
  end
  
end
