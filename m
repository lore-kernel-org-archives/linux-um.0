Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaZ5g-0004us-Uf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 08:46:28 -0700
Received: from hu-out-0506.google.com ([72.14.214.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaZ5f-0002Qt-SY
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 08:46:20 -0700
Received: by hu-out-0506.google.com with SMTP id 28so1049916hub
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 26 Sep 2007 08:46:18 -0700 (PDT)
From: Paolo Giarrusso <p.giarrusso@gmail.com>
Date: Wed, 26 Sep 2007 17:46:13 +0200
References: <20070925173713.GA8262@c2.user-mode-linux.org>
	<20070925215629.GA10926@c2.user-mode-linux.org>
	<1190758127.17409.81.camel@chaos>
In-Reply-To: <1190758127.17409.81.camel@chaos>
MIME-Version: 1.0
Message-Id: <200709261746.14632.p.giarrusso@gmail.com>
Subject: Re: [uml-devel] [PATCH] UML - time build fix
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0900578236=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

--===============0900578236==
Content-Type: multipart/signed; boundary="nextPart5079317.PVAtiMum5I";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5079317.PVAtiMum5I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On mercoled=EC 26 settembre 2007, Thomas Gleixner wrote:
> Jeff,
>
> On Tue, 2007-09-25 at 17:56 -0400, Jeff Dike wrote:
> > On Tue, Sep 25, 2007 at 09:54:15PM +0200, Thomas Gleixner wrote:
> > > On Tue, 2007-09-25 at 13:37 -0400, Jeff Dike wrote:
> > > > Put back an implementation of timeval_to_ns in
> > > > arch/um/os-Linux/time.c.  tglx pointed out in his review of tickless
> > > > support that there was a perfectly good implementation of it in
> > > > linux/time.h.  The problem is that this is userspace code which can=
't
> > > > pull in kernel headers and there doesn't seem to be a libc version.
> > >
> > > Oops. Did not notice.
> >
> > It's a UML peculiarity...
> >
> > > Can't we move it into some header file which is accessible from
> > > everywhere ?
There is a way to do this without code duplication, but it is creating a=20
non-inline function which calls the inline and calling the non-inline from=
=20
userspace. It's done for a variety of other functions.

There is a tradeoff of speed vs code duplication - and if this function is =
not=20
supposed to change and to need to be kept in sync, it could be copied. I=20
conceptually hate this solution, but it can make some sense.

=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade

--nextPart5079317.PVAtiMum5I
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+n7GqH9OHC+5NscRAuEIAJ4+ESGAjbQtA06T6LHFoSxAN9OwdQCdFw3L
gHzDTRs767+EEGAiwVhhoGo=
=mww4
-----END PGP SIGNATURE-----

--nextPart5079317.PVAtiMum5I--


--===============0900578236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0900578236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0900578236==--

