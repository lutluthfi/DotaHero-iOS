Pod::Spec.new do |s|
s.name             = 'DTDomainModule'
s.version          = '1.0.0'
s.summary          = 'Dota Hero Domain Module'
s.description      = 'Dota Hero Domain Module'
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
s.module_name      = 'DTDomainModule'

s.ios.deployment_target = '14.0'
s.source_files          = [
    'DTDomainModule/Class/**/*.swift'
]

s.frameworks = ['Foundation']

s.dependency 'DTCommonModule'

s.dependency 'RealmSwift', '10.8.0'

s.dependency 'RxAlamofire'
s.dependency 'RxDataSources'
s.dependency 'RxSwift'

s.dependency 'Swinject'

end

