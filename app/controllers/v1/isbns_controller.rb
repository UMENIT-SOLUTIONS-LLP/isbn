# frozen_string_literal: true

class V1::IsbnsController < ApplicationController

  #ISBN convert (dev eg :- http://localhost:3000/v1/isbns?isbn=9780143007)
  # paremets = {isbn: 978014300723} 
  # if isbn not passing in parameters show result to default isbn #978014300723
  def index
    isbn = 978014300723
    isbn = params[:isbn].to_i if params[:isbn].present?
    assured_sum = 0
    isbn.to_s.split('').map(&:to_i).each_with_index do |val, index|
      if index.even?
        assured_sum += (val * 1).to_i
      else
        assured_sum += (val * 3).to_i
      end
    end
    assured_mode = assured_sum % 10
    final_val = 10 - assured_mode
    updated_isbn = isbn.to_s + final_val.to_s
    render json: { old_isbn13: isbn, new_isbn13: updated_isbn.to_i }
  end
end
