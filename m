Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Michael Halcrow <uml@halcrow.us>
Message-ID: <20050125215416.GA2912@halcrow.us>
Reply-To: Michael Halcrow <uml@halcrow.us>
References: <20041118160909.GA7630@halcrow.us>
	<200411181839.26596.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <200411181839.26596.blaisorblade_spam@yahoo.it>
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
Date: Tue, 25 Jan 2005 15:54:16 -0600
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: Michael Halcrow <uml@halcrow.us>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2004 at 06:39:26PM +0100, Blaisorblade wrote:
> On Thursday 18 November 2004 17:09, Michael Halcrow wrote:
> Ok, please list the new syscalls - I see at least add_key() and
> request_key() too - are these three the only ones? I'll build the
> patch ASAP when getting your answer.

I spent some more time today trying to implement these silly
request_key, add_key, and keyctl syscalls in the 2.6.10 kernel, but I
haven't had any luck.  It would be a *tremendous* help for me in my
filesystem development if I could just get these syscalls working in
UML; it is much more tedious having to use kgdb in my debugging.  I
tried adding entries on to the end of the
include/sysdep-i386/syscalls.h and the kernel/sys_call_table.c files.
I also exported the symbols in os-Linux/user_syms.c.  I am trying to
work from the documentation here:

http://jdike.stearns.org/uml/arch-port.html

I am not entirely clear on the function that ``[ 222 ] =3D
sys_ni_syscall,'' at the end of the table in syscalls.h is supposed to
serve.  Syscalls in UML contstitutes new territory for me.

I would assume that the __NR_* assignments in the UML environment are
identical to those of the host system.  That means that request_key,
for example, maps to identifier 288 on the i386 architecture, right?
The keyctl.c utility defines these syscall identifiers, so I need to
make sure that I get the numbers right for the syscall table lookup.

Thanks,
Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB9sAHLTz92j62YB0RAvSXAJ9kGXNlzBh5lacPxrXEyfDWqeKNjgCgrg3h
Y0Uq3KWbbCxLb+bVqtAaPWM=
=lWQe
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
