class TextValue < FieldValue

  def value=(v)
    super({text: v})
  end

  def value
    super["text"]
  end

end