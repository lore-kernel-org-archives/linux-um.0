Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Michael Halcrow <uml@halcrow.us>
Message-ID: <20050125224650.GA6136@halcrow.us>
Reply-To: Michael Halcrow <uml@halcrow.us>
References: <20041118160909.GA7630@halcrow.us>
	<200411181839.26596.blaisorblade_spam@yahoo.it>
	<20050125215416.GA2912@halcrow.us>
	<200501252337.58219.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <200501252337.58219.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] keyring syscalls
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
Date: Tue, 25 Jan 2005 16:46:51 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Michael Halcrow <uml@halcrow.us>, Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 25, 2005 at 11:37:57PM +0100, Blaisorblade wrote:
> On Tuesday 25 January 2005 22:54, Michael Halcrow wrote:
> > On Thu, Nov 18, 2004 at 06:39:26PM +0100, Blaisorblade wrote:
> Well, it should be fixed in the -mm tree (and probably in 2.6.11-rc2-bk2,=
 I=20
> guess, though it's not tested)... browse the patches at=20
> http://user-mode-linux.sourceforge.net/patches.html.

I did notice that and tried to build it, but I had build errors.
Specifically, the compiler complains that the PTRACE_SETOPTIONS symbol
is undeclared in arch/um/kernel/process.c.  If I include
linux/ptrace.h and try again, then the new syscalls (vperfctr_*) are
undeclared in arch/um/kernel/sys_call_table.c.  I just gave up at that
point; I'll wait for the official 2.6.11 release.  In the meantime,
I'll see if I can't backport the changes in the 2.6.11-rc2 patch to
2.6.10.

Thanks,
Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB9sxaLTz92j62YB0RAuAOAJ45/VdW/cf7LbTWxubpIIKVX3JWkwCfRjkG
ZxcEjj7M587AeRM46GeVJkk=
=oJpe
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
