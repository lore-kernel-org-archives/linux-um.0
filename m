Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-user] Re: [uml-devel] "Configuring network
	interfaces...execvp of 'uml_net' failed - errno = 2" error msg
Message-ID: <20060220053419.GA6204@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <20060217115152.GA17278@SteX>
	<20060217154425.GA3823@ccure.user-mode-linux.org>
	<200602171948.29509.blaisorblade@yahoo.it>
	<200602191704.03527.rob@landley.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <200602191704.03527.rob@landley.net>
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
Date: Mon, 20 Feb 2006 06:34:20 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 19, 2006 at 05:04:03PM -0500, Rob Landley wrote:
Hi Rob,
> On Friday 17 February 2006 1:48 pm, Blaisorblade wrote:
> > On Friday 17 February 2006 16:44, Jeff Dike wrote:
> > > On Fri, Feb 17, 2006 at 03:05:28PM +0100, Blaisorblade wrote:
> > > > For the future packaging: I do believe that Debian's defaults have =
been
> > > > actually planned while uml_utilities haven't, so I like the idea of
> > > > switching to Debian paths as defaults, and possibly using the curre=
nt
> > > > ones as fallbacks.
> > >
> > > Yup, as long as they are not too Debian-specific.
> >
> > They tend to make more sense and adhere better to the
> > FHS. /var/run/uml-utilities requires support from the distro, but having
> > uml_net in /usr/lib is a correct idea, for instance.
>=20
> I'm confused, why would you have executables in a shared library director=
y=20
> instead of /usr/bin or some such?  (These are runnable elf binaries, not=
=20
> shared libraries, correct?)
Citing from Debian policy (FHS):

"/usr/lib includes object files, libraries, and internal binaries that are
not intended to be executed directly by users or shell scripts."

and

"Some executable commands such as makewhatis and sendmail have also been
traditionally placed in /usr/lib. makewhatis is an internal binary and
should be placed in a binary directory; users access only catman. Newer
sendmail binaries are now placed by default in /usr/sbin; a symbolic link
should remain from /usr/lib. Additionally, systems using a
sendmail-compatible mail transport agent should provide /usr/sbin/sendmail
as a symbolic link to the appropriate executable."

So it would be nice if you can provide a symbolic link from the binary
executable to the library file.

Cheers

SteX

--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ/lU24lnkxrVLfgpAQIdGgQAjGlsoAR+GhbQDDBdswD0IHjVDRMLKapQ
fBfXZKjMzpVOzl+K3XZAfjXtth3r4W9+WCYfmSnyY7AyrkO8Mi7IO/QMz9pnRV1o
uG02qWlClgT8dC/vLQ+L4FvJWElYC4wtuAoezpS7pdbLLZi2/3VMNXyeBSWi0eSy
dEW9i3ZUg58=
=1uln
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
