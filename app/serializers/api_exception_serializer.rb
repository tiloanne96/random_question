class ApiExceptionSerializer < ActiveModel::Serializer
  attributes :code, :message, :errors, :type
end
