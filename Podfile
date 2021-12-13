platform :ios, '14.0'

target 'DotaHero' do
  use_frameworks!

  pod 'DTCommonModule', :path => '../DTCommonModule'
  pod 'DTDataModule', :path => '../DTDataModule'
  pod 'DTDomainModule', :path => '../DTDomainModule'

  pod 'IGListKit'
  
  pod 'Kingfisher'

  pod 'RxAlamofire'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxGesture'
  pod 'RxSwift'

  pod 'SnapKit'
  
  target 'DotaHeroTests' do
    inherit! :search_paths
    pod 'RxBlocking'
    pod 'RxTest'
  end
  # target 'DotaHeroUITests' do
  # end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64' 
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0po'
    end
  end
end
