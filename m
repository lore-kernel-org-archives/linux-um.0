Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Michael Halcrow <uml@halcrow.us>
Message-ID: <20041118174324.GA8993@halcrow.us>
Reply-To: Michael Halcrow <uml@halcrow.us>
References: <20041118160909.GA7630@halcrow.us>
	<200411181839.26596.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
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
Date: Thu, 18 Nov 2004 11:43:24 -0600
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: Michael Halcrow <uml@halcrow.us>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2004 at 06:39:26PM +0100, Blaisorblade wrote:
> On Thursday 18 November 2004 17:09, Michael Halcrow wrote:
> > Howdy folks,
> >
> > I am attempting to use David Howells' new keyring in 2.6.10-rc2
> > UML and am getting a ``Function not implemented'' error with
> > keyctl.  I was getting that in my host kernel until I mucked with
> > the __NR_* #define's in the userspace keyctl.c to align with the
> > values in the 2.6.10-rc2 entry.S.  I imagine that new syscalls
> > require some magic in UML that I am unfamiliar with.  I tried
> > adding some entries to arch/um/include/sysdep-i386/syscalls.h for
> > keyctl et. al., to no avail, but I'm kind of shooting the dark
> > here.
>
> Ok, please list the new syscalls - I see at least add_key() and
> request_key() too - are these three the only ones? I'll build the
> patch ASAP when getting your answer.

Yes, those are the only three.  Thanks!

Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D

"Never go to a doctor whose office plants have died."               =20
 - Erma Bombeck=20

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBnN88LTz92j62YB0RAjI+AJ4sgHfT3eUNvix3v9rQrW3/ltf+rACfYxux
yR+AMIGRsfuvlmBVrWz70Ek=
=nvrE
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
