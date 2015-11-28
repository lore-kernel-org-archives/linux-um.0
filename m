Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
References: <1448746350-19998-1-git-send-email-mic@digikod.net>
 <1448746350-19998-3-git-send-email-mic@digikod.net> <565A258D.4040206@nod.at>
Message-ID: <565A3128.8010605@digikod.net>
Date: Sat, 28 Nov 2015 23:56:40 +0100
MIME-Version: 1.0
In-Reply-To: <565A258D.4040206@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="r9iIkJa4IwVuOPO5pIFLeCinwGMv5jXeg"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] um: Use race-free temporary file creation
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r9iIkJa4IwVuOPO5pIFLeCinwGMv5jXeg
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable


On 28/11/2015 23:07, Richard Weinberger wrote:
> Am 28.11.2015 um 22:32 schrieb Micka=EBl Sala=FCn:
>> Open the memory mapped file with the O_TMPFILE flag when available.
>>
>> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
>> ---
>>  arch/um/os-Linux/mem.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
>> index 798aeb4..fe52e2d 100644
>> --- a/arch/um/os-Linux/mem.c
>> +++ b/arch/um/os-Linux/mem.c
>> @@ -106,6 +106,18 @@ static int __init make_tempfile(const char *templ=
ate)
>>  		}
>>  	}
>> =20
>> +#ifdef O_TMPFILE
>> +	fd =3D open(tempdir, O_CLOEXEC | O_RDWR | O_EXCL | O_TMPFILE, 0700);=

>> +	/*
>> +	 * If the running system does not support O_TMPFILE flag then retry
>> +	 * without it.
>> +	 */
>> +	if (fd !=3D -1 || (errno !=3D EINVAL && errno !=3D EISDIR &&
>=20
> Why are you handling EISDIR?

I follow the man page for open [1], I think it was a workaround needed fo=
r some kernel versions just after the O_TMPFILE was added but before the =
support for EOPNOTSUPP.
We may need to add the EACCES too for some version of glibc [2, 3]?

1. http://man7.org/linux/man-pages/man2/openat.2.html#BUGS
2. Commit 69a91c237ab0ebe4e9fdeaf6d0090c85275594ec and https://sourceware=
=2Eorg/bugzilla/show_bug.cgi?id=3D17523
3. https://bugs.gentoo.org/529044

>=20
>> +			errno !=3D EOPNOTSUPP))
>> +		return fd;
>> +	errno =3D 0;
>=20
> Why are you resetting errno?

It's to ignore/reset the error code from open, but it may not be needed b=
ecause of the next call to malloc?

 Micka=EBl


--r9iIkJa4IwVuOPO5pIFLeCinwGMv5jXeg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWWjEpAAoJECLe/t9zvWqVXZwH/iO5/qCQL1P0LqlWYridir/3
Cpc2jxg0kdcKtZYJs3kRi12yOWIPAn4mYWcbHoCNnNLX1AD8mK075OUUGvCY0AFh
18RZGae5gRFd3jtjQO5sIvzW5FxTXKU6MMVIYqOLa4jmKnjSot5YLHAHfvKjrh+I
6BjhtEuooEGyOSu71iXNluXnXAa3TguJELdiUlXTr0XkAwi0Ix7OSHzBgI0lBgJv
HzcByPA174S9DMwzgfu65oAbm5m6UeQ0y/nPFc/fjAaAJ38mbwb7feu0vGEItJ70
fCGIf8PCmL+RQeDDToX4gpSkQdMXF4nV9RVdqevAxGfcVsCuMb0Wilh10N/G8eQ=
=Lire
-----END PGP SIGNATURE-----

--r9iIkJa4IwVuOPO5pIFLeCinwGMv5jXeg--
