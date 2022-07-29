class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_request_count
  add_flash_types :success, :info, :warning, :danger

  #ログアウト後に遷移するpathを設定
  def after_sign_out_path_for(resource)
    if resource == :admin
       new_admin_session_path
    elsif resource == :patient
       new_patient_session_path
    end
  end

  #ログイン後に遷移するpathを設定
  def after_sign_in_path_for(resource)
     if resource.class == Admin
       admin_top_path
     elsif resource.class == Patient
       public_top_path
     end
  end

  #リクエストステータスのappointmentをカウントして表示
  def get_request_count
    if current_admin
      @request_count = Appointment.where(status: "request").length
    end
  end

  # def unchecked_appointments
  #   @unchecked_appointments ||= @appointments.where(status: [:confirm, :impossible], checked: false)
  # end

  protected

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

