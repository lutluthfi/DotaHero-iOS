Pod::Spec.new do |s|
s.name             = 'DTDataModule'
s.version          = '1.0.0'
s.summary          = 'Dota Hero Data Module'
s.description      = 'Dota Hero Data Module'
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
s.module_name      = 'DTDataModule'

s.ios.deployment_target = '12.0'
s.source_files          = [
    'DTDataModule/Class/**/*.swift'
]

s.frameworks = ['Foundation']

s.dependency 'DTCommonModule'
s.dependency 'DTDomainModule'

end

