Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hl9lk-0001dS-6B for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 May 2007 13:25:16 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hl9lj-0007b7-K3
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 May 2007 13:25:16 -0700
Date: Mon, 7 May 2007 16:20:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070507202020.GA8510@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/5] UML - Turn build warnings into comments
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <mszeredi@suse.cz>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Miklos Szeredi <mszeredi@suse.cz>

These haven't been fixed for ages.  Just make comments out of them.

arch/um/kernel/skas/process.c:181:2: warning: #warning Need to look up
+userspace_pid by cpu
arch/um/kernel/skas/process.c:187:2: warning: #warning Need to look up
+userspace_pid by cpu
arch/um/kernel/skas/process.c:194:2: warning: #warning need to loop over
+userspace_pids in kill_off_processes_skas

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/skas/process.c   |    9 ++++++---
 arch/um/os-Linux/skas/mem.c     |    2 +-
 arch/um/os-Linux/skas/process.c |    2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/skas/process.c	2007-05-07 14:58:53.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/skas/process.c	2007-05-07 14:59:26.000000000 -0400
@@ -178,20 +178,23 @@ int start_uml_skas(void)
 
 int external_pid_skas(struct task_struct *task)
 {
-#warning Need to look up userspace_pid by cpu
+	/* FIXME: Need to look up userspace_pid by cpu */
 	return(userspace_pid[0]);
 }
 
 int thread_pid_skas(struct task_struct *task)
 {
-#warning Need to look up userspace_pid by cpu
+	/* FIXME: Need to look up userspace_pid by cpu */
 	return(userspace_pid[0]);
 }
 
 void kill_off_processes_skas(void)
 {
 	if(proc_mm)
-#warning need to loop over userspace_pids in kill_off_processes_skas
+		/*
+		 * FIXME: need to loop over userspace_pids in
+		 * kill_off_processes_skas
+		 */
 		os_kill_ptraced_process(userspace_pid[0], 1);
 	else {
 		struct task_struct *p;
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/mem.c	2007-05-07 10:36:17.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c	2007-05-07 14:59:26.000000000 -0400
@@ -68,7 +68,7 @@ static inline long do_syscall_stub(struc
 	int err, pid = mm_idp->u.pid;
 
 	if(proc_mm)
-#warning Need to look up userspace_pid by cpu
+		/* FIXME: Need to look up userspace_pid by cpu */
 		pid = userspace_pid[0];
 
 	multi_count++;
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/process.c	2007-05-07 14:59:00.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/process.c	2007-05-07 14:59:26.000000000 -0400
@@ -586,7 +586,7 @@ void switch_mm_skas(struct mm_id *mm_idp
 {
 	int err;
 
-#warning need cpu pid in switch_mm_skas
+	/* FIXME: need cpu pid in switch_mm_skas */
 	if(proc_mm){
 		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
 			     mm_idp->u.mm_fd);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
