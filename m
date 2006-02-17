Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
Message-ID: <20060217142923.GA18017@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <20060217115152.GA17278@SteX>
	<200602171307.51262.blaisorblade@yahoo.it>
	<20060217134755.GA17720@SteX>
	<200602171505.29505.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <200602171505.29505.blaisorblade@yahoo.it>
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
Date: Fri, 17 Feb 2006 15:29:23 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2006 at 03:05:28PM +0100, Blaisorblade wrote:
Ciao Paolo,
> > yes, first I tried my own configuration, then I downloaded a prebuild u=
ml
> > kernel from http://uml.nagafix.co.uk/ and I tried with this one. Same
> > error again.
> > Then I extracted the configuration from that image and I rebuild with t=
hat
> > config, same error for the same problem.
>=20
> > ste@etinarcadiaego{~}$ ll /usr/lib/uml/uml_net
> > -rwsr-x---  1 root uml-net 19836 2004-04-15 03:03 /usr/lib/uml/uml_net
>=20
> Ok, thanks for this informative info. This is the solution.
>=20
> In short, echo $PATH | grep  /usr/lib/uml, and if needed man 3 execvp, co=
uld=20
> enlighten you... or even the fact that I do:
>=20
> # ls -l /usr/bin/uml_net
> -rws--x--x  1 root root 22856 16 feb 18:49 /usr/bin/uml_net

damn, it drived me crazy!!! now it works, and I am going to provide the
solution in debian.
What it sounds strange is that:
stex@landini{~}$ ll /usr/bin/uml*
-rwxr-xr-x 1 root root 10296 2006-02-17 03:39 /usr/bin/uml_mconsole
-rwxr-xr-x 1 root root  9784 2006-02-17 03:39 /usr/bin/uml_mkcow
-rwxr-xr-x 1 root root 12356 2006-02-17 03:39 /usr/bin/uml_moo
lrwxrwxrwx 1 root root    20 2006-02-17 12:13 /usr/bin/uml_net ->
/usr/lib/uml/uml_net
-rwxr-xr-x 1 root root 15624 2006-02-17 03:39 /usr/bin/uml_switch
-rwxr-xr-x 1 root root  4168 2006-02-17 03:39 /usr/bin/uml_watchdog

(I temporarily linked uml_net from the current position)
all the other uml_* files resides on /usr/bin.
I am going to fix this.

Thanks Paolo for your usual good suggestions :))

Cheers

SteX

--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ/Xdw4lnkxrVLfgpAQLq+QP+JlIHKGbG5C+gBpgiNbrkH2IKm4yy4JU+
QJUY1u0GgQXXsB4lpRkt4cYxZDlw/tA0cp6/f/eP2X7hqrA8xcLaHNr3iQt9fY2l
dyX4Fp00fekt5tXvqoePqkSmrQM/gpuvv/o3T1HOK3/HC1n1YMoYaU1kpkJ1Mm+H
NoJ/XxZizIM=
=Tz0C
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
