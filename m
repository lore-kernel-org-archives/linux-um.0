Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQMfg-0003ix-Rn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 02:48:00 -0700
Received: from gizmo12bw.bigpond.com ([144.140.70.43])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DQMfK-00076M-SB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 02:48:00 -0700
From: Andree Leidenfrost <aleidenf@bigpond.net.au>
In-Reply-To: <1114459067.983.22.camel@localhost.localdomain>
References: <20050425191253.B9FE045EBB@zion>
	<1114459067.983.22.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-WTkJhPQ+Im/q2sIT5W80"
Message-Id: <1114508655.7716.28.camel@aurich.ostfriesland>
Mime-Version: 1.0
Subject: [uml-devel] Re: [patch 1/1] uml: fix handling of no fpx_regs
	[critical, for 2.6.12]
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
Date: Tue, 26 Apr 2005 19:44:15 +1000
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


--=-WTkJhPQ+Im/q2sIT5W80
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Alexander

On Mon, 2005-04-25 at 21:57 +0200, Alexander Nyberg wrote:
> m=E5n 2005-04-25 klockan 21:12 +0200 skrev blaisorblade@yahoo.it:
> > From: Andree Leidenfrost <aleidenf@bigpond.net.au>, Paolo 'Blaisorblade=
' Giarrusso <blaisorblade@yahoo.it>
> >=20
> > Fix the error path, which is triggered when the processor misses the fp=
x regs
> > (i.e. the "fxsr" cpuinfo feature). For instance by VIA C3 Samuel2. Test=
ed and
> > obvious, please merge ASAP.
> >=20
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > ---
> >=20
> >  linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c |    7 ++++--=
-
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff -puN arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_han=
dling arch/um/os-Linux/sys-i386/registers.c
> > --- linux-2.6.12/arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_r=
egs_handling	2005-04-25 21:03:11.000000000 +0200
> > +++ linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c	2005-04-25=
 21:08:07.000000000 +0200
> > @@ -105,14 +105,15 @@ void init_registers(int pid)
> >  		panic("check_ptrace : PTRACE_GETREGS failed, errno =3D %d",
> >  		      err);
> > =20
> > +	errno =3D 0;
> >  	err =3D ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
> >  	if(!err)
> >  		return;
> > +	if(errno !=3D EIO)
> > +		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno =3D %d",
> > +		      errno);
>=20
> Looks like you mean "if (err !=3D EIO)" here

No. The patch is correct.

ptrace will always return -1 in case of an error. The actual error code
is in errno, hence this is what needs to be compared to EIO. Please also
see the ptrace manpage.

> >  	have_fpx_regs =3D 0;
> > -	if(err !=3D EIO)
> > -		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno =3D %d",
> > -		      err);
> > =20
> >  	err =3D ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
> >  	if(err)

Best regards
Andree
--=20
Andree Leidenfrost
Sydney - Australia


--=-WTkJhPQ+Im/q2sIT5W80
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQBCbg1viLvX3b2IzawRAis8AJdu1kbsiI36tmyHFbdyLMHlj70LAKDQ+1Vr
y5Yk684QAemZ2dRWaPJxgg==
=VYH2
-----END PGP SIGNATURE-----

--=-WTkJhPQ+Im/q2sIT5W80--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
