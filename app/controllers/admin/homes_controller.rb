class Admin::HomesController < ApplicationController
 before_action :authenticate_admin!

 def top
   # flash.now[:alert] = "ログインしました"
   render :top, layout: "application_top"
 end

 def item
 end
end
