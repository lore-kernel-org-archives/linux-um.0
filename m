Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FCCD774.5040003@nod.at>
Date: Mon, 04 Jun 2012 17:42:44 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1338809738-18967-1-git-send-email-jslaby@suse.cz> <1338809738-18967-14-git-send-email-jslaby@suse.cz> <4FCCA3A6.8080608@nod.at> <4FCCD224.1020307@suse.cz> <4FCCD44A.3090500@nod.at> <4FCCD70D.5010908@suse.cz>
In-Reply-To: <4FCCD70D.5010908@suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig876D2C964AE500862634B53D"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 13/24] TTY: um/line, use tty from tty_port
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, gregkh@linuxfoundation.org, alan@linux.intel.com, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig876D2C964AE500862634B53D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 04.06.2012 17:41, schrieb Jiri Slaby:
> Hmm, I remember. I suggest you to split the patch into several pieces.
> For example moving the code from ->open into ->install can be done
> separately. Otherwise it's hard to tell what's wrong with the patch as
> a whole.
>=20
> Also, it would be good to see the patch rebased on the top of my
> patch, because tty_port_set/get pieces would be gone from your patch to=
o.

Okay, I'll redo it!
I've a much cleaner version in my local queue.

Thanks,
//richard



--------------enig876D2C964AE500862634B53D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPzNd0AAoJEN9758yqZn9emUIIAK0DyxWL5cAXSTkJgoXd3QNW
+hQ1GYvknVqy7bBsy5xSHQ6OMj/XSZK03kF9+yCmBwdlcmwwbfD6PzaUN3i9XgNP
lpGl1e9mmQXpGIJVsjvH9abQpS+3/LqtIo8UrmGOHW6HiUZTsOqQ2jFITGpK29DZ
j8jX7bL5Y+ITujGmlZrDlQcMhXSbiOpJco8LwP3Z1NTV4PIYbHj3+ViXJ/Y39be1
FB0veDpK+I+CClU5dScBiAcTRfLvb3U/0hK3XPMLHbIhdBGTHfKLYn6oJUPbh92D
u4dvdnmiLssRf5MS3iYY1jZoI84ycyGFoik4zYk8l7y0uSrltHwmp0PHQOyuKZ4=
=OMph
-----END PGP SIGNATURE-----

--------------enig876D2C964AE500862634B53D--
