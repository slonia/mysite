module TranslationsHelper
  def translate_attr(model, attr)
    model.human_attribute_name(attr)
  end
end
