Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EY2Ds-0005of-4A for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 06:07:16 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EY2Dp-0007Kp-Lf
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 06:07:16 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jA4FdsiT002481
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 4 Nov 2005 10:39:54 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511040807.03708.rob@landley.net>
Subject: [uml-devel] What's different about building for x86-64?
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
Date: Fri, 4 Nov 2005 08:07:03 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Daving Lang grabbed my firmware-linux build script and tried to build it on 
x86-64, and it barfed trying to compile User Mode Linux:

gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -O2 -fomit-frame-pointer -D__arch_um__ 
-DSUBARCH=\"x86_64\" -Dvmap=kernel_vmap -Iarch/um/include 
-I/root/firmware-build-0.8.9/tmpdir/linux-2.6.13.2/arch/um/kernel/tt/include 
-I/root/firmware-build-0.8.9/tmpdir/linux-2.6.13.2/arch/um/kernel/skas/include 
-fno-builtin -D_GNU_SOURCE -D_LARGEFILE64_SOURCE -S -o 
arch/um/user-offsets.s arch/um/sys-x86_64/user-offsets.c
arch/um/sys-x86_64/user-offsets.c: In function `foo':
arch/um/sys-x86_64/user-offsets.c:24: error: structure has no member named 
`rbx'
arch/um/sys-x86_64/user-offsets.c:25: error: structure has no member named 
`rcx'
...
and so on.

My build is basically extracting the 2.6.14 tarball, adding the squashfs 
patch, and then doing this:

make ARCH=um O=../linux-build allnoconfig &&
cd ../linux-build &&
cat >> .config << EOF &&
CONFIG_MODE_SKAS=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_SYSCTL=y
CONFIG_STDERR_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_UBD=y
CONFIG_TMPFS=y
CONFIG_SWAP=y
CONFIG_LBD=y
CONFIG_EXT2_FS=y
CONFIG_PROC_FS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_ZLIB_INFLATE=y
EOF
yes "" | make ARCH=um oldconfig &&
make ARCH=um &&

It's not working, and I don't have an x86-64 machine to test this on.  I can 
only assume the config file is wrong, but it's in a way that oldconfig isn't 
fixing...

I don't know quite how ARCH=um figures out whether it's derived from ARCH=i386 
or ARCH=x86-64...

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
