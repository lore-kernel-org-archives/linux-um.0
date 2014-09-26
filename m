Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XXU1z-00044Q-Bm
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 11:49:47 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XXU1x-0007Rt-Tr
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 11:49:47 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri, 26 Sep 2014 12:49:26 +0100
Message-Id: <1411732166-653849-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] Fix for "occasional userspace process in D/Z
	state" bug
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at

From: Anton Ivanov <antivano@cisco.com>

This is a fix for a very old UML bug which can be triggered with stock 
UML. It takes a lot of effort to trigger it there because the 
lseek()/read() | write() mechanics of the UBD driver implicitly sync the 
memory all the time by hitting the appropriate barrier implementation in 
the host kernel. 

By improving the disk susbsystem we make this bug raise its ugly head
with a vengeance - you can get a process in D (with an occasional child
in Z state) simply by running an apt-get on 30-40 large packages. 

Is this correct place to have the sync - no idea. It may need to move
to somewhere inside tlb.c. With the fence in exec.c it works (TM).

If I understand this correctly, this also needs to be an instruction 
appropriate for the underlying host so just a barrier() will not cut 
it. You have to fence. En-guarde... Touche... :)

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/kernel/exec.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 0d7103c..7cb6805 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -27,6 +27,11 @@ void flush_thread(void)
 	ret = unmap(&current->mm->context.id, 0, STUB_START, 0, &data);
 	ret = ret || unmap(&current->mm->context.id, STUB_END,
 			   host_task_size - STUB_END, 1, &data);
+#ifdef CONFIG_X86_32
+	alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2);
+#else
+	asm volatile("mfence":::"memory");
+#endif
 	if (ret) {
 		printk(KERN_ERR "flush_thread - clearing address space failed, "
 		       "err = %d\n", ret);
-- 
1.7.10.4


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

