class SelectValue < FieldValue

  def value=(v)
    super({select: v})
  end

  def value
    super["select"]
  end
  
end