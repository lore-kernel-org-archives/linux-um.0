Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWsmG-00079S-UC
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 23:40:56 -0800
Received: from mx11.sac.fedex.com ([199.81.193.118])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AWsmG-0001S2-HW
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 23:40:56 -0800
Received: from mail-e1000-1.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx11.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id hBI7egJw084047
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Dec 2003 01:40:42 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet03.prod.fedex.com (8.12.10/8.12.10) with ESMTP id hBI7eelx009717
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Dec 2003 01:40:41 -0600 (CST)
Received: from boston.corp.fedex.com ([155.161.156.88])
	by silk.corp.fedex.com (8.11.4/8.11.4) with ESMTP id hBI7d4021890
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Dec 2003 15:39:04 +0800
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.58.0312181520100.15701@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] uml-patch-2.4.22-7 without CONFIG_MODE_TT failed
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 15:24:06 +0800 (SGT)
To: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


uml-patch-2.4.22-7 on linux 2.4.24-pre1

Can't compile without CONFIG_MODE_TT. 2.4.22-5 has no problem.


Command to compile (make linux ARCH=um)


Thanks,
Jeff
[ jchua@fedex.com ]


gcc -D__KERNEL__ -I/v6/src/2424p1/uml/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-U__i386__ -Ui386 -DUM_FASTCALL  -D__arch_um__ -DSUBARCH="i386"
-D_LARGEFILE64_SOURCE -I/v6/src/2424p1/uml/arch/um/include
-Derrno=kernel_errno -I/v6/src/2424p1/uml/arch/um/kernel/skas/include
-nostdinc -iwithprefix include -DKBUILD_BASENAME=root  -DEXPORT_SYMTAB -c
root.c
In file included from /v6/src/2424p1/uml/arch/um/include/um_uaccess.h:17,
                 from /v6/src/2424p1/uml/include/asm/uaccess.h:31,
                 from root.c:9:
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h: In
function `verify_area_skas':
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:17:
`current' undeclared (first use in this function)
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:17:
(Each undeclared identifier is reported only once
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:17:
for each function it appears in.)
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:17:
`mm_segment_t' undeclared (first use in this function)
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:17:
parse error before `{'
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:17:
`TASK_SIZE' undeclared (first use in this function)
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:17:
`EFAULT' undeclared (first use in this function)
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:17:
parse error before `)'
/v6/src/2424p1/uml/arch/um/include/../kernel/skas/include/uaccess.h:18:
warning: control reaches end of non-void function
In file included from /v6/src/2424p1/uml/include/asm/processor.h:22,
                 from /v6/src/2424p1/uml/include/linux/prefetch.h:13,
                 from /v6/src/2424p1/uml/include/linux/list.h:6,
                 from /v6/src/2424p1/uml/include/linux/wait.h:14,
                 from /v6/src/2424p1/uml/include/linux/fs.h:12,
                 from /v6/src/2424p1/uml/include/linux/capability.h:17,
                 from /v6/src/2424p1/uml/include/linux/binfmts.h:5,
                 from /v6/src/2424p1/uml/include/linux/sched.h:9,
                 from root.c:12:
/v6/src/2424p1/uml/include/asm/processor-generic.h: At top level:
/v6/src/2424p1/uml/include/asm/processor-generic.h:95: `mm_segment_t' used
prior to declaration
make[3]: *** [root.o] Error 1
make[3]: Leaving directory `/v6/src/2424p1/uml/fs/proc'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/v6/src/2424p1/uml/fs/proc'
make[1]: *** [_subdir_proc] Error 2
make[1]: Leaving directory `/v6/src/2424p1/uml/fs'
make: *** [_dir_fs] Error 2




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
