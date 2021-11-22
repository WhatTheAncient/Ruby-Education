#Так как функция validate! имеет общее название для всех классов,
# а функция valid? имеет одно и тоже тело было принято решение вынести её в отдельный модуль.
module ValidationCheck
  def valid?
    validate!
    true
  rescue
    false
  end
end