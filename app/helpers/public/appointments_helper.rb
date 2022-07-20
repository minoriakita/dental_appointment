module Public::AppointmentsHelper
  def table_rows(day)
    times = [
      ["10:00:00", "10:29:59"],
      ["10:30:00", "10:59:59"],
      ["11:00:00", "11:29:59"],
      ["11:30:00", "11:59:59"],
      ["12:00:00", "12:29:59"],
      ["12:30:00", "12:59:59"],
    ]

    tag.div do
      times.each do |time|
        if Appointment.appointments_possible?(day, time.first, time.second)
          concat (tag.tr class: "bg-white" do
            concat tag.th time.first[0, 5], class: "col-md-1 text-center bg-white"
            concat (tag.td class: "text-center", style: "vertical-align: middle;" do
              concat(tag.span "予約不可")
            end)
          end)
        else
          #concat (tag.a href: new_public_appointment_path(date: "#{day} #{time.first}") do
            concat (tag.tr do
              concat (tag.th class: "col-md-1 text-center bg-white" do
                concat tag.a time.first[0, 5], href: new_public_appointment_path(date: "#{day} #{time.first}"), class: "d-block h-100 w-100"
              end)
              concat (tag.td class: "text-center", style: "vertical-align: middle;" do
                concat tag.a "予約依頼へ", href: new_public_appointment_path(date: "#{day} #{time.first}"), class: "d-block h-100 w-100"
              end)
            end)
          #end)
        end
      end
    end
#Appointment.appointments_possible?(day, '10:00:00', '10:29:59') ? "予約不可" : link_to("予約依頼へ", new_public_appointment_path(date: "#{day} 10:00:00"))
    #<tr>
    #  <th class="col-md-1 text-center">10:00</th>
    #  <td class="table table-hover text-center" style="vertical-align: middle;">
    #    <% if Appointment.appointments_possible?(params[:day], '10:00:00', '10:29:59') %>
    #      予約不可
    #    <% else %>
    #      <%= link_to "予約依頼へ", new_public_appointment_path(date: "#{@day.to_s} 10:00:00") %>
    #    <% end %>
    #  </td>
    #</tr>
  end
end