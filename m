Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1VO8DX-00012o-1Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Sep 2013 15:38:31 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VO8DW-0000XP-3k for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Sep 2013 15:38:31 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 23 Sep 2013 17:38:03 +0200
Message-Id: <1379950684-18710-3-git-send-email-richard@nod.at>
In-Reply-To: <1379950684-18710-1-git-send-email-richard@nod.at>
References: <1379950684-18710-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 3/4] um: Get rid of thread_struct->saved_task
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

As we have a sane show_stack() now, we can drop
the ->saved_task hack.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/mconsole_kern.c         |  6 ++----
 arch/um/include/asm/processor-generic.h |  1 -
 arch/um/kernel/process.c                | 15 ++-------------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 3df3bd5..29880c9 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -645,11 +645,9 @@ void mconsole_sysrq(struct mc_request *req)
 
 static void stack_proc(void *arg)
 {
-	struct task_struct *from = current, *to = arg;
+	struct task_struct *task = arg;
 
-	to->thread.saved_task = from;
-	rcu_user_hooks_switch(from, to);
-	switch_to(from, to, from);
+	show_stack(task, NULL);
 }
 
 /*
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 9046903..d89b02b 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -19,7 +19,6 @@ struct task_struct;
 struct mm_struct;
 
 struct thread_struct {
-	struct task_struct *saved_task;
 	struct pt_regs regs;
 	struct pt_regs *segv_regs;
 	int singlestep_syscall;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index bbcef52..eecc414 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -82,19 +82,8 @@ void *__switch_to(struct task_struct *from, struct task_struct *to)
 	to->thread.prev_sched = from;
 	set_current(to);
 
-	do {
-		current->thread.saved_task = NULL;
-
-		switch_threads(&from->thread.switch_buf,
-			       &to->thread.switch_buf);
-
-		arch_switch_to(current);
-
-		if (current->thread.saved_task)
-			show_regs(&(current->thread.regs));
-		to = current->thread.saved_task;
-		from = current;
-	} while (current->thread.saved_task);
+	switch_threads(&from->thread.switch_buf, &to->thread.switch_buf);
+	arch_switch_to(current);
 
 	return current->thread.prev_sched;
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

