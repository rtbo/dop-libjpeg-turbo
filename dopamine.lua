local dop = require('dop')

name = 'libjpeg-turbo'
version = '2.0.6'
description = 'Fast JPEG codec library'
license = {'IJG', 'BSD', 'ZLIB'}
copyright = {
    'Copyright (C)2009-2021 D. R. Commander. All Rights Reserved.',
    'Copyright (C)2015 Viktor Szathmáry. All Rights Reserved.',
}
langs = {'c'}

revision = dop.Git.revision()

function source()
    local repo = 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
    dop.run_cmd({'git', 'clone', '--depth', '1', '--branch', version, repo})
    return 'libjpeg-turbo'
end

function build(dirs, profile)
    local cmake = dop.CMake:new(profile)

    local build = dop.path('build', profile.digest_hash)
    local install = dop.path('install', profile.digest_hash)
    dop.mkdir {build, recurse = true}

    dop.from_dir(build, function()
        cmake:configure{
            src_dir = dop.path('..', '..', 'libjpeg-turbo'),
            install_dir = dop.path('..', '..', install)
        }
        cmake:build()
        cmake:install()
    end)

    return install
end
