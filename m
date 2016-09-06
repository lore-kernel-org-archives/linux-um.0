Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Fix seccomp for UM
References: <alpine.LRH.2.20.1608011053430.15475@namei.org>
 <1470085317-11932-1-git-send-email-mic@digikod.net>
 <alpine.LRH.2.20.1608091035060.31071@namei.org>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <57CF27B7.6080205@digikod.net>
Date: Tue, 6 Sep 2016 22:31:51 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1608091035060.31071@namei.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jNaFJrnkAXAjnHH8HXB6xuUEof4v4usEc"
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Olof Johansson <olof@lixom.net>, user-mode-linux-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jNaFJrnkAXAjnHH8HXB6xuUEof4v4usEc
Content-Type: multipart/mixed; boundary="I3cWF13jOJk8iI2qdGIWuKuxQ9pciH7u8";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
 Olof Johansson <olof@lixom.net>,
 user-mode-linux-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>
Message-ID: <57CF27B7.6080205@digikod.net>
Subject: Re: [PATCH v2 0/3] Fix seccomp for UM
References: <alpine.LRH.2.20.1608011053430.15475@namei.org>
 <1470085317-11932-1-git-send-email-mic@digikod.net>
 <alpine.LRH.2.20.1608091035060.31071@namei.org>
In-Reply-To: <alpine.LRH.2.20.1608091035060.31071@namei.org>

--I3cWF13jOJk8iI2qdGIWuKuxQ9pciH7u8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It seems that some of the fixes from linux-security have landed in the
Linus' tree but some seccomp fixes are still missing. They fix bugs
introduced in Linux v4.8 and are still present in v4.8-rc5. Could you
please push this series before the final 4.8 release?

Regards,
 Micka=C3=ABl

On 09/08/2016 02:35, James Morris wrote:
> On Mon, 1 Aug 2016, Micka=C3=ABl Sala=C3=BCn wrote:
>=20
>> Hi,
>>
>> This series fix the recent seccomp update for the User-mode Linux arch=
itecture
>> (32-bit and 64-bit) since commit 26703c636c1f ("um/ptrace: run seccomp=
 after
>> ptrace") which close the hole where ptrace can change a syscall out fr=
om under
>> seccomp.
>>
>> Changes since v1:
>> * fix commit message typo [2/3]
>> * add Kees Cook's Acked-by
>> * rebased on commit 7616ac70d1bb ("apparmor: fix SECURITY_APPARMOR_HAS=
H_DEFAULT
>>   parameter handling")
>=20
> All applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.gi=
t next
>=20
>=20
>=20


--I3cWF13jOJk8iI2qdGIWuKuxQ9pciH7u8--

--jNaFJrnkAXAjnHH8HXB6xuUEof4v4usEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXzye8AAoJECLe/t9zvWqVkKcIAITIvIbvrhaxam9PJVV0wRqH
ONzkvlB7W72QW9PDOByC8PCjBtkp5woDNDR+93JClSVVK+NcJHT3/AQLIEGwpYvY
h8WefCUXiQFwoQKZo6QnFvJ5dXwVTMmVNXxxD/UqOsy3G2r+fa9j9C0QpHzaxlyt
bY2HeuWRQSXlgGXlyW3gTIvpNQ3gjHQUjhKn71No9NihrbqDEYiK04nztOOX8rRo
lFnFLO5pnri/ywPY8DJ7RqBTu37gi/JZihZJ5YFJKxPGVZa6s7hY5Y59GJWkB9SF
qgrq5zI1tf2/+98F+sEnsSYHuNCARQ+UokzbmVceZSw+y3OUubSPxQ8BEEcO4bw=
=uPI6
-----END PGP SIGNATURE-----

--jNaFJrnkAXAjnHH8HXB6xuUEof4v4usEc--

