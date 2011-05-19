module ServicesHelper
  
  def user_can_edit_service?(service, organizational_units)
    return false if service.blank? or organizational_units.blank?
    !service.service_line.blank? && organizational_units.include?(service.service_line.organizational_unit)
  end
  
end
