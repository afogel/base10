# frozen_string_literal: true

class Nav::LinkComponent < ViewComponent::Base
  def initialize(icon: nil, title:, url:)
    @icon = icon
    @title = title
    @url = url
  end

  attr_reader :icon, :title, :url
end
