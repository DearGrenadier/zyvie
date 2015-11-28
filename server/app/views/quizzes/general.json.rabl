object: :@quiz
attributes :id
child(:questions) do
  attributes :id, :title
  child(:answers) do
    attributes :id, :body, :right
  end
  end
end
