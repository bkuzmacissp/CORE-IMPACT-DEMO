# this code is based on http://silo.servers.core-sdi.com/projects/qa/browser/trunk/IMPACT/tools/CoreTestingFramework/worker_customs/commands/InstallImpact.py

import os
import time
import urllib
import subprocess


IMPACT_BINARY_URL="http://builder64.eng.core.sec/dists/classic/1/39221/CORE_IMPACT-in_the_oven.exe"
THIRD_PARTY_BINARY_URL="http://builder64.eng.core.sec/dists/classic/1/39221/CORE_IMPACT_3rdparty.exe"
PASSPHRASE="FLOMZ4-GWPX3R-2QAP93-9ETISW-Y6UXQ1"

GENERIC_INSTALLER_BINARY="./UnattendedInstall.exe"
IMPACT_XML="./impact.xml"
IMPACT_LAUNCHER_XML="./impact-launcher.xml"
IMPACT_THIRD_PARTY_XML="./impact-3rd-party.xml"

INSTALL_THIRD_PARTY_COMPONENTS=True


class InstallImpact():

    def __init__(self):
        self.install_timeout = 10 * 60 
        self.launch_timeout = 1 * 60 
        self.third_party_timeout = 10 * 60 
        self.filename = IMPACT_BINARY_URL.replace("\\", "/").split("/")[-1]
        self.third_filename = THIRD_PARTY_BINARY_URL.replace("\\", "/").split("/")[-1]


    def run(self):
        print "run()"

        if self.download_installers():
            if self.install_third_party_components():
                if self.install_impact():
                    self.launch_impact()

        print "DONE!"


    def download_installers(self):
        print "downloading IMPACT"                    
        
        urllib.urlretrieve(IMPACT_BINARY_URL, self.filename)
        urllib.urlretrieve(THIRD_PARTY_BINARY_URL, self.third_filename)

        try:
            x = os.stat(self.filename)
            y = os.stat(self.third_filename)
            ret = True
        except WindowsError, e:
            print "ERROR: failed to create local file %s" % str(e)
            ret = False

        return ret


    def install_third_party_components(self):
        if not INSTALL_THIRD_PARTY_COMPONENTS:
            print "Skipping 3rd party components installation"
            return True

        print "installing 3rd party components"
        ret = False
        proc = self.run_generic_installer(third_filename, IMPACT_THIRD_PARTY_XML)
        if self._wait_for_process(proc, self.third_party_timeout):
            ret = True

        return ret


    def install_impact(self):
        print "installing impact"

        _vars = {'PASSPHRASE': PASSPHRASE}
        proc = self.run_generic_installer(self.filename, IMPACT_XML, _vars)
        ret = self._wait_for_process(proc, self.install_timeout)
        return ret

    def launch_impact(self):
        print "launching impact"

        proc = self.run_generic_installer("impact.exe", IMPACT_LAUNCHER_XML, _vars)
        self._wait_for_process(proc, self.launch_timeout)

        ret = True
        return ret


    def run_generic_installer(self, binaryfile, xmlfile, variables = {}):
        args = [os.path.abspath(os.path.join(os.path.dirname(__file__), GENERIC_INSTALLER_BINARY)), "-i", binaryfile, "-x", xmlfile]

        for k, v in variables.items():
            args.append("v:%s:%s" % (k, v))

        print "About to run command '%s'" % args
        return subprocess.Popen(args)


    def _wait_for_process(self, proc, timeout):
        start = time.time()
        while proc.poll() is None and time.time() - start < timeout:
            time.sleep(10)

        if proc.poll() is not None:
            print "process %s has started" % proc
        else:
            print "process %s has not started after %s seconds" % (proc, timeout)
        return not proc.poll() is None


if __name__ == '__main__':
    ii = InstallImpact()
    ii.run()