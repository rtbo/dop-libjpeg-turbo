name = 'libjpeg-turbo'
version = '2.0.6'
description = 'Fast JPEG codec library'
license = {'IJG', 'BSD', 'ZLIB'}
copyright = {
    'Copyright (C)2009-2021 D. R. Commander. All Rights Reserved.',
    'Copyright (C)2015 Viktor Szathmáry. All Rights Reserved.',
}
langs = {'c'}

function source()
    local repo = 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
    dop.run_cmd({'git', 'clone', '--depth', '1', '--branch', version, repo})
    return 'libjpeg-turbo'
end

function build(dirs, config)
    local cmake = dop.CMake:new(config.profile)

    cmake:configure({
        src_dir = dirs.src,
        install_dir = dirs.install,
        defs = defs,
    })
    cmake:build()
    cmake:install()
end
