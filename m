Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FCD4161.7060409@nod.at>
Date: Tue, 05 Jun 2012 01:14:41 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at> <20120604221731.5e378fc2@pyramind.ukuu.org.uk>
In-Reply-To: <20120604221731.5e378fc2@pyramind.ukuu.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB8966F045016342BF92DE81B"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: TTY fixes (?)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jslaby@suse.cz, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, alan@linux.intel.com, kzak@redhat.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8966F045016342BF92DE81B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 04.06.2012 23:17, schrieb Alan Cox:
>> 	On all other ttys login works but bash dies because of of -EIO.
>> 	After vhangup() the tty returns -EIO upon read()/write().
>=20
> You can't re-open the tty because a process is holding on to it, not
> closing it and not killable. Fedora shouldn't be holding these devices
> open this way. The behaviour we have of refusing to reopen them why thi=
s
> is the case is both a) what the spec seems to say b) good security.

Hmm, there seems to be a bug in util-linux's login.
login-utils/login.c::init_tty() does:
=2E..
       /* Kill processes left on this tty */
        tcsetattr(0, TCSAFLUSH, &ttt);

        signal(SIGHUP, SIG_IGN);        /* so vhangup() wont kill us */
        vhangup();
        signal(SIGHUP, SIG_DFL);

        /* open stdin,stdout,stderr to the tty */
        open_tty(cxt->tty_path);

        /* restore tty modes */
        tcsetattr(0, TCSAFLUSH, &tt);
=2E..

By calling vhangup() it kills all other programs on the current tty.
open_tty() opens the tty again but it's still open because stdin, stdout =
and stderr
belongs to it.

If I add:
        fclose(stdin);
        fclose(stdout);
        fclose(stderr);
before the call to vhangup() login works like charm. :-)

Karel, what do you think?

Thanks,
//richard


--------------enigB8966F045016342BF92DE81B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPzUFiAAoJEN9758yqZn9esOkIAIR6UdfhtnMTrQWOo9/0wb/u
CCKfeygoBPXHIimHWqyOx+L21FEOVGmNsHJRrPpzfAzPnJ2k//NFeEpGIly6AnKB
RFrX5eWRldaRy6l6f4b3Z4JhY5ceyCfz1/UfZjZkC6PDZGWBUDttzEQwiQDQBzxQ
PULJXEYHTUN8+TipJU0H9y00VzMSYYd8Q9IDJKxiyFzh2vQ2joV6hUDUp1opB3Wv
Tyip415QyiYxtY/OhoZi3ya+3JMCPJ9F36CHIY5zmbZW5ldA84Bge58L0HxxKeVe
l1Ib4xqFYssjWa3XRKDYEjqbz1Gl1RY3Q5iI93LYfekiMFYk2xuYPdxl6V5Ho5Q=
=Rz9u
-----END PGP SIGNATURE-----

--------------enigB8966F045016342BF92DE81B--
