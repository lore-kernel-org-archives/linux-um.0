Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOMwp-0007P6-0v	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 15:13:43 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOMwn-0004XG-2U
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 15:13:42 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j98Ni7ZY004089
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 8 Oct 2005 19:44:07 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081713.32447.rob@landley.net>
Subject: [uml-devel] How to reproduce my race condition.
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
Date: Sat, 8 Oct 2005 17:13:32 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Here's what I do:

Grab the binaries tarball from http://www.landley.net/code/firmware/broken.tbz 
(this is about 650k compressed, and 1.3 megs uncompressed).

Extract it, and remember where it is.

Build UML, as follows:

tar xvjf linux-2.6.13.2.tar.bz2
cd linux-2.6.13.2
make ARCH=um allnoconfig
cat >> .config << EOF
CONFIG_MODE_SKAS=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_STDERR_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_LBD=y
CONFIG_PROC_FS=y
EOF
yes "" | make ARCH=um oldconfig
make ARCH=um

Run this UML via:

./linux rootfstype=hostfs  rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1

And now run the test:

chroot /path/to/broken /test.sh

An example run on my laptop:

chroot /home/landley/newbuild/firmware-build-0.8.1/broken /test.sh
/busybox install -c test.sh /sub/1
/busybox install -c test.sh /sub/2
/busybox install -c test.sh /sub/3
/busybox install -c test.sh /sub/4
/busybox install -c test.sh /sub/5
/busybox install -c test.sh /sub/6
/busybox install -c test.sh /sub/7
/busybox install -c test.sh /sub/8
/busybox install -c test.sh /sub/9
/busybox install -c test.sh /sub/10
/busybox install -c test.sh /sub/11
/busybox install -c test.sh /sub/12
/busybox install -c test.sh /sub/13
install: unable to open `/sub/13/test.sh': No such file or directory
install: cannot change permissions of /sub/13/test.sh: No such file or 
directory
install: cannot change ownership of /sub/13/test.sh: No such file or directory
sh-3.00#                       


It's possible that busybox or uClibc is doing something wrong, but this is 
_rock_solid_ on a normal kernel, and on 2.6.11-um (under -tt mode, anyway).  
On 2.6.13, this happens in both -tt mode and -skas0 mode.

Help?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
