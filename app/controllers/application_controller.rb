class ApplicationController < ActionController::Base
  #before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_request_count
  add_flash_types :success, :info, :warning, :danger

  def after_sign_out_path_for(resource)
    if resource == :admin
       root_path # ログアウト後に遷移するpathを設定
    elsif resource == :patient
       new_patient_session_path
    end
  end

  def after_sign_in_path_for(resource)
     if resource.class == Admin
       admin_top_path # ログイン後に遷移するpathを設定
     elsif resource.class == Patient
       public_top_path
       #public_patient_path(id: current_patient.id)
     end
  end

  protected

  def get_request_count
    if current_admin
      @request_count = Appointment.where(status: "request").length
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birthday,
      :gender,
      :email,
      :postal_code,
      :address,
      :telephone_number,
      :patient_text,
      :encrypted_password,
      ])
  end
end

