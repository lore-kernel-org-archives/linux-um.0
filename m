Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bmd8W-00088m-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 11:45:16 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bmd8V-0002Sw-N4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 11:45:16 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: I'm back - glibc LDT handling (was: Re: [uml-devel] I'm out for
	some time - SKAS host leak diagnosis.)
References: <200407081804.40148.blaisorblade_spam@yahoo.it>
	<200407191958.40012.blaisorblade_spam@yahoo.it>
In-Reply-To: <200407191958.40012.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jbB/AZokiYUfUZm"
Message-Id: <200407192045.55420.blaisorblade_spam@yahoo.it>
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
Date: Mon, 19 Jul 2004 20:45:55 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_jbB/AZokiYUfUZm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry for the patch: the new one should make more sense (it compiles, but be 
careful with it). Anyway, you can still wait for it, for now...

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_jbB/AZokiYUfUZm
Content-Type: text/x-diff; charset="iso-8859-1"; name="skas-leak-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="skas-leak-fix.patch"


init_new_context was called, and then __init_new_context; they both clear
the LDT (by setting its size to 0) and alloc a new one; and since the LDT size
has been cleared, alloc_ldt does not free() the LDT. It it exposed only if actually
the UML process has an LDT to allocate, i.e. if the UML kernel thread had an LDT
on the host when forking the init process.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 include/asm-i386/mmu_context.h                        |    0 
 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ldt.c |   21 +++++++++++++++---
 vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c           |    3 +-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/ldt.c~skas-leak-fix arch/i386/kernel/ldt.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/ldt.c~skas-leak-fix	2004-07-19 20:32:22.774713648 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ldt.c	2004-07-19 20:37:08.394292872 +0200
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
--- vanilla-linux-2.6.7-SKAS/mm/proc_mm.c~skas-leak-fix	2004-07-19 20:32:22.776713344 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c	2004-07-19 20:39:17.131721808 +0200
@@ -12,6 +12,7 @@
 #include "asm/mmu_context.h"
 
 static struct file_operations proc_mm_fops;
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm);
 
 struct mm_struct *proc_mm_get_mm(int fd)
 {
@@ -93,7 +94,7 @@ static ssize_t write_proc_mm(struct file
 			break;
 		}
 
-		__init_new_context(mm, from);
+		ret = copy_context(mm, from);
 		break;
 	}
 	default:
diff -puN include/asm-i386/mmu_context.h~skas-leak-fix include/asm-i386/mmu_context.h
_

--Boundary-00=_jbB/AZokiYUfUZm--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
