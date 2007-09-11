Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IV7Rb-0001L6-RL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 08:14:28 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IV7RY-0008RB-5u
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 08:14:27 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 11 Sep 2007 17:14:06 +0200
References: <46E016D8.4000803@theshore.net>
	<200709111601.03376.blaisorblade@yahoo.it>
	<20070911145852.GB7551@c2.user-mode-linux.org>
In-Reply-To: <20070911145852.GB7551@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200709111714.14572.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] init_new_context_skas - new_mm failed, errno = -24
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2111622175=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Christopher S. Aker" <caker@theshore.net>

--===============2111622175==
Content-Type: multipart/signed; boundary="nextPart1297535.0tQFuZB5pX";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1297535.0tQFuZB5pX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On marted=EC 11 settembre 2007, Jeff Dike wrote:
> On Tue, Sep 11, 2007 at 04:00:58PM +0200, Blaisorblade wrote:
> > errno =3D 24 means EMFILE (too many open files).
>
> Whoops, I mentally turned that into -ENOMEM.
>
> Maybe we should resurrect os_print_error as you suggested and start
> using it.  The current habit of using raw errnos dates from very
> early, when perror (or strerror - I don't remember which) gave me
> undebuggable segfaults deep inside libc.  Probably, that's not a
> problem any more.

I surely agree. I also think I had introduced os_print_error and exactly fo=
r=20
this purpose, even if I can't recall well.

strerror() is not reentrant so it can't be used, but there is strerror_r.

There is no strsignal_r (using strsignal(3) would clear messages as "Kernel=
=20
mode signal 8"), but I'd suggest to follow the unrecommended but documented=
=20
practice of using sys_siglist[signr].
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart1297535.0tQFuZB5pX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG5rDGqH9OHC+5NscRAohOAKCP98QYQ0mdRHFuoaMzzQTDSnAGsACeJJNr
6v4rank1YzT2XsZWF1YftGs=
=Rwf+
-----END PGP SIGNATURE-----

--nextPart1297535.0tQFuZB5pX--


--===============2111622175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============2111622175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2111622175==--

