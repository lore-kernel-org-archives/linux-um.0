Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfNFj-0006Cj-CK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:22:43 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BfNFh-00020Q-Em for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:22:43 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Patch for arch/um/kernel/trap_kern.c to fix bad panic
References: <40E0036D.2070108@sysgo.de>
In-Reply-To: <40E0036D.2070108@sysgo.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406291604.51726.blaisorblade_spam@yahoo.it>
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
Date: Tue, 29 Jun 2004 20:34:44 +0200
Content-Transfer-Encoding: quoted-printable
To: azu <azu@sysgo.de>, user-mode-linux-devel@lists.sourceforge.net

Alle 13:39, luned=EC 28 giugno 2004, azu ha scritto:
> Hi,

> I triggered the following panic from userspace in skas mode
> by mapping pages above 0xa0000000 ...

> The check is useless in skas-mode (kernel faults get filtered
> in segv() before handle_page_fault() is called),
> so I added an ifdef for tt mode.

This is a more sensible version of the patch (with runtime checking instead=
=20
that compile time), if I did not overlook anything: it must be an if(mode_t=
t).=20
I always compile in TT mode and normally don't use it (and sometimes UML do=
es=20
not compile otherwise), and the patch must still work.


However, I don't think this is the proper fix: please elaborate a bit more.=
=20
Segv() works the same way under TT and SKAS, and I think that more likely=20
there were an actual stack overflow (try to increase=20
CONFIG_KERNEL_STACK_ORDER and try to re-get the panic).

diff -puN arch/um/kernel/trap_kern.c~silly_panic arch/um/kernel/trap_kern.c
--- uml-linux-2.6.7/arch/um/kernel/trap_kern.c~silly_panic	2004-06-28=20
21:42:06.025387464 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/trap_kern.c	2004-06-28=20
21:43:47.676934080 +0200
@@ -54,8 +54,10 @@ int handle_page_fault(unsigned long addr
 	if(is_write && !(vma->vm_flags & VM_WRITE))=20
 		goto out;
 	page =3D address & PAGE_MASK;
-	if(page =3D=3D (unsigned long) current_thread + PAGE_SIZE)
-		panic("Kernel stack overflow");
+	if (mode_tt) {
+		if(page =3D=3D (unsigned long) current_thread + PAGE_SIZE)
+			panic("Kernel stack overflow");
+	}
 	pgd =3D pgd_offset(mm, page);
 	pmd =3D pmd_offset(pgd, page);
 	do {

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
