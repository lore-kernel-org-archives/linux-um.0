Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXCeU-00017p-Ol
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 20:54:14 -0800
Received: from mx13.sac.fedex.com ([199.81.197.53])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AXCeU-0000Zn-DT
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 20:54:14 -0800
Received: from mail-e1000-2.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx13.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id hBJ4s64T009270
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Dec 2003 22:54:06 -0600 (CST)
	(envelope-from jchua@fedex.com)
From: Jeff Chua <jchua@fedex.com>
Subject: Re: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0
In-Reply-To: <Pine.LNX.4.58.0312181514140.7622@earth>
Message-ID: <Pine.LNX.4.58.0312191232230.29584@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
 <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>
  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
 <Pine.LNX.4.58.0312181036220.31295@earth> <Pine.LNX.4.58.0312181122070.32554@earth>
 <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181253460.2378@earth>
 <Pine.LNX.4.58.0312181514140.7622@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 19 Dec 2003 12:35:35 +0800 (SGT)
To: Ingo Molnar <mingo@elte.hu>
Cc: UML devel list <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>

On Thu, 18 Dec 2003, Ingo Molnar wrote:

>     redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A2

Can't compile. Got the following error ...

my .config has these ...
	# CONFIG_MODE_TT is not set
	# CONFIG_STATIC_LINK is not set
	CONFIG_MODE_SKAS=y


Also, Reiser4 patch linux-2.6.0-test9-reiser4.diff.gz can't be used with
uml-combo-2.6.0-A2.


Thanks,
Jeff


make -f scripts/Makefile.build obj=arch/um/util
gcc -o arch/um/util/mk_task_user.o -c arch/um/util/mk_task_user.c
  CC      arch/um/util/mk_task_kern.o
In file included from include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/util/mk_task_kern.c:1:
include/asm/processor.h:66: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here
(not in a function)
include/asm/processor.h:66: requested alignment is not a constant
arch/um/util/mk_task_kern.c: In function `main':
arch/um/util/mk_task_kern.c:13: structure has no member named `regs'
make[1]: *** [arch/um/util/mk_task_kern.o] Error 1
make: *** [arch/um/util] Error 2




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
