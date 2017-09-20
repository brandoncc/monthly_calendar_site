require 'sinatra'
require 'sinatra/reloader' if development?
require 'monthly_calendar'

get '/' do
  erb :index
end

post '/create' do
  file = Tempfile.new(['calendar', '.pdf'])

  calendar = MonthlyCalendar.new(
    start_date: "#{params["month"]} #{params["year"]}",
    pages: params["pages"].to_i
  )

  calendar.save(file.path)

  send_file file.path,
            disposition: :attachment,
            type: :pdf,
            filename: "calendar.pdf"
end
