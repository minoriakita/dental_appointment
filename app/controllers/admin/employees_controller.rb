class Admin::EmployeesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @employee = Employee.new
    @employees = Employee.page(params[:page])
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
       redirect_to admin_employees_path
    else
       @employees = Employee.page(params[:page])
       render :index
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
       redirect_to admin_employees_path
    else
       render :edit
    end
  end

 def destroy
     employee = Employee.find(params[:id])
     employee.update(is_deleted: true)
     redirect_to admin_employees_path
 end

  private

  def employee_params
    params.require(:employee).permit(:name)
  end
end
