Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1448805802-12156-1-git-send-email-mic@digikod.net>
 <1448805802-12156-2-git-send-email-mic@digikod.net>
 <CADNZ+wSJtq9Ymx-2YcYe5XwwXTmMdbtsuBz6JHotnnwH3G7GKg@mail.gmail.com>
 <56641CEA.5080202@digikod.net>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <566449A3.6030504@digikod.net>
Date: Sun, 6 Dec 2015 15:43:47 +0100
MIME-Version: 1.0
In-Reply-To: <56641CEA.5080202@digikod.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jElCOM4HFlslsAGuBtCcCEA6UIBjexP0I"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] um: Set secure access mode for temporary file
To: Tristan Schmelcher <tschmelcher@google.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jElCOM4HFlslsAGuBtCcCEA6UIBjexP0I
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/12/2015 12:32, Micka=C3=ABl Sala=C3=BCn wrote:
> On 04/12/2015 18:13, Tristan Schmelcher wrote:
>> If there is a concern that the mkstemp implementation may be insecure,=

>> why not set and restore the umask?
>>
>=20
> I will add this safeguard.

Well, I'm concerned to use umask because it is not thread-safe and driver=
s may use create_mem_file() in a multi-theaded context. I prefer to stick=
 to fchmod and handle the race-condition with O_TMPFILE unsell someone is=
 sure that this will not create bugs :)

 Micka=C3=ABl


--jElCOM4HFlslsAGuBtCcCEA6UIBjexP0I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWZEmjAAoJECLe/t9zvWqVhNYH/R9MW4vraQsFk20vPa7vIGgP
a+ijYQxbEj9onoaQ/didHLB/rBUC4mphzyLsqr+SlbhyQMluRYn5oaYteka0/z/X
SujyElLO1PNLiRftzLn4GQxUG88nVOWbQdpeZ/5eWYJytAhgGEBv8c4gnv86bpfM
INxSTl7bneyPL1m4uBaeD1JN9NgRp58Fb+CdAtk6FQ4yIljb+rrkuOOFDbpmWfw4
LhQzgNlKVp5o4CeTdKqbUNdSY3pSSNRRP9M8C+841hVhIJ92SSMCfvbKUQXcJ4zU
IhGOJNdRAzDWuAsfD7UzWd/bduPTlw4Q2I5RNW8gzalQh41rO5yRk2C4hyNzO5U=
=09pq
-----END PGP SIGNATURE-----

--jElCOM4HFlslsAGuBtCcCEA6UIBjexP0I--
