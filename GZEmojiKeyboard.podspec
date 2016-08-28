
Pod::Spec.new do |s|
  s.name             = 'GZEmojiKeyboard'
  s.version          = '0.1.0'
  s.summary          = 'Emoji Keyboard for iOS'
  s.description      = <<-DESC
    Emoji Keyboard for iOS (support sticker as well)
                       DESC

  s.homepage         = 'https://github.com/SamuelZhaoY/iOS-EmojiKeyBoard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zy.zhao' => 'zhaoy.samuel@gmail.com' }
  s.source           = { :git => 'https://github.com/SamuelZhaoY/iOS-EmojiKeyBoard.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'GZEmojiKeyboard/Classes/*'
  s.public_header_files = 'GZEmojiKeyboard/Classes/GZEmojiKeyboard.h'

end
