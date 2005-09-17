Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGeqn-0005nl-O3	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 08:43:37 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EGeqj-0007TV-Eb
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 08:43:37 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Fixed - copy_from_user(dest, -1,...) hangs in TT mode (was: Re:
	[uml-devel] weak check of access_ok may lead hang!)
References: <20050916104057.77345.qmail@mail35-142.sinamail.sina.com.cn>
In-Reply-To: <20050916104057.77345.qmail@mail35-142.sinamail.sina.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MeDLDBRnxQTqK6C"
Message-Id: <200509171734.36738.blaisorblade@yahoo.it>
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
Date: Sat, 17 Sep 2005 17:34:36 +0200
To: luothing@sina.com
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

--Boundary-00=_MeDLDBRnxQTqK6C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 16 September 2005 12:40, luothing@sina.com wrote:
> <pre>
> Hi, Blaisorblade:

>     I have spend some time to test recent uml 2.6.13, and find that
> recent uml have improved at some aspect, but still have some potential
> problem at syscall, mainly because weakly check, the attchement
> include my test result, also some general reason, please check it.

Ok, I've verified the result you described (with the old 20041104 release, but 
the tests you mention either had the same problems or didn't exist in that 
release), and debugged it (yes, in TT mode, with GDB 6.3, which was quite a 
surprise since GDB hasn't been working for that - it seems that my fix for 
SKAS mode, i.e. disabling the early execve(), fixes this too - I'll check 
this now).

Patches are attached against 2.6.13 - apply uml-fault-micro-cleanups before 
the rest. They'll be all included in 2.6.13-bs1. Btw, what's your name? I'd 
like to credit you in the changelog.

I also fixed the modify_ldt01 problem (trivial missing break;), and 
modify_ldt02 doesn't create host problems here (but it's an older release) - 
it just doesn't work in SKAS0 (which is expectable right now, since we use 
the unimplemented PTRACE_LDT, but will be fixed), I already fixed mprotect02 
previously (not yet committed).

The problem I found is that on general protection faults (not page faults) 
from kernel space, we forget to handle the particular case (we refuse to take 
GPF for userspace, but forget for kernelspace). And when you pass -1, it 
gives a protection fault (either because it reads 0 or because it exceeds the 
segment limits).

And we instead use the CR2 from host (which, for general protection faults, is 
undefined) and try to fix a page fault on it.

Since that address is mapped (it was there from a previous page fault, 
probably), we "succeed" and finish the handling, the instruction is retried 
and we fail.

The same thing would happen in SKAS mode too, but in SKAS mode we walk first 
the pagetables, and access_ok disallows this from the very beginning.

In fact, beyond this problem, we also fail to check whether the faulting 
address is under TASK_SIZE in TT mode on read accesses:

#define access_ok_tt(type, addr, size) \
        ((type == VERIFY_READ) || (segment_eq(get_fs(), KERNEL_DS)) || \
         (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
          (under_task_size(addr, size) || is_stack(addr, size))))

See "(type == VERIFY_READ) || "do some real testing"? That's totally bogus.

Jeff, what's that for? Not only the user can read on its own from kernel 
memory, we turn that into a feature and allow that as syscall parameter too? 
Waiting for an answer before fixing.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_MeDLDBRnxQTqK6C
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-handle-generalprotfault"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-handle-generalprotfault"

Index: linux-2.6.13/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/trap_kern.c
+++ linux-2.6.13/arch/um/kernel/trap_kern.c
@@ -18,6 +18,7 @@
 #include "asm/a.out.h"
 #include "asm/current.h"
 #include "asm/irq.h"
+#include "sysdep/sigcontext.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
@@ -126,7 +127,15 @@ unsigned long segv(struct faultinfo fi, 
         }
 	else if(current->mm == NULL)
 		panic("Segfault with no mm");
-	err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
+
+	if (SEGV_IS_FIXABLE(&fi))
+		err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
+	else {
+		err = -EFAULT;
+		/* A thread accessed NULL, we get a fault, but CR2 is invalid.
+		 * This code is used in __do_copy_from_user() of TT mode. */
+		address = 0;
+	}
 
 	catcher = current->thread.fault_catcher;
 	if(!err)
Index: linux-2.6.13/arch/um/kernel/tt/uaccess_user.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/tt/uaccess_user.c
+++ linux-2.6.13/arch/um/kernel/tt/uaccess_user.c
@@ -22,8 +22,15 @@ int __do_copy_from_user(void *to, const 
 			       __do_copy, &faulted);
 	TASK_REGS(get_current())->tt = save;
 
-	if(!faulted) return(0);
-	else return(n - (fault - (unsigned long) from));
+	if(!faulted)
+		return 0;
+	else if (fault)
+		return n - (fault - (unsigned long) from);
+	else
+		/* In case of a general protection fault, we don't have the
+		 * fault address, so NULL is used instead. Pretend we didn't
+		 * copy anything. */
+		return n;
 }
 
 static void __do_strncpy(void *dst, const void *src, int count)

