#!/usr/bin/python
#
# wmctrl.py
#
# Python3 wrapper  https://linux.die.net/man/1/wmctrl
# MIT License

import attr
import subprocess
import os
import time

DEBUG = False


def getoutput(s):
    if DEBUG:
        print(s)
    return subprocess.getoutput(s)


def system(s):
    if DEBUG:
        print(s)
    return os.system(s)


def strip_prefix(prefix, word):
    if word.startswith(prefix):
        return word[len(prefix):]
    return word


def uniq(it):
    return list(set(it))


@attr.s
class Window(object):
    id = attr.ib()
    desktop = attr.ib()
    pid = attr.ib()
    x = attr.ib()
    y = attr.ib()
    w = attr.ib()
    h = attr.ib()
    wm_class = attr.ib()
    host = attr.ib()
    wm_name = attr.ib()
    _wm_window_role = attr.ib(default=None)
    _wm_state = attr.ib(default=None)

    def __repr__(self):
        return str(*self)

    @property
    def wm_window_role(self):
        if self._wm_window_role is not None:
            return self._wm_window_role
        #
        out = getoutput('xprop -id %s WM_WINDOW_ROLE' % self.id)
        try:
            _, value = out.split(' = ')
        except ValueError:
            # probably xprop returned an error
            self._wm_window_role = ''
        else:
            self._wm_window_role = value.strip('"')
        return self._wm_window_role

    @property
    def wm_state(self):
        if self._wm_state is not None:
            return self._wm_state

        out = getoutput('xprop -id %s _NET_WM_STATE' % self.id)
        try:
            _, value = out.split(' = ')
        except ValueError:
            # probably xprop returned an error
            self._wm_state = []
        else:
            self._wm_state = [strip_prefix("_NET_WM_STATE_", s).lower()
                              for s in value.split(', ')]
        return self._wm_state

    @classmethod
    def list(cls):
        out = getoutput('wmctrl -l -G -p -x')
        windows = []
        for line in out.splitlines():
            parts = line.split(None, 9)
            parts = [part.strip() for part in parts]
            # title is missing
            if len(parts) == 9:
                parts.append('')
            elif len(parts) != 10:
                # something was wrong
                continue
            windows.append(cls(*parts))
            if DEBUG:
                print(windows[-1])
                print()
        return windows

    @classmethod
    def list_classes(cls):
        return uniq([w.wm_class for w in cls.list()])

    @classmethod
    def list_names(cls):
        return uniq([w.name_class for w in cls.list()])

    @classmethod
    def list_roles(cls):
        return uniq([w.wm_window_role for w in cls.list()])

    @classmethod
    def by_name(cls, name):
        return [win for win in cls.list() if win.wm_name == name]

    @classmethod
    def by_name_contains(cls, name):
        return [win for win in cls.list() if name.lower() in
                win.wm_name.lower()]

    @classmethod
    def by_config(cls, config):
        try:
            matching_windows = cls.by_name_contains(
                config.get('name')
            )
            if len(matching_windows) > int(config.get('instance', 0)):
                return matching_windows[int(config.get('instance', 0))]
        except Exception as e:
            print(e, e.stack)
            return None

    @classmethod
    def by_name_endswith(cls, name):
        return [win for win in cls.list() if win.wm_name.endswith(name)]

    @classmethod
    def by_name_startswith(cls, name):
        return [win for win in cls.list() if win.wm_name.startswith(name)]

    @classmethod
    def by_role(cls, role):
        return [win for win in cls.list() if win.wm_window_role == role]

    @classmethod
    def by_class(cls, wm_class):
        return [win for win in cls.list() if win.wm_class == wm_class]

    @classmethod
    def by_id(cls, id):
        return [win for win in cls.list() if int(win.id, 16) == id]

    @classmethod
    def get_active(cls):
        out = getoutput("xprop -root _NET_ACTIVE_WINDOW")
        parts = out.split()
        try:
            id = int(parts[-1], 16)
        except ValueError:
            return None
        lst = cls.by_id(id)
        if not lst:
            return None
        assert len(lst) == 1
        return lst[0]

    def activate(self):
        system('wmctrl -id -a %s' % self.id)

    def resize_and_move(self, x=None, y=None, w=None, h=None):
        # XXX: the "move" part doesn't really work, it is affected by this:
        # https://askubuntu.com/questions/576604/what-causes-the-deviation-in-the-wmctrl-window-move-command
        if x is None:
            x = self.x
        if y is None:
            y = self.y
        if w is None:
            w = self.w
        if h is None:
            h = self.h
        mvarg = '0,%s,%s,%s,%s' % (x, y, w, h)
        system('wmctrl -i -r %s -e %s' % (self.id, mvarg))

    def resize(self, w=None, h=None):
        self.resize_and_move(w=w, h=h)

    def move(self, x=None, y=None):
        self.resize_and_move(x=x, y=y)

    def set_geometry(self, geometry):
        dim, pos = geometry.split('+', 1)
        w, h = map(int, dim.split('x'))
        x, y = map(int, pos.split('+'))
        self.resize_and_move(x, y, w, h)

    def set_properties(self, properties):
        proparg = ",".join(properties)
        system('wmctrl -i -r %s -b %s' % (self.id, proparg))

    def set_decorations(self, v):
        import gtk.gdk
        w = gtk.gdk.window_foreign_new(int(self.id, 16))
        w.set_decorations(v)
        gtk.gdk.window_process_all_updates()
        gtk.gdk.flush()

    def maximize(self, verb='add'):
        "verb can be 'add', 'remove' or 'toggle'"
        self.set_properties([verb, 'maximized_vert', 'maximized_horz'])

    def unmaximize(self):
        self.maximize('remove')

    def close(self):
        print('Closing', self.id)
        system('wmctrl -i -c %s' % (self.id,))

    @classmethod
    def launch(cls, name, config):
        w = Window.by_config(config)
        if w:
            # exist
            print('Already launched ', name, w)
            return w

        print('Launching ', name)
        if config.get('dir'):
            # its a term app
            command = (
                    'mate-terminal --window '
                    '--title %s '
                    '--working-directory %s '
                    '-e "bash -c \'%s\';bash"'
                ) % (
                    config.get('title', name),
                    config.get('dir'),
                    config.get('command'),
                )
            getoutput(command)
        else:
            command_array = config.get('command').split()
            subprocess.Popen(
                command_array,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL
            )

        # wait opened
        while Window.by_config(config) is None:
            print('.')
            time.sleep(0.5)

        # care about uniq name
        return Window.by_config(config)

    def switchDesktop(self, num):
        print(self.id)
        system('wmctrl -i -r %s -t %s' % (self.id, num,))


