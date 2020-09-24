class Type < ActiveHash::Base
  self.data = [
    { id: 1,  name: '--選択してください--' },
    { id: 2,  name: '手伝って欲しいです！' },
    { id: 3,  name: '手伝います！' }
  ]
  end