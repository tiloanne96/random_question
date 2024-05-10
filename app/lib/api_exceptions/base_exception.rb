module ApiExceptions
  class BaseException < StandardError
    include ActiveModel::Model
    include ActiveModel::Serialization

    attr_reader :code, :message, :errors, :type, :error_type

    def error_code_map
      {
        RECORD_NOT_FOUND: { code: 1, message: I18n.t("base_exceptions.record_not_found") },
        UNAUTHORIZED: { code: 2, message: I18n.t("base_exceptions.unauthorized_user") },
      }
    end

    def initialize(error_type, errors, params)
      error = error_code_map[error_type]
      @error_type = error_type
      @errors = [*errors]
      @code = error[:code] if error
      @message = parse_message(error[:message], params) if error
      @errors.push(@message)
      @errors = @errors.flatten
      @type = "API Platform"
    end

    def parse_message(message, params)
      @parsed_message = message.dup
      if params.present?
        params.each do |key, value|
          param = @parsed_message["{{#{parse_key(key)}}}"] || @parsed_message["%{#{parse_key(key)}}"]
          @parsed_message[param.to_s] = (value.to_s || "nil") if param
        end
      end
      @parsed_message
    end

    def parse_key(key)
      if key.class == Integer
        ""
      else
        key.try(:to_s)
      end
    end

    def get_code(error_type, code_base = 100)
      code_base || error_type
    end
  end
end
