Pod::Spec.new do |s|
s.name             = 'DTCommonModule'
s.version          = '1.0.0'
s.summary          = 'Dota Hero Common Module'
s.description      = 'Dota Hero Common Module'
s.homepage         = 'https://github.com/lutluthfi'
s.license          = {
    :type => 'MIT'
}
s.author           = {
    'arif' => 'lutluthfiansyah@gmail.com'
}
s.source           = {
    :git => 'https://github.com/lutluthfi/DotaHero-iOS.git', :tag => s.version.to_s
}
s.requires_arc     = true
s.module_name      = 'DTCommonModule'

s.ios.deployment_target = '12.0'
s.source_files          = [
    'DTCommonModule/Class/**/*.swift'
]

s.frameworks = ['Foundation', 'UIKit']

s.dependency "RxCocoa"
s.dependency "RxSwift"
s.dependency "Swinject"
s.dependency "SwinjectStoryboard"

end

