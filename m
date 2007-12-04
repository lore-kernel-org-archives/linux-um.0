Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzZTp-0003lW-Sc for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Dec 2007 07:14:38 -0800
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IzZTo-000818-IX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Dec 2007 07:14:37 -0800
Received: by wa-out-1112.google.com with SMTP id k22so6794825waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 04 Dec 2007 07:14:35 -0800 (PST)
Message-ID: <ea9232d10712040714i76f18e69j3e8c7bb5dd6dfffd@mail.gmail.com>
Date: Tue, 4 Dec 2007 16:14:34 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: Remove an unused variable in external_pid
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch eliminates yet one more unused variable.
Compile and run tested.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---
diff -rupN orig/arch/um/kernel/process.c orig2/arch/um/kernel/process.c
--- orig/arch/um/kernel/process.c	2007-12-04 15:24:07.000000000 +0100
+++ orig2/arch/um/kernel/process.c	2007-12-04 15:24:46.000000000 +0100
@@ -30,7 +30,7 @@
  */
 struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { -1, NULL } };

-static inline int external_pid(struct task_struct *task)
+static inline int external_pid(void)
 {
 	/* FIXME: Need to look up userspace_pid by cpu */
 	return userspace_pid[0];
@@ -78,7 +78,7 @@ int kernel_thread(int (*fn)(void *), voi
 static inline void set_current(struct task_struct *task)
 {
 	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task)
-		{ external_pid(task), task });
+		{ external_pid(), task });
 }

 extern void arch_switch_to(struct task_struct *to);

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