--Boundary-00=_MeDLDBRnxQTqK6C
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-fix-modify_ldt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-modify_ldt"

uml: missing break in switch
From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I am a lamer :-(. Luckily, somebody ran LTP and found this failure. Btw, the
fact that the patch in which I introduced this was merged shows that:

a) I'm really trusted by people
b) sometimes they're wrong about point a).
c) lack of time somewhere.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.13/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-i386/ldt.c
+++ linux-2.6.13/arch/um/sys-i386/ldt.c
@@ -83,6 +83,7 @@ int sys_modify_ldt(int func, void __user
 			goto out;
 		}
 		p = buf;
+		break;
 	default:
 		res = -ENOSYS;
 		goto out;

--Boundary-00=_MeDLDBRnxQTqK6C
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-fix-fault-handler-on-write"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-fault-handler-on-write"

uml: fix fault handler on write

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The UML fault handler was recently changed to enforce PROT_NONE protections,
by requiring VM_READ or VM_EXEC on VMA's.

However, by mistake, things were changed such that VM_READ is always checked,
also on write faults; so a VMA mapped with only PROT_WRITE is not readable
(unless it's prefaulted with MAP_POPULATE or with a write), which is different
from i386.

Discovered while testing remap_file_pages protection support.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/trap_kern.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -57,7 +57,8 @@ good_area:
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
 
-        if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
+	/* Don't require VM_READ|VM_EXEC for write faults! */
+        if(!is_write && !(vma->vm_flags & (VM_READ | VM_EXEC)))
                 goto out;
 
 	do {

--Boundary-00=_MeDLDBRnxQTqK6C
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-fault-micro-cleanups"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fault-micro-cleanups"

[PATCH] uml: fault handler micro-cleanups

Avoid chomping low bits of address for functions doing it by themselves,
fix whitespace, add a correctness checking.

I did this for remap-file-pages protection support, it was useful on its
own too.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

---
commit 3b52166cf72f0826c6d8fa0541c7d4ae39c5a146
tree 9245ab972eff25c3c9c751f29f135868774067dd
parent 1e40cd383ccc7c9f8b338c56ce28c326e25eb2fe
author Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> sab, 03 set 2005 15:57:26 -0700
committer Linus Torvalds <torvalds@evo.osdl.org> lun, 05 set 2005 00:06:21 -0700

 arch/um/kernel/trap_kern.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -26,6 +26,7 @@
 #include "mem.h"
 #include "mem_kern.h"
 
+/* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
 int handle_page_fault(unsigned long address, unsigned long ip, 
 		      int is_write, int is_user, int *code_out)
 {
@@ -35,7 +36,6 @@ int handle_page_fault(unsigned long addr
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long page;
 	int err = -EFAULT;
 
 	*code_out = SEGV_MAPERR;
@@ -52,7 +52,7 @@ int handle_page_fault(unsigned long addr
 	else if(expand_stack(vma, address)) 
 		goto out;
 
- good_area:
+good_area:
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
@@ -60,9 +60,8 @@ int handle_page_fault(unsigned long addr
         if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
                 goto out;
 
-	page = address & PAGE_MASK;
 	do {
- survive:
+survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){
 		case VM_FAULT_MINOR:
 			current->min_flt++;
@@ -79,16 +78,16 @@ int handle_page_fault(unsigned long addr
 		default:
 			BUG();
 		}
-		pgd = pgd_offset(mm, page);
-		pud = pud_offset(pgd, page);
-		pmd = pmd_offset(pud, page);
-		pte = pte_offset_kernel(pmd, page);
+		pgd = pgd_offset(mm, address);
+		pud = pud_offset(pgd, address);
+		pmd = pmd_offset(pud, address);
+		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
 	*pte = pte_mkyoung(*pte);
 	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
-	flush_tlb_page(vma, page);
- out:
+	flush_tlb_page(vma, address);
+out:
 	up_read(&mm->mmap_sem);
 	return(err);
 
@@ -144,19 +143,18 @@ unsigned long segv(struct faultinfo fi, 
 		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx", 
 		      address, ip);
 
-	if(err == -EACCES){
+	if (err == -EACCES) {
 		si.si_signo = SIGBUS;
 		si.si_errno = 0;
 		si.si_code = BUS_ADRERR;
 		si.si_addr = (void *)address;
                 current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGBUS, &si, current);
-	}
-	else if(err == -ENOMEM){
+	} else if (err == -ENOMEM) {
 		printk("VM: killing process %s\n", current->comm);
 		do_exit(SIGKILL);
-	}
-	else {
+	} else {
+		BUG_ON(err != -EFAULT);
 		si.si_signo = SIGSEGV;
 		si.si_addr = (void *) address;
                 current->thread.arch.faultinfo = fi;

--Boundary-00=_MeDLDBRnxQTqK6C--


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
