#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import sys
import os
import io
import argparse
import traceback

def choice(message):
    while True:
        try:
            i = raw_input(message + '(y/n)')
        except KeyboardInterrupt:
            return False
            exit()
        if i.lower() in ('yes','y'): return True
        elif i.lower() in ('no','n'): return False

from string import Template
def renderTemplate(src, dest, context):
    with io.open(src, 'r', encoding='utf-8') as infile:
        with io.open(dest, 'w') as outfile:
            outfile.write(Template(infile.read()).substitute(context))




#Main

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Angular generator')
    group = parser.add_mutually_exclusive_group()

    group.add_argument('-m', '--module', action='store_true', help='Generate module with view and route')
    group.add_argument('-d', '--directive', action='store_true', help='Generate directive module')
    group.add_argument('-s', '--service', action='store_true', help='Generate service module')
    parser.add_argument('-v','--verbose', help='More Verbosity')
    parser.add_argument('module_name', help='The complete module name app.iprotego.dashboard')
    parser.add_argument('directory', help='The relative path where generated files will go (default "/{module_name}"')
    parser.add_argument('prefix', help='The app prefix of application (default "")')

    args = parser.parse_args()
    args = vars(args)
    print args



    if args['module']:
        module_files = [
            'name.module.js',
            'name.controller.js',
            'name.html',
            'name.less',
            'name.route.js',
            'name.route.spec.js',
            'name.controller.spec.js',
        ]

    if args['directive']:
        module_files = [
            'name.module.js',
            'name.directive.js',
            'name.html',
            'name.less'
        ]

    if args['service']:
        module_files = [
            'name.module.js',
            'name.service.js'
        ]

    try:
        module_name = args['module_name'].split('.')[-1]
        ModuleName = ''.join(x for x in module_name.title() if not x.isspace())
        moduleName = ModuleName[0].lower + ModuleName[1:]
        parent_module = ''
        parent_path = ''
        paths = args['module_name'].split('.')
        prefix = ''
        #remove last path (module name)
        paths.pop();
        print paths

        for path in paths:
            parent_module += path + '.'
            parent_path += path + '/'

        if args['prefix']:
            prefix = args['prefix']

        if parent_module == '':
            prefix = parent_module.replace('.', '/')


        if args['directory']:
            directory = os.getcwd() + '/' + args['directory'] + module_name
        else:
            directory = os.getcwd() + '/' + module_name


        print '================='
        print 'Create angular module: ' + module_name
        print 'Parent module: ' + parent_module
        print 'Template url prefix: ' + prefix
        print 'In directory: ' + directory

        try:
            os.makedirs(directory);
        except:
            print "Directory %s already exists" % directory
            pass


        templates_path =  os.path.abspath(os.path.join(os.path.dirname(__file__), 'tpl'))
        for filename in module_files:
            #template filename
            new_filename =  filename.replace('name',module_name)

            if not 'module' in filename:
                yes = choice('Create %s ?' % new_filename)
            else:
                yes = True

            print 'Template from', templates_path +'/' + filename
            print 'To ',  directory +'/'+ new_filename
            if yes:
                try:
                    renderTemplate(templates_path +'/' + filename,directory +'/'+ new_filename, {
                        'module_name':module_name,
                        'ModuleName':ModuleName,
                        'moduleName':ModuleName,
                        'Module_nameCtrl':Module_name+'Ctrl',
                        'parent_module':parent_module,
                        'parent_path':parent_path,
                        'prefix':prefix
                    })

                except KeyboardInterrupt:
                    sys.exit();
                except:
                    t, v, tb = sys.exc_info()
                    print "".join(traceback.format_exception(t, v, tb))
                    del t, v, tb


    except:
        t, v, tb = sys.exc_info()
        print "".join(traceback.format_exception(t, v, tb))
        del t, v, tb
