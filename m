Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuHjk-0007qs-42 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 12:59:04 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AuHdh-00013D-FI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 12:52:49 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] skas3 for x86_64 arch
References: <1077305069.8412.62.camel@wopr.tektonic.net>
In-Reply-To: <1077305069.8412.62.camel@wopr.tektonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200402202155.44773.blaisorblade_spam@yahoo.it>
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
Date: Fri, 20 Feb 2004 21:55:44 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Matt Ayres <matta@tektonic.net>

Alle 20:24, venerd=EC 20 febbraio 2004, Matt Ayres ha scritto:
> Hi,
>
> I just did a quick port of the skas3 patch to the x86_64 architecture.
> Everything seems very straightforward except for the do_mmap2 function.

Sorry, but you've changed the prototype of sys32_mmap2 by adding the mm=20
parameter (which goes only on do_mmap2). So it cannot possibly compile.

-asmlinkage long sys32_mmap2(unsigned long addr, unsigned long len,
+/* common code for old and new mmaps */
+static inline long do_mmap2(struct mm_struct *mm,
+unsigned long addr, unsigned long len,
 unsigned long prot, unsigned long flags,
 unsigned long fd, unsigned long pgoff)

+
+asmlinkage long sys32_mmap2(struct mm_struct *mm,
+unsigned long addr, unsigned long len,
+unsigned long prot, unsigned long flags,
+unsigned long fd, unsigned long pgoff)
+{
+return do_mmap2(addr, len, prot, flags, fd, pgoff);
+}
+

Apart for this, I did not see anything strange (but I give a *very* quick=20
look, i.e. 1 minute, so I'm not sure).
> I don't have a x86_64 machine or an emulator so I can't even verify this
> even compiles.

Have you tried a cross build with make ARCH=3Dx86_64 ? I'm not sure if that=
 can=20
work or requires cross-compilators, but maybe not.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
