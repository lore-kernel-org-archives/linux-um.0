Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XXVQ7-00011A-5k
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 13:18:47 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XXVQ5-0002Ut-Tg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 13:18:47 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri, 26 Sep 2014 14:18:36 +0100
Message-Id: <1411737516-673516-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH v2] Fix for occasional userspace process in D/Z
	state
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at

From: Anton Ivanov <antivano@cisco.com>

Occasionally, under very heavy load inside UML, on host
or both one of the processes in UML will remain in D state
or will fail to reap a child which will sit in Z state.

This is very difficult to reproduce with stock UML because
the lseek()/read()|write()|fsync() in the ubd driver will
cause a constant "trickle" of memory synchronization regardless
of what UML is doing. It is possible though (3-4 hours of
loadavg >6 stress load with low memory can trigger it).

If lseek()/read()|write() are replaced with its equivalent
pread()|pwrite() the original bug becomes much easier to
reproduce. It now takes 5-10 minutes of heavy IO to cause it.

This fix seems to cure it. I am not sure if this is the best
place to invoke a memory barrier, this one works.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---

This version takes into account the fact that uml picks up the 
correct define out of arch/x86/um/barrier.h so no need to invoke it 
directly - noted by Richard Weinberger

I still do not know if this is the correct location to hit it with a
mb(). This one seems to cure it.

 arch/um/kernel/exec.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 0d7103c..86b1dc1 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -27,6 +27,7 @@ void flush_thread(void)
 	ret = unmap(&current->mm->context.id, 0, STUB_START, 0, &data);
 	ret = ret || unmap(&current->mm->context.id, STUB_END,
 			   host_task_size - STUB_END, 1, &data);
+	mb();
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

