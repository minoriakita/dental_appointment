# 勉強用

# class AppointmentForm
#   include ActiveModel::Model
#   include ActiveRecord::AttributeAssignment

#   attr_accessor :patient_id, :appointment_date, :visit_date, :remark, :status, :symptom_text, :treatment_id, :symptom_id

#   validates :appointment_date, presence: true
#   validates :treatment_id, presence: true, allow_blank: true
#   validates :symptom_id, presence: true, allow_blank: true
  
#   def self.initialize_by_appointment(appointment)
#     @patient_id = appointment.patient_id
#     @appointment_date = appointment.appointment_date
#     @visit_date = appointment.visit_date
#     @remark = appointment.remark
#     @status = appointment.status
#     @symptom_text = appointment.symptom_text
#   end

#   def save
#     appointment = Appointment.new(
#       patient_id: patient_id,
#       appointment_date: appointment_date,
#       visit_date: visit_date,
#       remark: remark,
#       status: status,
#       symptom_text: symptom_text
#     )
#     appointment.save
#     AppointmentTreatment.create(treatment_id: treatment_id, appointment_id: appointment.id) if treatment_id.present?
#     AppointmentSymptom.create(symptom_id: symptom_id, appointment_id: appointment.id) if symptom_id.present?
#     appointment.id
#   end
# end