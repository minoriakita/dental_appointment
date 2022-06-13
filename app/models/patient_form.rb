class PatientForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment

  attr_accessor :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, :gender, :postal_code, :address, :telephone_number, :email, :patient_text, :infection_id

  def save
    patient = Patient.new(
      first_name: first_name,
      last_name: last_name,
      first_name_kana: first_name_kana,
      last_name_kana: last_name_kana,
      birthday: birthday,
      gender: gender,
      postal_code: postal_code,
      address: address,
      telephone_number: telephone_number,
      email: email,
      patient_text: patient_text,
    )
    patient.save
    PatientInfection.create(infection_id: infection_id, patient_id: patient.id) if infection_id.present?
    patient.id
  end
end