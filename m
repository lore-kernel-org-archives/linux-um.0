Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-devel] memory option crashes the uml bootstrap phase
Message-ID: <20060321145054.GB18505@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <20060321142624.GA18505@SteX>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20060321142624.GA18505@SteX>
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
Date: Tue, 21 Mar 2006 15:50:54 +0100
To: user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2006 at 03:26:25PM +0100, Stefano Melchior wrote:
Dear all,
[...]
I also noticed that, from manual page, if you use:

mem=3Dmemory
This controls how much "physical" memory the kernel
allocates for the system. The size is specified  as  a  number
 followed by one of =E2=80=99k=E2=80=99, =E2=80=99K=E2=80=99, =E2=80=99m=E2=
=80=99, =E2=80=99M=E2=80=99, which have the
obvious meanings.  This is not related to the amount of memory
 in the physical machine. It can be more, and the
excess, if it=E2=80=99s ever used, will just be swapped out.

- mem=3D256m it works
- while mem=3D256M it crashes!

Any suggestion?

SteX

--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name
Skype ID "stefanomelchior"

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQCVAwUBRCASzYlnkxrVLfgpAQLN5AQAlBglHHtFjOVxocvjW9rFoVZIKRCP1cJL
n0pspewFf3KgWsbGtPpmatZwOo7me0LAKMdaQEC7R7/yggMNXWWx9eROvQEB64VP
I43pfqhM3+uevNH+QZJBVM9OmfqgGfVyNzY+6KNiLA0CCuWvIOZOcSSBoqnAGrz7
Kkktyioxsu4=
=PkJG
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
