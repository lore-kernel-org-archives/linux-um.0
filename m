Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1448805802-12156-1-git-send-email-mic@digikod.net>
 <1448805802-12156-2-git-send-email-mic@digikod.net>
 <CADNZ+wSJtq9Ymx-2YcYe5XwwXTmMdbtsuBz6JHotnnwH3G7GKg@mail.gmail.com>
 <56641CEA.5080202@digikod.net> <566449A3.6030504@digikod.net>
 <CADNZ+wTtu5gZuztSAnY9TE0fV4cVgqr534gyDUEkp0LS=Vq4Xw@mail.gmail.com>
 <56674F91.8050108@nod.at>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <5668C024.2020803@digikod.net>
Date: Thu, 10 Dec 2015 00:58:28 +0100
MIME-Version: 1.0
In-Reply-To: <56674F91.8050108@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dJ69Bc753TNxvdmFERI47rLwQtIFKMpSN"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] um: Set secure access mode for temporary file
To: Richard Weinberger <richard@nod.at>, Tristan Schmelcher <tschmelcher@google.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dJ69Bc753TNxvdmFERI47rLwQtIFKMpSN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2015 22:45, Richard Weinberger wrote:
> Am 08.12.2015 um 21:37 schrieb Tristan Schmelcher:
>> On 6 December 2015 at 09:43, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net=
> wrote:
>>> Well, I'm concerned to use umask because it is not thread-safe and dr=
ivers may use create_mem_file() in a multi-theaded context.
>>
>> You are right. We should perhaps set the umask to 0700 permanently
>> during process start. But I am not sure if this will interfere with
>> other UML code.
>=20
> It *should* not hurt. Let's see what explodes. :)

We can't force the kernel process umask without breaking compatibility wi=
th current implementation, especially with hostfs (i.e. the host umask pr=
evail the guest one).

>>> I prefer to stick to fchmod and handle the race-condition with O_TMPF=
ILE unsell someone is sure that this will not create bugs :)
>>
>> The fchmod call is basically useless and should probably be removed.
>=20
> I agree.

I propose then to simply remove the fchmod call and let the O_TMPFILE fla=
g do the magic :)

Regards,
 Micka=C3=ABl


--dJ69Bc753TNxvdmFERI47rLwQtIFKMpSN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWaMAqAAoJECLe/t9zvWqVgCsH+wZdvbx4mG7k/Z4SFgsmECTk
uKwwK4NivikyNMaYSNtLuJaZf31oYiu2YLlRMGfQ2YFrN0U5nkVhWpjSaMmOC7RD
nmLBBTEuq+bIjV5S3axT8yzGc/CCMl+VumKrrw07XT6tfdJCM23jCMeDrrpldkSa
PNKe9JvrJs3+bpWEw2bPXgcXTAHLVCFnTWLrdw62qlduolzmRfWrIbOIT4gTI9Vj
kdeSfkVUaNIDDjoODu4d2Yh0qo8MP+bvauD9PqUkt/0JTe0+VdoVwYwBjtObA7at
+6sf/fa4TTY/oBPMU1MYjOmUV5AzN2nLs+DhlgWcRoI/lckevT+1NoZB/1vqa20=
=CFbk
-----END PGP SIGNATURE-----

--dJ69Bc753TNxvdmFERI47rLwQtIFKMpSN--
