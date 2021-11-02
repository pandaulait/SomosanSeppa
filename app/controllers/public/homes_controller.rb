# frozen_string_literal: true

module Public
  class HomesController < ApplicationController
    def top; end

    def guest_sign_in
      user = User.guest
      
      sign_in user
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    end
  end