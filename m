Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmcZp-0001er-8v for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 11:09:25 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BmcZo-0003gq-EH for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 11:09:25 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: I'm back - glibc LDT handling (was: Re: [uml-devel] I'm out for some
	time - SKAS host leak diagnosis.)
References: <200407081804.40148.blaisorblade_spam@yahoo.it>
In-Reply-To: <200407081804.40148.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QvA/ANORUZ+X27Q"
Message-Id: <200407191958.40012.blaisorblade_spam@yahoo.it>
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
Date: Mon, 19 Jul 2004 19:58:39 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_QvA/ANORUZ+X27Q
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 18:04, gioved=EC 8 luglio 2004, BlaisorBlade ha scritto:
> 1) From 9 to 18 July, I'll be away for study=20
Ok, I'm back. And glad to see the release of 2.4.26-2um.

> 2) Especially, I'm near to fixing the host SKAS leak... seems like it's a
> race condition when calling alloc_ldt(): one of the two values is
> overwritten by the other, and so never freed. In fact for each mm
> init_new_context() is called when open()ing it, while __init_new_context()
> is called when writing a MM_COPY_SEGMENTS request onto /proc/mm (which
> happens shortly after). The mm->context is not locked anyway, and this is=
 a
> SKAS bug: it makes sense in mainline, but not when using SKAS. The strange
> thing is that on host/kernel configurations where it happens, it is
> repeatable, i.e. does not seem a race condition. However the locking must
> be anyway added.

I've attached the patch, but I've not had time to even compile one kernel w=
ith=20
it. However try it if you want: it's for 2.6 and probably works for 2.4.

Ok, the problem is the double call, but it is not a race condition: when=20
calling again __init_new_context, we do mm->context.size =3D 0, so alloc_ld=
t=20
does not free mm->context.ldt. Much simpler. While the race condition is=20
impossible (it is the same thread to open /proc/mm and to write the=20
MM_COPY_SEGMENTS request).

And it did not happen before 2.4.25 because there was no clearing of=20
mm->context.size (it did not exist). There is another strange thing: why th=
e=20
leak does not happen everywhere? To actually have an LDT to allocate, the U=
ML=20
host thread calling new_mm() must have an LDT with size !=3D 0, which will =
then=20
be inherited by every UML thread: I do not think this is nice, and it's=20
unwanted since UML assumes that a kernel thread has not an LDT, see the=20
current->mm !=3D NULL check in new_mm(); I think this can only come from gl=
ibc=20
(for instance to support TLS).

Anyway, that is the problem. And the locking is not the solution (deadlock=
=20
risk): simply it does not make sense to call twice init_new_context(),=20
because after the first time the context is old. I've avoided to add lockin=
g=20
because I fear deadlocks (I would need to lock both the old and the new=20
context) and because the old code worked fine without adding locks; anyway,=
=20
there is no chance that a proper UML can cause a race onto the new LDT; but=
=20
if a process wants to, it can. The fix would be very simple: lock the old=20
context, copy its LDT to a bounce buffer, unlock it, and copy the bounce=20
buffer to the new context under locking; but I don't like this. Maybe it=20
could be deadlock-free to take the old_mm lock and after the new_mm one (it=
's=20
impossible that another process does the reverse copy, or not?)

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_QvA/ANORUZ+X27Q
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
 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ldt.c |   18 +++++++++++++++---
 vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c           |    3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/ldt.c~skas-leak-fix arch/i386/kernel/ldt.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/ldt.c~skas-leak-fix	2004-07-19 13:52:46.439670608 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ldt.c	2004-07-19 13:52:46.444669848 +0200
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
@@ -103,9 +105,19 @@ int __init_new_context(struct mm_struct 
 	return retval;
 }
 
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int copy_context(struct mm_struct *mm, struct mm_struct *old_mm)
 {
-	return __init_new_context(mm, current->mm);
+	int err;
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
--- vanilla-linux-2.6.7-SKAS/mm/proc_mm.c~skas-leak-fix	2004-07-19 13:52:46.441670304 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/mm/proc_mm.c	2004-07-19 13:52:46.445669696 +0200
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
+		copy_ldt(mm, from);
 		break;
 	}
 	default:
diff -puN include/asm-i386/mmu_context.h~skas-leak-fix include/asm-i386/mmu_context.h
_

--Boundary-00=_QvA/ANORUZ+X27Q--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
