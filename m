Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FU6Pj-0001UJ-3R for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Apr 2006 11:19:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FU6Pi-00019h-Jj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Apr 2006 11:19:31 -0700
Message-Id: <200604131720.k3DHKOTe004697@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [RFC] PATCH 2/4 - Time virtualization : unshare support
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
Date: Thu, 13 Apr 2006 13:20:20 -0400
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Add time namespace support to unshare, controlled by CLONE_TIME.

Index: linux-2.6.17-mm-vtime/include/linux/sched.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/include/linux/sched.h	2006-04-13 13:48:32.000000000 -0400
+++ linux-2.6.17-mm-vtime/include/linux/sched.h	2006-04-13 13:49:11.000000000 -0400
@@ -65,6 +65,7 @@ struct bio;
 #define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
 #define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
 #define CLONE_STOPPED		0x02000000	/* Start in stopped state */
+#define CLONE_TIME		0x04000000	/* Make a new time namespace */
 
 /*
  * List of flags we want to share for kernel threads,
Index: linux-2.6.17-mm-vtime/kernel/fork.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/kernel/fork.c	2006-04-13 13:48:02.000000000 -0400
+++ linux-2.6.17-mm-vtime/kernel/fork.c	2006-04-13 13:49:11.000000000 -0400
@@ -1563,6 +1563,25 @@ static int unshare_semundo(unsigned long
 	return 0;
 }
 
+static int unshare_time(unsigned long unshare_flags, struct time_ns **new)
+{
+	if(unshare_flags & CLONE_TIME){
+		*new = kmalloc(sizeof(struct time_ns), GFP_KERNEL);
+		if(*new == NULL)
+			return -ENOMEM;
+		atomic_set(&(*new)->counter, 1);
+		(*new)->offset = 0;
+	}
+
+	return 0;
+}
+
+static void put_time_ns(struct time_ns *time)
+{
+	if(atomic_sub_and_test(1, &time->counter))
+		kfree(time);
+}
+
 /*
  * unshare allows a process to 'unshare' part of the process
  * context which was originally shared using clone.  copy_*
@@ -1580,6 +1599,7 @@ asmlinkage long sys_unshare(unsigned lon
 	struct mm_struct *mm, *new_mm = NULL, *active_mm = NULL;
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
+	struct time_ns *time, *new_time = NULL;
 
 	check_unshare_flags(&unshare_flags);
 
@@ -1603,8 +1623,11 @@ asmlinkage long sys_unshare(unsigned lon
 		goto bad_unshare_cleanup_vm;
 	if ((err = unshare_semundo(unshare_flags, &new_ulist)))
 		goto bad_unshare_cleanup_fd;
+	if ((err = unshare_time(unshare_flags, &new_time)))
+		goto bad_unshare_cleanup_fd;
 
-	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
+	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
+		new_time) {
 
 		task_lock(current);
 
@@ -1641,9 +1664,18 @@ asmlinkage long sys_unshare(unsigned lon
 			new_fd = fd;
 		}
 
+		if(new_time) {
+			time = current->time_ns;
+			current->time_ns = new_time;
+			new_time = time;
+		}
+
 		task_unlock(current);
 	}
 
+	if (new_time)
+		put_time_ns(new_time);
+
 bad_unshare_cleanup_fd:
 	if (new_fd)
 		put_files_struct(new_fd);



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
