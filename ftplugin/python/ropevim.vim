" Exit quickly when:
" - this plugin was already loaded
if !exists("g:ropevim_loaded")
python << EOF
import sys, vim
import ropevim
import ropemode.interface
sys.path.append(vim.eval("expand('<sfile>:p:h')")  + '/libs/')

class RopeOmniCompleter(object):
    """ The class used to complete python code. 
		It is taken directly as is from rope-omni 
		project <https://github.com/rygwdn/rope-omni>
		of Ryan Wooden.
	"""

    def __init__(self, base=""):
        self.assist = None
        self.start = self.get_start(base)

    def vim_string(self, inp):
        """ Creates a vim-friendly string from a group of
        dicts, lists and strings.
        """
        def conv(obj):
            if isinstance(obj, list):
                return u'[' + u",".join([conv(o) for o in obj]) + u']'
            elif isinstance(obj, dict):
                return u'{' + u','.join([
                    u"%s:%s" % (conv(key), conv(value))
                    for key, value in obj.iteritems()]) + u'}'
            else:
                return u'"%s"' % str(obj).replace(u'"', u'\\"')
        return conv(inp)

    def _get_dict(self, prop):
        ci = vim.eval(ropevim._env._extended_completion(prop))
        ci['info'] = prop.get_doc() or " "
        return ci

    def complete(self, base):
        """ Gets a completion list using a given base string. """
        if vim.eval("complete_check()") != "0":
            return []

        try:
            proposals = self.assist._calculate_proposals()
        except Exception: # a bunch of rope stuff
            return []

        ps = [self._get_dict(p) for p in proposals]
        return self.vim_string(ps)

    def get_start(self, base):
        """ Gets the starting column for vim completion. """
        try:
            inf = ropevim._interface
            self.assist = ropemode.interface._CodeAssist(inf, inf.env)

            base_len = self.assist.offset - self.assist.starting_offset
            return int(vim.eval("col('.')")) - base_len - 1

        except Exception:
            return -1


EOF

let g:ropevim_loaded = 1

function! RopeCompleteFunc(findstart, base)
    " A completefunc for python code using rope
	" Taken directly from rope-omni project of Ryan Wooden.
    if (a:findstart)
        py ropecompleter = RopeOmniCompleter(vim.eval("a:base"))
        py vim.command("return %s" % ropecompleter.start)
    else
        py vim.command("return %s" % ropecompleter.complete(vim.eval("a:base")))
    endif
endfunction

endif
