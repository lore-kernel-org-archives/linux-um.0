Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIAnl-0006jt-HV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Oct 2004 11:58:13 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CIAnk-00055W-88 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Oct 2004 11:58:13 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041014161758.C4CF444BE@zion.localdomain>
Subject: [uml-devel] [patch 1/1] SKAS3: fix mm->dumpable handling
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
Date: Thu, 14 Oct 2004 18:17:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it, uml@hno.marasystems.com, mcr@sandelman.ottawa.on.ca


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Henrik Nordstrom <uml@hno.marasystems.com>, Michael Richardson <mcr@sandelman.ottawa.on.ca>

When a child mm is created by opening /proc/mm, without this patch its
mm->dumpable flag is left set to 0, even when there is no reason to do so.

This way, for instance, if <pid> is the pid of a userspace thread,
/proc/<pid> is only readable by root (which was the original reason letting
this be diagnosed by Michael Richardson).

Paolo and Henrik discussed about this in detail, finally Paolo wrote the patch
and sent it for comment.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c |    8 ++++++++
 vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c              |    2 ++
 2 files changed, 10 insertions(+)

diff -puN mm/proc_mm.c~fix-dumpable-handling mm/proc_mm.c
--- vanilla-linux-2.6.7-SKAS/mm/proc_mm.c~fix-dumpable-handling	2004-10-14 16:58:17.473473200 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c	2004-10-14 18:15:21.294545552 +0200
@@ -125,6 +125,8 @@ static int open_proc_mm(struct inode *in
 		goto out_mem;
 
 	init_new_empty_context(mm);
+	mm->dumpable = current->mm->dumpable;
+	wmb();
 
 	spin_lock(&mmlist_lock);
 	list_add(&mm->mmlist, &current->mm->mmlist);
diff -puN arch/i386/kernel/ptrace.c~fix-dumpable-handling arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/ptrace.c~fix-dumpable-handling	2004-10-14 17:05:30.651620112 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c	2004-10-14 18:15:21.297545096 +0200
@@ -559,6 +559,14 @@ asmlinkage int sys_ptrace(long request, 
 			break;
 		}
 
+		/* Let's be safe. If we are ptraced from a non-dumpable process,
+		 * let's not be dumpable. Don't try to be smart and turn
+		 * current->dumpable to 1: it may be unsafe.*/
+		if (!current->dumpable) {
+			new->dumpable = 0;
+			wmb();
+		}
+
 		atomic_inc(&new->mm_users);
 		child->mm = new;
 		child->active_mm = new;
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
