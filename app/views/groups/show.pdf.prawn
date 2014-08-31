prawn_document do |pdf|
  pdf.font_families.update("Verdana" => {:normal  => "#{Rails.root}/app/assets/fonts/verdana.ttf" })
  pdf.font "Verdana", :size => 10
  rows = []

  total = @days.map(&:lessons).flatten.map(&:number).max || 0
  rows << (0...@days.count).map(&method(:day_name))
  (0..total).each do |row|
    d_row = []
    (0...@days.count).each do |col|
      lessons = @days[col].lessons.select {|a| a.number == row}.each
      d_row << lessons.map(&:teacher_and_name).join(' / ')
    end
    rows << d_row
  end
  table = pdf.make_table rows
  table.draw
end
