Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg3VQ-00007E-IL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 08:29:44 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bg3VQ-0002oh-79 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 08:29:44 -0700
Message-Id: <s0e3cb9d.082@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Subject: [uml-devel] Problems compiling 2.4 kernel
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
Date: Thu, 01 Jul 2004 08:30:02 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

I've been using 2.6 kernels for several months. However, a new project requires me to build a UML 2.4 kernel. Unfortunately, I can't seem to compile the guest kernel. For this task, we've deployed a new machine with:

SuSE 9.0
C/C++ Development installed

My steps are as follows:

lynx http://www.kernel.org/   (download the 2.4.26 kernel)
lynx http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.4.26-1.bz2
tar -zxf linux-2.4.26.tar.gz
chown -R root:root linux-2.4.26
cd linux-2.4.26/
patch -p1 <../uml-patch-2.4.26-1   (applies cleanly with no rejects)
vi Makefile   (replace all instances of '-02' with '-01')
gzip -dc /proc/config.gz > .config
make oldconfig ARCH=um
make dep ARCH=um   (this just flies - it takes less than one second)
make ARCH=um

At this point, I see over 5000 errors lines. It starts with:

gcc -D__KERNEL__ -I/root/uml-2.4/linux-2.4.26/include -Wall -Wstrict-prototypes -Wno-trigraphs -O1 -fno-strict-aliasing -fno-common  -U__i386__ -Ui386 -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE -I/root/uml-2.4/linux-2.4.26/arch/um/include -Derrno=kernel_errno -I/root/uml-2.4/linux-2.4.26/arch/um/kernel/tt/include -I/root/uml-2.4/linux-2.4.26/arch/um/kernel/skas/include   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /root/uml-2.4/linux-2.4.26/include/linux/posix_types.h:46,
                 from /root/uml-2.4/linux-2.4.26/include/linux/types.h:15,
                 from /root/uml-2.4/linux-2.4.26/include/linux/capability.h:16,
                 from /root/uml-2.4/linux-2.4.26/include/linux/binfmts.h:5,
                 from /root/uml-2.4/linux-2.4.26/include/linux/sched.h:9,
                 from /root/uml-2.4/linux-2.4.26/include/linux/mm.h:4,
                 from /root/uml-2.4/linux-2.4.26/include/linux/slab.h:14,
                 from /root/uml-2.4/linux-2.4.26/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/root/uml-2.4/linux-2.4.26/include/asm/posix_types.h:4:34: asm/arch/posix_types.h: No such file or directory
In file included from /root/uml-2.4/linux-2.4.26/include/linux/types.h:16,
                 from /root/uml-2.4/linux-2.4.26/include/linux/capability.h:16,
                 from /root/uml-2.4/linux-2.4.26/include/linux/binfmts.h:5,
                 from /root/uml-2.4/linux-2.4.26/include/linux/sched.h:9,
                 from /root/uml-2.4/linux-2.4.26/include/linux/mm.h:4,
                 from /root/uml-2.4/linux-2.4.26/include/linux/slab.h:14,
                 from /root/uml-2.4/linux-2.4.26/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/root/uml-2.4/linux-2.4.26/include/asm/types.h:4:28: asm/arch/types.h: No such file or directory
In file included from /root/uml-2.4/linux-2.4.26/include/linux/capability.h:16,
                 from /root/uml-2.4/linux-2.4.26/include/linux/binfmts.h:5,
                 from /root/uml-2.4/linux-2.4.26/include/linux/sched.h:9,
                 from /root/uml-2.4/linux-2.4.26/include/linux/mm.h:4,
                 from /root/uml-2.4/linux-2.4.26/include/linux/slab.h:14,
                 from /root/uml-2.4/linux-2.4.26/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/root/uml-2.4/linux-2.4.26/include/linux/types.h:21: error: parse error before "dev_t"
/root/uml-2.4/linux-2.4.26/include/linux/types.h:21: warning: type defaults to `int' in declaration of `dev_t'
/root/uml-2.4/linux-2.4.26/include/linux/types.h:21: warning: data definition has no type or storage class
/root/uml-2.4/linux-2.4.26/include/linux/types.h:22: error: parse error before "ino_t"

Help is greatly appreciated!

Tony



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
