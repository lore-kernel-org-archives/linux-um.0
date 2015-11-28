Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1448746350-19998-1-git-send-email-mic@digikod.net>
 <1448746350-19998-2-git-send-email-mic@digikod.net> <565A1F49.3040408@nod.at>
 <565A3035.6030104@digikod.net> <565A30DB.1070902@nod.at>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <565A3228.5080908@digikod.net>
Date: Sun, 29 Nov 2015 00:00:56 +0100
MIME-Version: 1.0
In-Reply-To: <565A30DB.1070902@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kgUUBLqs0Fp0jkbRFT3C9RFPaF1JLdc59"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] um: Set secure access mode for temporary file
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kgUUBLqs0Fp0jkbRFT3C9RFPaF1JLdc59
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28/11/2015 23:55, Richard Weinberger wrote:
> Am 28.11.2015 um 23:52 schrieb Micka=C3=ABl Sala=C3=BCn:
>>
>> On 28/11/2015 22:40, Richard Weinberger wrote:
>>> Am 28.11.2015 um 22:32 schrieb Micka=C3=ABl Sala=C3=BCn:
>>>> Replace the default insecure mode 0777 with 0700 for temporary file.=

>>>>
>>>> Prohibit other users to change the executable mapped code.
>>>
>>> Hmm, isn't the tmp file already unlinked at this stage?
>>>
>>
>> Yes, but if someone could open it before the unlink e.g. because of th=
e umask (which does not seems to be the case thanks to mkstemp, but remai=
ns unspecified [1]), this user should then be able to have write access t=
o the file descriptor/description.
>=20
> Yes, someone can open it before the unlink. But you change the file mod=
e after that.
> How does it improve the situation? The attacker has already the file ha=
ndle.

The attacker could have the file handle only in a read-only mode, which i=
s a bit different than being able to write and execute arbitrary code tha=
nks to a file descriptor mapped RWX :)

 Micka=C3=ABl


--kgUUBLqs0Fp0jkbRFT3C9RFPaF1JLdc59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWWjIoAAoJECLe/t9zvWqVOgUH+gOT7mR/elj1UgzQABTCZxtn
rDxofKfKpaSpGdo6J8xxFGWJNuErViNht5TwUQ41IbbenB3L45xIE+IUXTXm4hcL
7Ux2JVeBfIRtPJ8j5XmGOyccTx2e51n/rmx8pfSudk/3rj1XoBZWF2XCv8ysLIgA
RQfYt1kV3g+8Pz18rrhIy+aYBuoUrj8K0rBAPb3O6UHMiCrcNNTaF6Ri6iz6/LBs
jTK9v7bAfZuj7141dXH6IXe/1hG6GNZ8hgep1Qo7aBF6DnjwFjlthHjIIKLPF/I9
FY6+GTuXXpHVc4WAL6ZJ+3irDEAUITciaQs62OxOlwpy+ZF+SXl4b/odUcejwyM=
=aAkQ
-----END PGP SIGNATURE-----

--kgUUBLqs0Fp0jkbRFT3C9RFPaF1JLdc59--
