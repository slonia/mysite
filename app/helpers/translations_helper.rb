module TranslationsHelper
  def translate_attr(model, attr)
    model.human_attribute_name(attr)
  end

  def day_name(number)
    return '' if number.blank?
    t('days.' + Day::DAY_NAMES[number].to_s)
  end
end
