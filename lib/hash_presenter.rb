class HashPresenter
  class << self
    def to_html(data)
      ''.tap do |s|
        s << '<dl>'
        case data
        when Hash
          data.each do |key, value|
            name = key.to_s.gsub('m:', '')
            s << '<dt>' + HashPresenter.to_html(name) + '</dt>'
            nested_field_class = value.is_a?(Hash) || value.is_a?(Array)
            s << '<dd'
            s << ' class="nested-fields"' if nested_field_class
            s << '>' + HashPresenter.to_html(value) + '</dd>'
          end
        when Array
          s << data.map{ |item| HashPresenter.to_html(item) }.join("\n")
        else
          return CGI::escapeHTML(data.to_s)
        end
        s << '</dl>'
      end.html_safe
    end

    def is_url?(url)
      return url.is_a?(String) && url =~ URI::regexp
    end
  end

end
