Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtqBp-0006hY-43 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 08:38:45 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CtqBn-0007xW-I0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 08:38:45 -0800
Message-ID: <41F7C963.9080704@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050300040704030103040604"
Subject: [uml-devel] UML running on a SMP host: bug in SKAS3 patch
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
Date: Wed, 26 Jan 2005 17:46:27 +0100
To: Jeff Dike <jdike@addtoit.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050300040704030103040604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Description: see patch.

Bodo

--------------050300040704030103040604
Content-Type: text/x-diff;
 name="host-2.6.9-skas3.v7-smp-fix-ldt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="host-2.6.9-skas3.v7-smp-fix-ldt.patch"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

The SKAS3 host patch isn't smp-safe.

The wrong part is the implementation of PTRACE_LDT.
If the ptraced child runs on an other processor than its parent,
and the child's mm still is the active_mm, the changed LDT
isn't flushed out.
The problem occurs in alloc_ldt, but to fix this, I had to
change the params of copy_ldt, too.

---

--- a/arch/i386/kernel/ldt.c	2005-01-26 15:35:44.000000000 +0100
+++ b/arch/i386/kernel/ldt.c	2005-01-26 16:57:54.000000000 +0100
@@ -28,11 +28,12 @@ static void flush_ldt(void *null)
 }
 #endif
 
-static int alloc_ldt(mm_context_t *pc, int mincount, int reload)
+static int alloc_ldt(struct mm_struct *mm, int mincount, int reload)
 {
 	void *oldldt;
 	void *newldt;
 	int oldsize;
+	mm_context_t * pc = &mm->context;
 
 	if (mincount <= pc->size)
 		return 0;
@@ -55,17 +56,19 @@ static int alloc_ldt(mm_context_t *pc, i
 	pc->size = mincount;
 	wmb();
 
-	if (reload && (&current->active_mm->context == pc)) {
+	if (reload) {
 #ifdef CONFIG_SMP
 		cpumask_t mask;
 		preempt_disable();
-		load_LDT(pc);
+		if (&current->active_mm->context == pc)
+			load_LDT(pc);
 		mask = cpumask_of_cpu(smp_processor_id());
-		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
+		if (!cpus_equal(mm->cpu_vm_mask, mask))
 			smp_call_function(flush_ldt, NULL, 1, 1);
 		preempt_enable();
 #else
-		load_LDT(pc);
+		if (&current->active_mm->context == pc)
+			load_LDT(pc);
 #endif
 	}
 	if (oldsize) {
@@ -77,12 +80,12 @@ static int alloc_ldt(mm_context_t *pc, i
 	return 0;
 }
 
-static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
+static inline int copy_ldt(struct mm_struct *new, struct mm_struct *old)
 {
-	int err = alloc_ldt(new, old->size, 0);
+	int err = alloc_ldt(new, old->context.size, 0);
 	if (err < 0)
 		return err;
-	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+	memcpy(new->context.ldt, old->context.ldt, old->context.size*LDT_ENTRY_SIZE);
 	return 0;
 }
 
@@ -96,7 +99,7 @@ int copy_context(struct mm_struct *mm, s
 
 	if (old_mm && old_mm->context.size > 0) {
 		down(&old_mm->context.sem);
-		retval = copy_ldt(&mm->context, &old_mm->context);
+		retval = copy_ldt(mm, old_mm);
 		up(&old_mm->context.sem);
 	}
 	return retval;
@@ -202,7 +205,7 @@ static int write_ldt(struct mm_struct * 
 
 	down(&mm->context.sem);
 	if (ldt_info.entry_number >= mm->context.size) {
-		error = alloc_ldt(&mm->context, ldt_info.entry_number+1, 1);
+		error = alloc_ldt(mm, ldt_info.entry_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}

--------------050300040704030103040604--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
