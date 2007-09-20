Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IYOTx-0003mx-Mx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Sep 2007 09:02:26 -0700
Received: from hu-out-0506.google.com ([72.14.214.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IYOTv-0007fq-TI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Sep 2007 09:02:25 -0700
Received: by hu-out-0506.google.com with SMTP id 28so198819hub
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 20 Sep 2007 09:02:21 -0700 (PDT)
From: Paolo Giarrusso <p.giarrusso@gmail.com>
Date: Thu, 20 Sep 2007 17:57:49 +0200
References: <20070918233336.GA9746@c2.user-mode-linux.org>
	<20070918170733.c6399124.akpm@linux-foundation.org>
In-Reply-To: <20070918170733.c6399124.akpm@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <200709201757.56298.p.giarrusso@gmail.com>
Subject: Re: [uml-devel] [PATCH] UML - Fix irqstack crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1270938352=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

--===============1270938352==
Content-Type: multipart/signed; boundary="nextPart2030797.6NMYVez0Iz";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2030797.6NMYVez0Iz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On mercoled=EC 19 settembre 2007, Andrew Morton wrote:
> On Tue, 18 Sep 2007 19:33:36 -0400

> Jeff Dike <jdike@addtoit.com> wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.17.orig/arch/um/os-Linux/signal.c	2007-09-09
> > 11:15:37.000000000 -0400 +++
> > linux-2.6.17/arch/um/os-Linux/signal.c	2007-09-18 12:32:40.000000000
> > -0400 @@ -119,7 +119,7 @@ void (*handlers[_NSIG])(int sig, struct
> >
> >  void handle_signal(int sig, struct sigcontext *sc)
> >  {
> > -	unsigned long pending =3D 0;
> > +	unsigned long pending =3D 1 << sig;

> You want 1UL there.

Yes, indeed - or sign extension on 64bit machines would set to 1 the whole=
=20
high-word.

But using long for that mask makes no difference; either int or long long (=
or=20
better, either u32 or u64) should be used, given that the used signal range=
=20
is the same on 32 and 64bit machines, it should be u32 for normal signals o=
r=20
u64 if RT-signals are also allowed.
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade

--nextPart2030797.6NMYVez0Iz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8piEqH9OHC+5NscRAs9jAJ9A8jx+Kx7LzlBhP0OsL44zJXOqUQCglWd1
SKH9UDp1KoPo83uOoDGJH0w=
=Xb72
-----END PGP SIGNATURE-----

--nextPart2030797.6NMYVez0Iz--


--===============1270938352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1270938352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1270938352==--

