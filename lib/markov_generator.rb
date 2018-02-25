class MarkovGenerator
  attr_reader :text, :order, :max_chars, :sentence_fragment_array, :dictionary

  def initialize(text:, order: 1, max_chars: 280)
    @text = text
    @order = order
    @max_chars = max_chars
  end

  def generate
    build_array_of_sentence_fragments
    build_dictionary

    current_fragment = @sentence_fragment_array.first
    text_array = [current_fragment]

    until text_array.join(" ").length >= 280
      text = text_array.join(" ")
      potential_fragments = @dictionary[current_fragment]
      break if potential_fragments.nil? || potential_fragments.empty?

      next_fragment = potential_fragments.sample
      if (text_array.join(" ") + next_fragment).length > @max_chars
        break
      end

      text_array << next_fragment
      current_fragment = text_array[-@order..-1].join(" ")
    end

    text_array.join(" ")
  end

  def build_array_of_sentence_fragments
    @sentence_fragment_array = []
    text_array = @text.split(" ")

    while text_array.count > 0
      @sentence_fragment_array << text_array.take(@order).join(" ")
      text_array.shift
    end

    @sentence_fragment_array
  end

  def build_dictionary
    @dictionary = Hash.new { |h, k| h[k] = [] }

    @sentence_fragment_array.each_with_index do |sentence_fragment, idx|
      if @sentence_fragment_array[idx + @order]
        @dictionary[sentence_fragment] << @sentence_fragment_array[idx + @order].split.first
      end
    end

    @dictionary
  end
end
