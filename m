Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZual-0002sf-10 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 11:54:55 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZual-0006Ra-5U for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 11:54:55 -0700
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]
	helo=aa001msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FZuak-0000EU-IA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 11:54:55 -0700
Received: from ms003msg.fastwebnet.it (10.31.41.45) by aa001msg.fastwebnet.it
	(7.2.069.1)
	id 4447436E0042F937 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 20:54:48 +0200
Received: from inferi (23.251.77.98) by ms003msg.fastwebnet.it (7.2.070)
	id 443CC73D00770B37 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 20:54:48 +0200
Received: from mattia by inferi with local (Exim 4.61)
	(envelope-from <malattia@linux.it>) id 1FZubZ-0006IR-S4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 20:55:45 +0200
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20060429185545.GB6458@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] helping toward UML 1.0 (??)
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 29 Apr 2006 20:55:45 +0200
To: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

Hello Jeff, Paolo,

Sorry for the long mail, I hope it's not too boring ;)

I re-packaged (together with Stefano Melchior and Andreas Schuldei) the
user-mode-linux kernel[1] and uml-utilities[2] and I'd like to help with
the issues listed on u-m-l.sf.net pages related to Debian.
Firts of all: are all those issues still outstanding?

Hmmm... they seem to be there since a long long time.
Anyway here's some comments:

===========================================================
My attempts to run the Debian install procedure hung UML...
===========================================================
It's working now, I'm installing from debian etch beta2 netinst[0].
Procedure: extract the initrd.gz from the iso image downloaded at [0] (I
tested the 2.6 flavour in /cdrom/install/2.6/) and run UML with

linux ramdisk_size=12000 mem=128M umid=debian initrd=initrd.gz \
      root=/dev/ram0 ubd0=my_rootfs ubd1=debian-testing-i386-netinst.iso \
      eth0=tuntap,,,172.20.0.1

I'm using uxterm to run this as the installer interface relies on UTF8
chars to draw correctly.

BTW: current Debian user-mode-linux package unfortunately is missing
some important config options to run an initrd, I'm planning to upload a
new revision very soon to fix that.

==============
Packaging debs
==============
You can find most of the info on the page at [1]. We are currenlty
carrying a few patches[3] to comply to the FHS and Debian policy,
namely:
  * 02_fix_install_directories (uml-utilities)[4]:
    1- don't use lib64 in Debian, we have a symlink lib->lib64 (I'm no
       multiarch expert but I'd say debian implements it differently from
       FHS)
    2- install uml_net into /usr/lib/uml to comply FHS 4.7.1
       somewhat discussed with a proposed patch to add /usr/lib/uml the
       the $PATH which we're already building binaries with.
    3- install tunctl in /usr/sbin as it's a root-only executable
  
  * 01_uml_net (uml kernel)[5]:
    see point 2 above, the same patch has been posted here and currently
    is in Paolo's tree (thanks!)
    
  * 02_x-terminal-emulator (uml kernel)[6]:
    1- run the x-terminal-emulator link instead of plain xterm to
       respect user configured default x-terminal.
       This is a debian only patch.

========
Manpages
========
We have a manpage (linux (1)) that is some kind of big blob of
historical and current uml command line options more or less derived
from linux --help and the u-m-l website.
Ever seen it? [7] or [8] as plain text

====
Docs
====
We are also carrying the user-mode-linux-doc package which is
essentially the u-m-l website. It needs updating (last update iwas
05.23.2002) but I was wondering if it makes some sense to still keep
them as I also read there's some wiki effort in place to replace the
website.


[0]: http://www.debian.org/devel/debian-installer/
[1]: http://packages.qa.debian.org/u/user-mode-linux.html
[2]: http://packages.qa.debian.org/u/uml-utilities.html
[3]: http://svn.debian.org/wsvn/pkg-uml/trunk/src/?rev=0&sc=0
[4]: http://svn.debian.org/wsvn/pkg-uml/trunk/src/uml-utilities/debian/patches/02_fix_install_directories.dpatch?op=file&rev=0&sc=0
[5]: http://svn.debian.org/wsvn/pkg-uml/trunk/src/user-mode-linux/debian/patches/01_uml_net.dpatch?op=file&rev=0&sc=0
[6]: http://svn.debian.org/wsvn/pkg-uml/trunk/src/user-mode-linux/debian/patches/02_x-terminal-emulator.dpatch?op=file&rev=0&sc=0
[7]: http://svn.debian.org/wsvn/pkg-uml/trunk/src/user-mode-linux/linux.sgml?op=file&rev=0&sc=0
[8]: http://people.debian.org/~malattia/docs/linux.1.txt

bye
-- 
mattia
:wq!


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
