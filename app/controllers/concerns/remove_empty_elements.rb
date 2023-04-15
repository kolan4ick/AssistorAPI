# frozen_string_literal: true

module RemoveEmptyElements
  extend ActiveSupport::Concern

  def remove_empty(array)
    if array.is_a?(Array)
      array.reject! { | element | element.eql?("") }
      array.presence
    else
      array
    end
  end
end
