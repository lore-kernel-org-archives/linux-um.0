Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FD06F04.5050001@nod.at>
Date: Thu, 07 Jun 2012 11:06:12 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at> <20120604221731.5e378fc2@pyramind.ukuu.org.uk> <4FCFE504.2020100@nod.at> <20120607101951.14d6596d@bob.linux.org.uk>
In-Reply-To: <20120607101951.14d6596d@bob.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9BD478C03B3A5AB7D92D69FA"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: TTY fixes (?)
To: Alan Cox <alan@linux.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jslaby@suse.cz, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9BD478C03B3A5AB7D92D69FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 07.06.2012 11:19, schrieb Alan Cox:
> On Thu, 07 Jun 2012 01:17:24 +0200
> Richard Weinberger <richard@nod.at> wrote:
>=20
>> Am 04.06.2012 23:17, schrieb Alan Cox:
>>> We can half ignore it on console for the simple reason that you
>>> don't "dial in" to the console. I suspect it may be abusable but
>>> I've not found a way to do so.
>>>
>>
>> BTW: Can't we add such a mode to tty_port?
>> E.g. tty_port->non_dialin_console. 8)
>=20
> That is basically what you are doing when you omit a hangup method. The=

> security consequences on a multi-user box run deeper however so in the
> end we need to fix the util-linux code.

Okay, than I have to find out why getty does not start if I omit ->hangup=
=2E

Thanks,
//richard



--------------enig9BD478C03B3A5AB7D92D69FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJP0G8EAAoJEN9758yqZn9eW2AH/3bPA/5UZgUZ30MPjC9tF7EQ
fl3ubuKefKIWh8QOfrkJFnVe9+w689F+3Ld8xcl1YJuGAVllHRFb8Z4xnNhfvyIn
fMPj6x3JG0nOcKp0uXhF7v+Ap3hh6v9bOdCtEV+urhLSDMAGNxU5yH6gQ4MYAN9P
ibROiwNC8uB3QwuFyWfKpnmm5I9i98LTfVTsHqEjH2SxX+AZrcON+o7pQ8R7TOte
pbnKLzmVnoJvQ6fwc2DOxlh3wPVqh5QlxmCPPSqMNbyZpCevFgaZsWFWDDpEjfJm
+3BBGLYUfReTTjz7JPJxxSvr7xdC3mWOxATlj3cw/q7TaAgGsX4T0lsChR6ECLY=
=tOY7
-----END PGP SIGNATURE-----

--------------enig9BD478C03B3A5AB7D92D69FA--
