import os

ntpq_vars = None

def _read_ntpq_vars(self):
    ntpq_bin = self.config.get('ntpq', '/usr/sbin/ntpq')
    code, out = os.popen("%s -c readvar localhost" % ntpq_bin,
                                        self.logger)
    if code:
        self.logger.warn('error communicating with ntpq: return code %i' %code)
        self.ntpq_vars = []
    else:
        self.ntpq_vars = out.splitlines()

def get_jitter(self):
        """ Find value jitter= from ntpq output
        Returns: float"""
        j = 999 # jitter value

    if not self.ntpq_vars:
        self._read_ntpq_vars()
    for line in self.ntpq_vars:
        if line.startswith('offset='):
            j = line.split()[2] # j = jitter=21.479
            j = j.split('=')[1]
            j = j[:-1]
            j = float(j)
    if j == 999:
        # another format
        for line in self.ntpq_vars:
            if line.startswith('clk_jitter='): # line ="clk_jitter=3.829, clk_wander=0.719"
                j = line.split()[0] # j = "line ="clk_jitter=3.829,"
                j = j.split('=')[1] # j = "3.829,"
                j = j[:-1] # j = 3.829
                j = float(j)
    return j