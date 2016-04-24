require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'requires a title to be present' do
      p = Post.new
      p.valid?
      expect(p.valid?).to eq(false)
    end
    it 'requires title to be longer than 7 characters' do
      p = Post.new(title: 'TITLE')
      p.valid?
      expect(p.errors).to have_key(:title)
    end
    it 'requires a body to be present' do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:body)
    end
  end

  describe '.body_snippet' do
    it 'returns 100 characters with ... if its more than 100 characters' do
      c = Post.new(body: 'lorem ipsum fdsalfkjdsafhdsalkfdsjafldsahfjdsaghlsajfdsalkfsdhajfsadkhfjajdhkafdsahfkjdsafjdshakfljdsafha')
      expect(c.body_snippet).to eq('lorem ipsum fdsalfkjdsafhdsalkfdsjafldsahfjdsaghlsajfdsalkfsdhajfsadkhfjajdhkafdsahfkjdsafjdshakfljd...')
    end

    it 'returns the body if its 100 characters or less' do
      c = Post.new(body: 'hello world')
      expect(c.body_snippet).to eq('hello world')
    end
  end
end
