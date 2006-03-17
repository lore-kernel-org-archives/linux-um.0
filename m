Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FKKAB-0007dG-7Y for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 10:59:03 -0800
Received: from cobalt.cs.wisc.edu ([128.105.121.30])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FKKA8-0005pc-T6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 10:59:03 -0800
Received: from cobalt.cs.wisc.edu (localhost [127.0.0.1])
	by cobalt.cs.wisc.edu (8.13.1/8.13.1) with ESMTP id k2HIvOmW009032
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2006 12:57:24 -0600
Received: (from epaulson@localhost)
	by cobalt.cs.wisc.edu (8.13.1/8.13.1/Submit) id k2HIvOu2009031
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 12:57:24 -0600
From: Erik Paulson <epaulson@cs.wisc.edu>
Message-ID: <20060317185723.GA8310@cobalt.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] compile failure on uml-2.6.15-bs3-tls (and an easy fix)
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
Date: Fri, 17 Mar 2006 12:57:23 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Hello, 

On a CentOS 4.2 machine, I had the same failure that Bill Stearns had
back in January in this message:

http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg02943.html

(the failure: 

arch/um/os-Linux/tls.c:48: error: syntax error before 'get_thread_area'
arch/um/os-Linux/tls.c:48: warning: type defaults to 'int' in declaration
of '_syscall1'
)

The small addition of #include <linux/unistd.h> fixed it for me.

Here's how I built my kernel:

tar xvfz /p/mirror/pub/mirrors/linux/kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.6.tar.gz
wget http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.15-bs3-tls/uml-2.6.15-bs3-tls.patch.bz2
wget http://uml.nagafix.co.uk/kernels/kernel32-2.6.15.6-bs3-tls.config
bunzip2 uml-2.6.15-bs3-tls.patch.bz2
cd linux-2.6.15.6/
patch -p1 < ../uml-2.6.15-bs3-tls.patch
make mrproper ARCH=um
cp ../kernel32-2.6.15.6-bs3-tls.config .config
make ARCH=um oldconfig
make linux ARCH=um
vi arch/um/os-Linux/tls.c
make linux ARCH=um

teal(37)% gcc -v
Reading specs from /usr/lib/gcc/i386-redhat-linux/3.4.4/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-java-awt=gtk --host=i386-redhat-linux
Thread model: posix
gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)

teal(40)% rpm -qa | grep glibc
glibc-utils-2.3.4-2.13
glibc-common-2.3.4-2.13
glibc-headers-2.3.4-2.13
glibc-2.3.4-2.13
glibc-devel-2.3.4-2.13
glibc-kernheaders-2.4-9.1.98.EL



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
