Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhTB9-0002fG-J6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:20:15 -0700
Received: from mail-gw1.sa.eol.hu ([212.108.200.67])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhTB7-0003bJ-D5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 09:20:15 -0700
In-reply-to: <E1HhT90-0001dW-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 27 Apr 2007 18:18:02 +0200)
References: <E1HhT90-0001dW-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1HhTAi-0001eK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Apr 2007 18:19:48 +0200
Subject: [uml-devel] [patch] uml: remove #warnings
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Miklos Szeredi <mszeredi@suse.cz>

These haven't been fixed for ages.  Just make comments out of them.

arch/um/kernel/skas/process.c:181:2: warning: #warning Need to look up userspace_pid by cpu
arch/um/kernel/skas/process.c:187:2: warning: #warning Need to look up userspace_pid by cpu
arch/um/kernel/skas/process.c:194:2: warning: #warning need to loop over userspace_pids in kill_off_processes_skas

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
---

Index: linux/arch/um/kernel/skas/process.c
===================================================================
--- linux.orig/arch/um/kernel/skas/process.c	2007-04-26 15:12:23.000000000 +0200
+++ linux/arch/um/kernel/skas/process.c	2007-04-26 15:12:51.000000000 +0200
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
Index: linux/arch/um/os-Linux/skas/mem.c
===================================================================
--- linux.orig/arch/um/os-Linux/skas/mem.c	2007-04-26 14:20:23.000000000 +0200
+++ linux/arch/um/os-Linux/skas/mem.c	2007-04-26 15:12:51.000000000 +0200
@@ -55,7 +55,7 @@ static inline long do_syscall_stub(struc
 	int pid = mm_idp->u.pid;
 
 	if(proc_mm)
-#warning Need to look up userspace_pid by cpu
+		/* FIXME: Need to look up userspace_pid by cpu */
 		pid = userspace_pid[0];
 
 	multi_count++;
Index: linux/arch/um/os-Linux/skas/process.c
===================================================================
--- linux.orig/arch/um/os-Linux/skas/process.c	2007-04-26 14:20:23.000000000 +0200
+++ linux/arch/um/os-Linux/skas/process.c	2007-04-26 15:12:51.000000000 +0200
@@ -560,7 +560,7 @@ void switch_mm_skas(struct mm_id *mm_idp
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
