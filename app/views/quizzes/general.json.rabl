object @quiz
attributes :id
child(:questions, :object_root => false) do
  attributes :id, :title
  child(:avatar, root: "img", :object_root => false) do
    attributes :url
  end
  child(:answers, :object_root => false) do
    attributes :id, :body, :right
  end
end
