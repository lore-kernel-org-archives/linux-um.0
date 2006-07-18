Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G2jM8-00066v-O1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2006 23:46:56 -0700
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146] helo=hypnos.var.cx)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G2jM8-0000Dq-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Jul 2006 23:46:56 -0700
Date: Tue, 18 Jul 2006 08:47:09 +0200
From: Frank v Waveren <fvw@var.cx>
Message-ID: <20060718064709.GA1096@var.cx>
References: <20060715152343.GA12263@var.cx>
	<200607161231.51516.blaisorblade@yahoo.it>
	<20060716120531.GA20515@var.cx>
Mime-Version: 1.0
In-Reply-To: <20060716120531.GA20515@var.cx>
Subject: Re: [uml-devel] cap-bound not working in uml
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1389510465=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


--===============1389510465==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The problem turned out to be caused in userspace, for some odd reason
the init on the gentoo disk image I'd nabbed did something that set
its inheritable mask to ~0. Not sure if its doing it on purpose, and I
still don't quite understand the code I quoted below, but it's not
relevant to UML, so I'll ask about it elsewhere. Sorry for the noise.

On Sun, Jul 16, 2006 at 02:05:31PM +0200, Frank v Waveren wrote:
> On Sun, Jul 16, 2006 at 12:31:51PM +0200, Blaisorblade wrote:
> > On Saturday 15 July 2006 17:23, Frank v Waveren wrote:
> > > I was trying to limit some unecessary capabilities in a UML instance
> > > with /proc/sys/kernel/cap-bound, but it turned out not to take.
> >=20
> > To remove capabilities from the whole system (i.e. all processes) the=
=20
> > recommended way wasn't to use lcap (or a similar program bundled with=
=20
> > libcap)?
> Yup, lcap is just an interface to /proc/sys/kernel/cap-bound.
>=20
>=20
> > > The source of the problem (or at least something a bit of the way up
> > > the garden path of the problem) is at security/commoncap.c:140 at the
> > > top of cap_bprm_apply_creds(bprm, unsafe):
> > >
> > >    void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> > >    {
> > >            /* Derived from fs/exec.c:compute_creds. */
> > >            kernel_cap_t new_permitted, working;
> > >
> > >            new_permitted =3D cap_intersect (bprm->cap_permitted, cap_=
bset);
> > >            working =3D cap_intersect (bprm->cap_inheritable,
> > >                                     current->cap_inheritable);
> > >            new_permitted =3D cap_combine (new_permitted, working);
> > >            ...
> > >
> > > Here the new permitted set gets limited to the bits in cap_bset, which
> > > is as it should be, but then the intersection of the of the current
> > > and exec inheritable masks get added to that set, whereas as I
> > > understand it, cap_bset should always be the bounding set.
> > >
> > > I've tried commenting out that bit and everything worked as I'd hoped
> > > (I haven't done extensive testing, but bounding the caps worked, as
> > > did suids and such).
> > >
> > > That doesn't explain why it works with those lines left in on a
> > > non-UML kernel though, so I assume I'm missing something fundamental.

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEvIPt+gB9UUaNYsgRAjiHAJ0XpGNBroFHe/IBtCxpVeR/ZKCfBgCdHMfP
6SvUhBbfruJMbkmR8u5XwjE=
=JF82
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--


--===============1389510465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1389510465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1389510465==--
