Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G25NF-0007gE-LL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 Jul 2006 05:05:25 -0700
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146] helo=hypnos.var.cx)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G25ND-0003At-W6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 Jul 2006 05:05:25 -0700
Date: Sun, 16 Jul 2006 14:05:31 +0200
From: Frank v Waveren <fvw.uml@var.cx>
Message-ID: <20060716120531.GA20515@var.cx>
References: <20060715152343.GA12263@var.cx>
	<200607161231.51516.blaisorblade@yahoo.it>
Mime-Version: 1.0
In-Reply-To: <200607161231.51516.blaisorblade@yahoo.it>
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
Content-Type: multipart/mixed; boundary="===============1504803968=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


--===============1504803968==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 16, 2006 at 12:31:51PM +0200, Blaisorblade wrote:
> On Saturday 15 July 2006 17:23, Frank v Waveren wrote:
> > I was trying to limit some unecessary capabilities in a UML instance
> > with /proc/sys/kernel/cap-bound, but it turned out not to take.
>=20
> To remove capabilities from the whole system (i.e. all processes) the=20
> recommended way wasn't to use lcap (or a similar program bundled with=20
> libcap)?
Yup, lcap is just an interface to /proc/sys/kernel/cap-bound.


> > The source of the problem (or at least something a bit of the way up
> > the garden path of the problem) is at security/commoncap.c:140 at the
> > top of cap_bprm_apply_creds(bprm, unsafe):
> >
> >    void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> >    {
> >            /* Derived from fs/exec.c:compute_creds. */
> >            kernel_cap_t new_permitted, working;
> >
> >            new_permitted =3D cap_intersect (bprm->cap_permitted, cap_bs=
et);
> >            working =3D cap_intersect (bprm->cap_inheritable,
> >                                     current->cap_inheritable);
> >            new_permitted =3D cap_combine (new_permitted, working);
> >            ...
> >
> > Here the new permitted set gets limited to the bits in cap_bset, which
> > is as it should be, but then the intersection of the of the current
> > and exec inheritable masks get added to that set, whereas as I
> > understand it, cap_bset should always be the bounding set.
> >
> > I've tried commenting out that bit and everything worked as I'd hoped
> > (I haven't done extensive testing, but bounding the caps worked, as
> > did suids and such).
> >
> > That doesn't explain why it works with those lines left in on a
> > non-UML kernel though, so I assume I'm missing something fundamental.
> >
> > (My guest kernel is
> >   Linux version 2.6.16.24 (fvw@jupiter.var.cx) (gcc version 4.0.3 20051=
201
> >   (prerelease) (Debian 4.0.2-5)) #3 Sat Jul 15 16:54:20 CEST 2006
> > , should it matter)

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEuiuL+gB9UUaNYsgRApNDAKCPwFnKNDpasuWNieul1dvBNrZSegCeJbBy
hRDww3cWzNUJblGuw4OUvNs=
=xaHa
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


--===============1504803968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1504803968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1504803968==--
