Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FCCEAE5.9000801@nod.at>
Date: Mon, 04 Jun 2012 19:05:41 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1338809738-18967-1-git-send-email-jslaby@suse.cz> <1338809738-18967-14-git-send-email-jslaby@suse.cz> <4FCCA3A6.8080608@nod.at> <4FCCD224.1020307@suse.cz> <4FCCD44A.3090500@nod.at> <4FCCD70D.5010908@suse.cz> <4FCCD774.5040003@nod.at> <4FCCE1D4.7080805@panasas.com> <4FCCE255.4080705@nod.at> <4FCCE866.7050203@panasas.com>
In-Reply-To: <4FCCE866.7050203@panasas.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD7308C4502625E7DF9EB484D"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 13/24] TTY: um/line, use tty from tty_port
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Jiri Slaby <jirislaby@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, alan@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD7308C4502625E7DF9EB484D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 04.06.2012 18:55, schrieb Boaz Harrosh:
> No still crashing the same, way. BTW I do not have a systemd Distro. It=
's
> plain old FC12. Though in the lab I have the same crash with FC15.
>=20
> The crash is immediately after I login at the initial prompt. (every ti=
me)

Okay, I'll test my patches with FC12 too. :-\

> Here is the crash print, what ever that is worth in UML.
> (Can we make the crash dump stack trace a bit less terrible?)

-ENOPATCH. :-)
Feel free to send one.

Thanks,
//richard



--------------enigD7308C4502625E7DF9EB484D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPzOrlAAoJEN9758yqZn9eUfEIAIvNJb9B71IcHx//2k8qRq3C
KAgVvXY3dNUAt/GuEbxAqXnNNvFiMBaMuKq08rWiVxew2cAUlbauC9DkS0i0OnQi
1urSAdSxezcyf/fKJoPN+THP8lyEfIVEtqyumSpZkjItpOhPeeqsNESrma4NIIF8
l7JI6B6A/JCPM/eiGVAeG6SBJ64XshX4E0I+2LqRJTx9MSNcWOMY61se0rgraKTT
uHkNSpkBaUKaCRHwP1hABSKddx+mloREaZOj0FeSg3NqY6FLL6zb2SMjQSTVkXHt
WDXh2IfAB01qAdJHkNFq1M8Hi9aB4jY9oSbBLWIodEmeqIyWbqdacxlq8zsRdUs=
=8lKY
-----END PGP SIGNATURE-----

--------------enigD7308C4502625E7DF9EB484D--
