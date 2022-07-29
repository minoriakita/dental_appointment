class Admin::HomesController < ApplicationController
 before_action :authenticate_admin!

 #トップページは特定のヘッダーを表示
 def top
   flash.now[:alert]
   render :top, layout: "application_top"
 end

 def item
 end
end
