Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDnc5-0005Yp-5g for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:56:21 -0800
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DDnc4-0005ij-J2 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:56:21 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050322162121.4295D2125C@zion>
Subject: [uml-devel] [patch 02/12] uml: cpu_relax fix
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
Date: Tue, 22 Mar 2005 17:21:21 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s doing
that (i.e. i386 and x86_64).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/include/asm-um/processor-generic.h |    2 --
 linux-2.6.11-paolo/include/asm-um/processor-i386.h    |    8 ++++++++
 linux-2.6.11-paolo/include/asm-um/processor-x86_64.h  |    8 ++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff -puN include/asm-um/processor-generic.h~uml-cpu_relax include/asm-um/processor-generic.h
--- linux-2.6.11/include/asm-um/processor-generic.h~uml-cpu_relax	2005-03-22 16:52:25.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-generic.h	2005-03-22 16:54:41.000000000 +0100
@@ -16,8 +16,6 @@ struct task_struct;
 
 struct mm_struct;
 
-#define cpu_relax()   barrier()
-
 struct thread_struct {
 	int forking;
 	int nsyscalls;
diff -puN include/asm-um/processor-i386.h~uml-cpu_relax include/asm-um/processor-i386.h
--- linux-2.6.11/include/asm-um/processor-i386.h~uml-cpu_relax	2005-03-22 16:53:43.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-i386.h	2005-03-22 16:54:39.000000000 +0100
@@ -19,6 +19,14 @@ struct arch_thread {
 
 #include "asm/arch/user.h"
 
+/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
+static inline void rep_nop(void)
+{
+	__asm__ __volatile__("rep;nop": : :"memory");
+}
+
+#define cpu_relax()	rep_nop()
+
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter"). Stolen
diff -puN include/asm-um/processor-x86_64.h~uml-cpu_relax include/asm-um/processor-x86_64.h
--- linux-2.6.11/include/asm-um/processor-x86_64.h~uml-cpu_relax	2005-03-22 16:56:30.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/processor-x86_64.h	2005-03-22 16:56:32.000000000 +0100
@@ -12,6 +12,14 @@
 struct arch_thread {
 };
 
+/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
+extern inline void rep_nop(void)
+{
+	__asm__ __volatile__("rep;nop": : :"memory");
+}
+
+#define cpu_relax()   rep_nop()
+
 #define INIT_ARCH_THREAD { }
 
 #define current_text_addr() \
_


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
