Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bgoz4-0005bx-Fr for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 11:11:30 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bgoz3-0001Ws-J2 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 11:11:30 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit
References: <40E0036D.2070108@sysgo.de> <40E45092.7050106@sysgo.de>
	<200407012133.16289.blaisorblade_spam@yahoo.it>
In-Reply-To: <200407012133.16289.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wov5A627XdmWqTe"
Message-Id: <200407032025.52944.blaisorblade_spam@yahoo.it>
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
Date: Sat, 3 Jul 2004 20:25:52 +0200
To: Alex =?iso-8859-15?q?Z=FCpke?= <azu@sysgo.de>, user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_wov5A627XdmWqTe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alle 21:33, gioved=EC 1 luglio 2004, BlaisorBlade ha scritto:
> Maybe you are right, and there should be some more fixes. But could you
> explain me if there is any valid reason for maybe_map to behave that way?
> It seems wrong to me, but I would wonder from it not causing bugs. But in
> fact is_user was not used by handle_page_fault, so we could just correct
> maybe_map(). Do you agree?
>
> However if you can build a test program, that could be useful (one which
> requires UML to dereference a pointer, so calling copy_*_user.) Maybe I'll
> write one myself.
>
> > Maybe Jeff remembers the intention of this panic,
> > because the whole
> >
> > 	if(page =3D=3D (unsigned long) current + PAGE_SIZE)
> > 		panic("Kernel stack overflow");
> >
> > does not make any sense for me when checking user VMAs
>
> It's obvious that it does not make sense for user faults. In fact, that
> code is called both for user and for kernel faults; and the !is_user chec=
ks
> expresses exactly your sentence. If you mean that the check for a kernel
> stack overflow is wrong, you may be right.

> > On Linux 2.4.xx with 8k stacks, current+PAGE_SIZE is the upper
> > page of the kernel stack and always valid in kernel address space

Well, after replacing PAGE_SIZE with THREAD_SIZE, I remembered that the sta=
ck=20
grows downward. I checked inside the fork() code (at copy_thread) that=20
current (or current_thread in 2.6) is at the bottom of the stack, which goe=
s=20
down from (long) current + 2 * PAGE_SIZE to (long) current. So the overflow=
=20
happens when address < current_thread (or address < current).

So, this is the attached patch I propose (the test program is included beca=
use=20
I will not rebuild it afterwards, to send it to Jeff; I have tons of=20
patches).
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_wov5A627XdmWqTe
Content-Type: text/x-diff; charset="iso-8859-1";
	name="check_is_user_before_panic.patch"
Content-Disposition: inline; filename="check_is_user_before_panic.patch"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	i63IC7uq012803


From: Alex Z=FCpke <azu@sysgo.de>, and me
SKAS mode is like 4G/4G (here we have actually 3G/3G) for guest processes=
,
so when checking for kernel stack overflow, we must first make sure
we are checking a kernel-space address.
Also, correctly test for stack overflows (i.e. check if there is less
than 1k of stack left; see arch/i386/kernel/irq.c:do_IRQ()).
And also, THREAD_SIZE !=3D PAGE_SIZE * 2, in general (though
this setting is almost never changed, so we didn't notice this1).
Thanks to the good eye of Alex Z=FCpke <azu@sysgo.de> for first seeing th=
is bug,
and providing a test program:


/*
 * trigger.c - triggers panic("Kernel stack overflow") in UML
 *
 * 20040630, azu@sysgo.de
 */

#include <stdio.h>
#include <setjmp.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>

#define LOW  0xa0000000
#define HIGH 0xb0000000

int main(int argc, char **argv)
{
	unsigned long addr;
	int fd;

	fd =3D open("/dev/zero", O_RDWR);

	printf("This may take some time ... one more cup of coffee ...\n");

	for(addr =3D LOW; addr < HIGH; addr +=3D 0x1000)
	{
		pid_t p;
		if(mmap((void*)addr, 0x1000, PROT_READ, MAP_SHARED | MAP_FIXED, fd, 0) =
=3D=3D MAP_FAILED)
			printf("mmap failed\n");

		p =3D fork();
		if(p =3D=3D -1)
			printf("fork failed\n");

		if(p =3D=3D 0)
		{
			/* child context */
			int *p =3D (int *)addr;
			volatile int x;

			x =3D *p;
			return 0;
		}
		/* father context */
		waitpid(p, 0, 0);

		if(munmap((void*)addr, 0x1000) =3D=3D -1)
			printf("munmap failed\n");
	}

	close(fd);
	printf("done\n");
}

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it=
>
---

 uml-linux-2.6.7-paolo/arch/um/kernel/process_kern.c |    2 +-
 uml-linux-2.6.7-paolo/arch/um/kernel/skas/uaccess.c |    2 +-
 uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~check_is_user_before_panic arch/um/k=
ernel/trap_kern.c
--- uml-linux-2.6.7/arch/um/kernel/trap_kern.c~check_is_user_before_panic=
	2004-06-30 21:34:05.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c	2004-07-03 17:53:23.=
637305256 +0200
@@ -54,7 +54,7 @@ int handle_page_fault(unsigned long addr
 	if(is_write && !(vma->vm_flags & VM_WRITE))=20
 		goto out;
 	page =3D address & PAGE_MASK;
-	if(page =3D=3D (unsigned long) current_thread + PAGE_SIZE)
+	if(address < (unsigned long) current_thread + 1024 && !is_user)
 		panic("Kernel stack overflow");
 	pgd =3D pgd_offset(mm, page);
 	pmd =3D pmd_offset(pgd, page);
diff -puN arch/um/kernel/skas/uaccess.c~check_is_user_before_panic arch/u=
m/kernel/skas/uaccess.c
--- uml-linux-2.6.7/arch/um/kernel/skas/uaccess.c~check_is_user_before_pa=
nic	2004-07-02 12:55:21.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/skas/uaccess.c	2004-07-02 13:01:=
11.000000000 +0200
@@ -25,7 +25,7 @@ static unsigned long maybe_map(unsigned=20
 	int dummy_code;
=20
 	if(IS_ERR(phys) || (is_write && !pte_write(pte))){
-		err =3D handle_page_fault(virt, 0, is_write, 0, &dummy_code);
+		err =3D handle_page_fault(virt, 0, is_write, 1, &dummy_code);
 		if(err)
 			return(0);
 		phys =3D um_virt_to_phys(current, virt, NULL);
diff -puN arch/um/kernel/process_kern.c~check_is_user_before_panic arch/u=
m/kernel/process_kern.c
--- uml-linux-2.6.7/arch/um/kernel/process_kern.c~check_is_user_before_pa=
nic	2004-07-03 16:41:39.473637592 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/process_kern.c	2004-07-03 17:53:=
21.867574296 +0200
@@ -165,7 +165,7 @@ int copy_thread(int nr, unsigned long cl
 {
 	p->thread =3D (struct thread_struct) INIT_THREAD;
 	p->thread.kernel_stack =3D=20
-		(unsigned long) p->thread_info + 2 * PAGE_SIZE;
+		(unsigned long) p->thread_info + THREAD_SIZE;
 	return(CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr,=20
 				clone_flags, sp, stack_top, p, regs));
 }
_

--Boundary-00=_wov5A627XdmWqTe--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
