Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tabbott@MIT.EDU>) id 1LzgBl-0006De-LM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 May 2009 00:01:13 +0000
Received: from biscayne-one-station.mit.edu ([18.7.7.80])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LzgBj-0008WF-Hf
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 May 2009 00:01:13 +0000
From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 19:59:46 -0400
Message-Id: <1241135986-10051-2-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135986-10051-1-git-send-email-tabbott@mit.edu>
References: <1241135986-10051-1-git-send-email-tabbott@mit.edu>
Subject: [uml-devel] [PATCH] um: use new macros for .data.init_task.
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
To: Sam Ravnborg <sam@ravnborg.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Dike <jdike@addtoit.com>, Jeff Arnold <jbarnold@MIT.EDU>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Tim Abbott <tabbott@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/dyn.lds.S   |    3 +--
 arch/um/kernel/init_task.c |    3 +--
 arch/um/kernel/uml.lds.S   |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 9975e1a..901f703 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -96,8 +96,7 @@ SECTIONS
   .init_array     : { *(.init_array) }
   .fini_array     : { *(.fini_array) }
   .data           : {
-    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
+    INIT_TASK_DATA(KERNEL_STACK_SIZE)
     . = ALIGN(KERNEL_STACK_SIZE);
     *(.data.init_irqstack)
     DATA_DATA
diff --git a/arch/um/kernel/init_task.c b/arch/um/kernel/init_task.c
index 806d381..0d4657f 100644
--- a/arch/um/kernel/init_task.c
+++ b/arch/um/kernel/init_task.c
@@ -33,8 +33,7 @@ EXPORT_SYMBOL(init_task);
  * "init_task" linker map entry..
  */
 
-union thread_union init_thread_union
-	__attribute__((__section__(".data.init_task"))) =
+union thread_union init_thread_union __init_task_data =
 		{ INIT_THREAD_INFO(init_task) };
 
 union thread_union cpu0_irqstack
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 11b8352..e4394a5 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -52,8 +52,7 @@ SECTIONS
   init.data : { INIT_DATA }
   .data    :
   {
-    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
+    INIT_TASK_DATA(KERNEL_STACK_SIZE)
     . = ALIGN(KERNEL_STACK_SIZE);
     *(.data.init_irqstack)
     DATA_DATA
-- 
1.6.2.1


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

