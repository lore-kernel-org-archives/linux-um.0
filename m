Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg75R-0004vW-L7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 12:19:09 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bg75R-0002wl-1B for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 12:19:09 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit
References: <40E0036D.2070108@sysgo.de>
	<200406302144.32539.blaisorblade_spam@yahoo.it>
	<40E45092.7050106@sysgo.de>
In-Reply-To: <40E45092.7050106@sysgo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407012133.16289.blaisorblade_spam@yahoo.it>
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
Date: Thu, 1 Jul 2004 21:33:16 +0200
Content-Transfer-Encoding: quoted-printable
To: Alex =?iso-8859-1?q?Z=FCpke?= <azu@sysgo.de>, user-mode-linux-devel@lists.sourceforge.net

Alle 19:57, gioved=EC 1 luglio 2004, Alex Z=FCpke ha scritto:
> >  uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> >
> > diff -puN arch/um/kernel/trap_kern.c~check_is_user_before_panic
> > arch/um/kernel/trap_kern.c
> > --- uml-linux-2.6.7/arch/um/kernel/trap_kern.c~check_is_user_before_pan=
ic
> > 2004-06-30 21:27:59.640300880 +0200
> > +++ uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c	2004-06-30
> > 21:28:04.043631472 +0200
> > @@ -54,7 +54,7 @@ int handle_page_fault(unsigned long addr
> >  	if(is_write && !(vma->vm_flags & VM_WRITE))
> >  		goto out;
> >  	page =3D address & PAGE_MASK;
> > -	if(page =3D=3D (unsigned long) current_thread + PAGE_SIZE)
> > +	if(page =3D=3D (unsigned long) current_thread + PAGE_SIZE && !is_user)
> >  		panic("Kernel stack overflow");
> >  	pgd =3D pgd_offset(mm, page);
> >  	pmd =3D pmd_offset(pgd, page);
>
> Hi Paolo,
>
> checking !is_user might not help, because
> skas/uaccess.c::maybe_map() calls handle_page_fault with is_user =3D 0
> when doing copy_from/to_user stuff ...

Maybe you are right, and there should be some more fixes. But could you=20
explain me if there is any valid reason for maybe_map to behave that way? I=
t=20
seems wrong to me, but I would wonder from it not causing bugs. But in fact=
=20
is_user was not used by handle_page_fault, so we could just correct=20
maybe_map(). Do you agree?

However if you can build a test program, that could be useful (one which=20
requires UML to dereference a pointer, so calling copy_*_user.) Maybe I'll =

write one myself.

> Maybe Jeff remembers the intention of this panic,
> because the whole
>
> 	if(page =3D=3D (unsigned long) current + PAGE_SIZE)
> 		panic("Kernel stack overflow");
>
> does not make any sense for me when checking user VMAs
It's obvious that it does not make sense for user faults. In fact, that cod=
e=20
is called both for user and for kernel faults; and the !is_user checks=20
expresses exactly your sentence. If you mean that the check for a kernel=20
stack overflow is wrong, you may be right.


> On Linux 2.4.xx with 8k stacks, current+PAGE_SIZE is the upper
> page of the kernel stack and always valid in kernel address space
Yes, maybe PAGE_SIZE is wrong (I say maybe until I double and triple check =

everything); About the stack size, that depends on CONFIG_STACK_ORDER on UM=
L:

> and has nothing to do with the userspace VMAs.

About under UML in SKAS mode, like under the 4G/4G kernel patch from Ingo=20
Molnar, both the kernel and the userspace programs have 3G of virtual memor=
y=20
starting at 0.=20

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
