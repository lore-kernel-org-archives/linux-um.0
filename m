Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ij31h-0003rX-5d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Oct 2007 18:21:17 -0700
Received: from mu-out-0910.google.com ([209.85.134.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ij31f-000523-G6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Oct 2007 18:21:17 -0700
Received: by mu-out-0910.google.com with SMTP id w9so754726mue
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 19 Oct 2007 18:21:13 -0700 (PDT)
From: Paolo Giarrusso <p.giarrusso@gmail.com>
Date: Sat, 20 Oct 2007 02:52:30 +0200
References: <200710111754.46854.rob@landley.net>
In-Reply-To: <200710111754.46854.rob@landley.net>
MIME-Version: 1.0
Message-Id: <200710200252.37919.p.giarrusso@gmail.com>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0070486859=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>

--===============0070486859==
Content-Type: multipart/signed; boundary="nextPart1923931.iimlfsJiGH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1923931.iimlfsJiGH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On venerd=C3=AC 12 ottobre 2007, Rob Landley wrote:
> [Second try, without clicking "compress" on the file attachment because
> then sourceforge's spam filter bounces it.]
>
> ---
>
> The User Mode Linux build still breaks for me:
> > In file included from include/asm/arch/tlb.h:18,
> >                  from include/asm/tlb.h:4,
> >                  from arch/um/kernel/smp.c:8:
> > include/asm-generic/tlb.h: In function =E2=80=98tlb_flush_mmu=E2=80=99:
> > include/asm-generic/tlb.h:76: error: implicit declaration of function
> > =E2=80=98release_pages=E2=80=99 include/asm-generic/tlb.h: In function =
=E2=80=98tlb_remove_page=E2=80=99:
> > include/asm-generic/tlb.h:105: error: implicit declaration of function
> > =E2=80=98page_cache_release=E2=80=99 make[1]: *** [arch/um/kernel/smp.o=
] Error 1
> > make: *** [arch/um/kernel] Error 2
>
> I submitted the following patch to fix it to the UML list after 2.6.23-rc=
3:
> http://sourceforge.net/mailarchive/forum.php?thread_name=3D200708212148.0=
5392
>.rob%40landley.net&forum_name=3Duser-mode-linux-devel
>
> On september 4, I confirmed that I still needed it to build -rc5:
> http://sourceforge.net/mailarchive/message.php?msg_name=3D200709040737.54=
516.
>rob%40landley.net
>
> Guess what?  I still need this patch to build the final 2.6.23, months
> later.
>
> I know it may not be the right fix, but the build breaks for me without
> this patch. The .config that breaks is attached.  ARCH=3Dum.

Guess most people are not using SMP right now, and that the error disappear=
s=20
without that setting - I'm being away for a long while, has SKAS+SMP suppor=
t=20
been merged?

However, a quick look at my sources tells otherwise, and git-describe says=
=20
that's a v2.6.23-rc6-239-gc2f8289 tree.

So I've no idea...

> ----------  Forwarded Message  ----------
>
> Subject: [uml-devel] UML doesn't build in 2.6.23-rc3.
> Date: Tuesday 21 August 2007
> From: Rob Landley <rob@landley.net>
> To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
>
> I fixed it for me with the following patch, just in case anybody else had
> this problem:
>
> --- linux-2.6.23-rc3/arch/um/kernel/smp.c	2007-08-12 23:25:24.000000000
> -0500 +++ linux-2.6.23-new/arch/um/kernel/smp.c	2007-08-21
> 21:39:00.000000000 -0500 @@ -5,6 +5,7 @@
>
>  #include "linux/percpu.h"
>  #include "asm/pgalloc.h"
> +#include "linux/pagemap.h"
>  #include "asm/tlb.h"
>
>  /* For some reason, mmu_gathers are referenced when CONFIG_SMP is off. */



=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade

--nextPart1923931.iimlfsJiGH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHGVFVqH9OHC+5NscRApw7AJ4pAmlrd5TMKVJltdapJPEPJMTxFACfZdRQ
33YnW2NpyjJDEVB0X30eQDg=
=N3iT
-----END PGP SIGNATURE-----

--nextPart1923931.iimlfsJiGH--


--===============0070486859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0070486859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0070486859==--

