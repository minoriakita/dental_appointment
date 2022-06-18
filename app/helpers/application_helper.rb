module ApplicationHelper
  def appointment_status(appointment)
    if appointment.status == "cancel"
      tag.span appointment.status_i18n, class: 'text-danger'
    else
      appointment.status_i18n
    end
  end
end
