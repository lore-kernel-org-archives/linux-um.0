Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BniBD-0004HK-OY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 11:20:31 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BniBC-0007yY-Nr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 11:20:31 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fXAABjxTelsD6d1"
Message-Id: <200407222022.23126.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] Fix for the SKAS patch: avoid memory leak on the
	host
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
Date: Thu, 22 Jul 2004 20:22:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net



--Boundary-00=_fXAABjxTelsD6d1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This are the fixes for 2.4 and 2.6; I tested the 2.4 one, the 2.6 one is 
almost the same. This goes on top of the SKAS patch for 2.4, when it's > 
2.4.25, and for 2.6.

DESCRIPTION
The bug makes UML eat 8K of leaked kernel memory for each started process 
inside itself, only in some cases, i.e. when the UML is a descendant of a 
process which used modify_ldt(); for instance multithreaded process which 
uses the TLS (Thread Local Storage) support of LinuxThreads, not of NPTL. It 
happens me on 2.4 when I start UML from Kconsole.

This patch should fix it.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_fXAABjxTelsD6d1
Content-Type: text/x-diff; charset="us-ascii"; name="skas-leak-fix-2.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="skas-leak-fix-2.4.patch"




---

 linux-2.4.26-root/arch/i386/kernel/ldt.c |   22 +++++++++++++++++++---
 linux-2.4.26-root/mm/proc_mm.c           |    5 ++++-
 2 files changed, 23 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/ldt.c~skas-leak-fix-2.4 arch/i386/kernel/ldt.c
--- linux-2.4.26/arch/i386/kernel/ldt.c~skas-leak-fix-2.4	2004-07-20 15:33:08.000000000 +0200
+++ linux-2.4.26-root/arch/i386/kernel/ldt.c	2004-07-20 15:33:08.000000000 +0200
@@ -86,12 +86,14 @@ static inline int copy_ldt(mm_context_t 
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int __init_new_context(struct mm_struct *old_mm, struct mm_struct *mm)
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
+	struct mm_struct * old_mm;
 	int retval = 0;
 
 	init_MUTEX(&mm->context.sem);
 	mm->context.size = 0;
+	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		down(&old_mm->context.sem);
 		retval = copy_ldt(&mm->context, &old_mm->context);
@@ -100,8 +102,22 @@ int __init_new_context(struct mm_struct 
 	return retval;
 }
 
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm) {
-	return __init_new_context(current->mm, mm);
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm)
+{
+	int err = 0;
+	mm_context_t *new, *old;
+	new = &mm->context;
+	old = &old_mm->context;
+	if (old_mm && old_mm->context.size > 0) {
+		down(&old_mm->context.sem);
+		err = alloc_ldt(new, old->size, 0);
+		if (err < 0)
+			goto out;
+		memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+		up(&old_mm->context.sem);
+	}
+out:
+	return err;
 }
 
 /*
diff -puN mm/proc_mm.c~skas-leak-fix-2.4 mm/proc_mm.c
--- linux-2.4.26/mm/proc_mm.c~skas-leak-fix-2.4	2004-07-20 15:33:08.000000000 +0200
+++ linux-2.4.26-root/mm/proc_mm.c	2004-07-21 15:07:49.000000000 +0200
@@ -10,6 +10,7 @@
 #include "asm/mmu_context.h"
 
 static struct file_operations proc_mm_fops;
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm);
 
 struct mm_struct *proc_mm_get_mm(int fd)
 {
@@ -93,7 +94,9 @@ static ssize_t write_proc_mm(struct file
 		}
 
 		/*mm_copy_segments(from, mm);*/
-		__init_new_context(from, mm);
+		ret = copy_context(mm, from);
+		if(ret == 0)
+			ret = count;
 		break;
 	}
 	default:

_

--Boundary-00=_fXAABjxTelsD6d1
Content-Type: text/x-diff; charset="us-ascii"; name="skas-leak-fix-2.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="skas-leak-fix-2.6.patch"


init_new_context was called, and then __init_new_context; they both clear
the LDT (by setting its size to 0) and alloc a new one; and since the LDT size
has been cleared, alloc_ldt does not free() the LDT. It it exposed only if actually
the UML process has an LDT to allocate, i.e. if the UML kernel thread had an LDT
on the host when forking the init process.

---

 include/asm-i386/mmu_context.h                        |    0 
 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ldt.c |   21 +++++++++++++++---
 vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c           |    5 +++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/ldt.c~skas-leak-fix arch/i386/kernel/ldt.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/ldt.c~skas-leak-fix	2004-07-19 20:32:22.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ldt.c	2004-07-19 20:37:08.000000000 +0200
@@ -89,12 +89,14 @@ static inline int copy_ldt(mm_context_t 
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-int __init_new_context(struct mm_struct *mm, struct mm_struct *old_mm)
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
+	struct mm_struct * old_mm;
 	int retval = 0;
 
 	init_MUTEX(&mm->context.sem);
 	mm->context.size = 0;
+	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		down(&old_mm->context.sem);
 		retval = copy_ldt(&mm->context, &old_mm->context);
@@ -103,9 +105,22 @@ int __init_new_context(struct mm_struct 
 	return retval;
 }
 
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
-	return __init_new_context(mm, current->mm);
+	int err = 0;
+	mm_context_t *new, *old;
+	new = &mm->context;
+	old = &old_mm->context;
+	if (old_mm && old_mm->context.size > 0) {
+		down(&old_mm->context.sem);
+		err = alloc_ldt(new, old->size, 0);
+		if (err < 0)
+			goto out;
+		memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+		up(&old_mm->context.sem);
+	}
+out:
+	return err;
 }
 
 /*
diff -puN mm/proc_mm.c~skas-leak-fix mm/proc_mm.c
--- vanilla-linux-2.6.7-SKAS/mm/proc_mm.c~skas-leak-fix	2004-07-19 20:32:22.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c	2004-07-21 18:41:31.330214752 +0200
@@ -12,6 +12,7 @@
 #include "asm/mmu_context.h"
 
 static struct file_operations proc_mm_fops;
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm);
 
 struct mm_struct *proc_mm_get_mm(int fd)
 {
@@ -93,7 +94,9 @@ static ssize_t write_proc_mm(struct file
 			break;
 		}
 
-		__init_new_context(mm, from);
+		ret = copy_context(mm, from);
+		if(ret == 0)
+			ret = count;
 		break;
 	}
 	default:
diff -puN include/asm-i386/mmu_context.h~skas-leak-fix include/asm-i386/mmu_context.h
_

--Boundary-00=_fXAABjxTelsD6d1--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
