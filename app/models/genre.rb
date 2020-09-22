class Genre < ActiveHash::Base
  self.data = [
    { id: 1,  name: '--選択してください--' },
    { id: 2,  name: '部屋の掃除' },
    { id: 3,  name: '水回りの掃除' },
    { id: 4,  name: '洗濯' },
    { id: 5,  name: '料理' },
    { id: 6,  name: '買い物' },
    { id: 7,  name: '子守り' },
    { id: 8,  name: 'その他' }
  ]
  end