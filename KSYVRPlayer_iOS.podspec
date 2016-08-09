Pod::Spec.new do |spec|
  spec.name         = 'KSYVRPlayer_iOS'
  spec.version      = '1.0.0'
  spec.license      = {
:type => 'Proprietary',
:text => <<-LICENSE
      Copyright 2015 kingsoft Ltd. All rights reserved.
      LICENSE
  }
  spec.homepage     = 'http://v.ksyun.com/doc.html'
  spec.authors      = { 'FanpingZeng' => 'zengfanping@kingsoft.com' }
  spec.summary      = 'KSYVRPlayer_iOS sdk manages the playback of a panorama video.'
  spec.description  = <<-DESC
    KSYMediaPlayer_iOS sdk supoort iOS 7.0 and later, 
  DESC
  spec.platform     = :ios, '7.0'
  spec.requires_arc = true
  spec.frameworks   = 'VideoToolbox'
  spec.ios.library = 'z', 'iconv', 'stdc++.6'
  spec.source = { :git => 'https://github.com/ksvc/KVrPlayer_iOS.git'}
  spec.preserve_paths      = 'framework/KSYVRPlayer.framework'
  spec.public_header_files = 'framework/KSYVRPlayer.framework/Headers'
  spec.vendored_frameworks = 'framework/KSYVRPlayer.framework'
end