@attr.s
class Desktop(object):
    num = attr.ib()
    active = attr.ib()
    name = attr.ib()

    def __repr__(self):
        return str(*self)

    @classmethod
    def list(cls):
        out = getoutput('wmctrl -d')
        desktops = []
        for line in out.splitlines():
            parts = line.split(None, 9)
            parts = [part.strip() for part in parts]
            num = int(parts[0])
            active = parts[1] == '*'
            name = parts[-1]
            desktops.append(cls(num, active, name))
            if DEBUG:
                print(desktops[-1])
                print()
        return desktops

    @classmethod
    def get_active(cls):
        dlist = cls.list()
        for d in dlist:
            if d.active:
                return d
        # this should never happen, but who knows?
        return None


if __name__ == '__main__':
    Desktop.list()
    Window.list()
    import json
    import sys

    screen = {
        "h": 1080,
        "w": 1920
    }

    with open(sys.argv[1]) as config_file:
        apps_config = json.loads(config_file.read())
        for app_name, config in apps_config.items():
            config['name'] = config.get('name', app_name)
            try:

                if len(sys.argv) > 2:
                    w = Window.by_config(config)
                    if w is not None:
                        w.close()
                else:
                    w = Window.launch(app_name, config)

                    w.switchDesktop(config.get('desktop', 0))

                    if config.get('tail') == 'half':
                        config['size'] = {
                            "w": screen.get('w') / 2,
                            "h": screen.get('h')
                        }

                    if "/" in config.get('tail', ''):
                        ratio = 1.0
                        ratios = config.get('tail').split('/')
                        if len(ratios) > 1:
                            ratio = int(ratios[0]) / int(ratios[1])
                        config['size'] = {
                            "w": screen.get('w') * ratio,
                            "h": screen.get('h')
                        }

                    if config.get('position') == 'left':
                        x = 0

                    elif config.get('position') == 'left2':
                        x = screen.get('w') - config.get(
                            'size', screen).get('w') + 1

                    elif config.get('position') == 'right':
                        x = screen.get('w') + 1

                    elif config.get('position') == 'right2':
                        x = int(screen.get('w')) * 2 - config.get(
                            'size', screen).get('w') + 1

                    print("Move", x,
                          'size', config.get('size', screen).get('w'))

                    w.resize_and_move(
                        x=int(x),
                        y=0,
                        h=int(config.get('size', screen).get('h')),
                        w=int(config.get('size', screen).get('w'))
                    )
                    time.sleep(0.5)
            except Exception as e:
                raise e
