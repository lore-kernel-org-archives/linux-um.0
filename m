Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ953-0001Gg-Si for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 12:17:17 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DQ94j-0007Ma-Fw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 12:17:16 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050425191253.B9FE045EBB@zion>
Subject: [uml-devel] [patch 1/1] uml: fix handling of no fpx_regs [critical,
	for 2.6.12]
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
Date: Mon, 25 Apr 2005 21:12:51 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, aleidenf@bigpond.net.au


From: Andree Leidenfrost <aleidenf@bigpond.net.au>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix the error path, which is triggered when the processor misses the fpx regs
(i.e. the "fxsr" cpuinfo feature). For instance by VIA C3 Samuel2. Tested and
obvious, please merge ASAP.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_handling arch/um/os-Linux/sys-i386/registers.c
--- linux-2.6.12/arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_handling	2005-04-25 21:03:11.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c	2005-04-25 21:08:07.000000000 +0200
@@ -105,14 +105,15 @@ void init_registers(int pid)
 		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d",
 		      err);
 
+	errno = 0;
 	err = ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
 	if(!err)
 		return;
+	if(errno != EIO)
+		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
+		      errno);
 
 	have_fpx_regs = 0;
-	if(err != EIO)
-		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
-		      err);
 
 	err = ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
 	if(err)
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
