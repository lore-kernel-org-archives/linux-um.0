Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg4ku-0008Ec-PY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:49:48 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bg4ku-0006Dy-56 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:49:48 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit
References: <40E0036D.2070108@sysgo.de>
	<200406291604.51726.blaisorblade_spam@yahoo.it>
	<40E29034.7040504@sysgo.de>
In-Reply-To: <40E29034.7040504@sysgo.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406302144.32539.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 1 Jul 2004 15:34:42 +0200
Content-Transfer-Encoding: quoted-printable
To: azu <azu@sysgo.de>, user-mode-linux-devel@lists.sourceforge.net

Alle 12:04, mercoled=EC 30 giugno 2004, azu ha scritto:
> Due to "overlapping" address spaces in skas mode,
> it is possible to trigger the panic:

Yes, there are distinct address spaces; I was first confused by=20
"overlapping", but now I understand.

> A userpage with the same address as current + 4096
> must be valid in the vma, but not (yet) mapped to
> the user:
> 0) addr =3D 0xa0000000
> 1) mmap a zero page to addr (valid vma) readwrite
> 2) fork -> mapping is now readonly
> 3) child writes to page
> 4) IF addr =3D=3D current + 4096 THEN panic
> 5) addr +=3D 4096
> 6) goto 1)
>
> I wrote a small demo app to trigger the problem.
> Limit your UML memory to 16MB or so to trigger the panic faster.

Ok... now I understand. The panic must be left there, but only if the addre=
ss=20
was accessed by kernel-space. Thanks for the analisys and the test-case.

Please try the attached fix; I run your trigger.c (statically linked on the=
=20
host) and it panicked without this patch and ran fine with it applied.

Test this patch, please:

SKAS mode is like 4G/4G (here we have actually 3G/3G) for guest processes,
so when checking for kernel stack overflow, we must first make sure
we are checking a kernel-space address.

Signed-off-by: <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/trap_kern.c~check_is_user_before_panic=20
arch/um/kernel/trap_kern.c
--- uml-linux-2.6.7/arch/um/kernel/trap_kern.c~check_is_user_before_panic=09
2004-06-30 21:27:59.640300880 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c	2004-06-30=20
21:28:04.043631472 +0200
@@ -54,7 +54,7 @@ int handle_page_fault(unsigned long addr
 	if(is_write && !(vma->vm_flags & VM_WRITE))=20
 		goto out;
 	page =3D address & PAGE_MASK;
-	if(page =3D=3D (unsigned long) current_thread + PAGE_SIZE)
+	if(page =3D=3D (unsigned long) current_thread + PAGE_SIZE && !is_user)
 		panic("Kernel stack overflow");
 	pgd =3D pgd_offset(mm, page);
 	pmd =3D pmd_offset(pgd, page);


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
