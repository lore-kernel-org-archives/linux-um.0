Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Stefano Melchior <stefano.melchior@openlabs.it>
Message-ID: <20060217115152.GA17278@SteX>
Reply-To: stefano.melchior@openlabs.it
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
Subject: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
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
Date: Fri, 17 Feb 2006 12:51:52 +0100
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,
I am trying to integrate 2.6.x support to debian and I encountered a
blocking issue on networking configuration.
If you use the 2.4.x uml kernel the UML image work fine with network, but
if you use an available 2.6.x uml image or a 2.6.x image of mine the uml
bootstrap phase hangs with the following error message:

Setting up networking...done.
* /etc/network/options is deprecated.
Setting up IP spoofing protection...done (rp_filter).
Configuring network interfaces...execvp of 'uml_net' failed - errno =3D 2

=46rom previous messages I read that this concerns uml_net and its
permissions.
Do you have an idea how to work around this issue?
I also need it to apply to the future debian uml support.

Thank you in advance=20

Cheers

SteX
--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ/W42IlnkxrVLfgpAQK0QgP/eBosjoewVaMfgDmRKD4McjDtDIN8WZ+N
kJIr5ddZi6X3JkAWTYqLFdxlCjGnqO49bBVBN9O3nXJJu/h5+Yqfuz7aWfkevRi8
FKKKsCtru5SQ/ZNAX7bi+8EJA2UXlsZzC4MgQSk+6FmdxUEqHx0/C92bs3K/NWv0
F04LROWNCts=
=YPvG
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
