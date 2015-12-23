Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450820692-10557-1-git-send-email-mic@digikod.net>
 <5679CE80.4030006@nod.at>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <567A9A25.3010807@digikod.net>
Date: Wed, 23 Dec 2015 13:57:09 +0100
MIME-Version: 1.0
In-Reply-To: <5679CE80.4030006@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CJjkkBealcQIaSMS2G1uAFguuPdDo29d0"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Fix build error and kconfig for i386
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CJjkkBealcQIaSMS2G1uAFguuPdDo29d0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 22/12/2015 23:28, Richard Weinberger wrote:
> Am 22.12.2015 um 22:44 schrieb Micka=C3=ABl Sala=C3=BCn:
>> Fix build error by selecting COREDUMP when X86_32 is selected:
>>
>> arch/x86/um/built-in.o: In function `elf_core_write_extra_phdrs':
>> (.text+0x3e62): undefined reference to `dump_emit'
>> arch/x86/um/built-in.o: In function `elf_core_write_extra_data':
>> (.text+0x3eef): undefined reference to `dump_emit'
>>
>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> ---
>>  arch/x86/um/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
>> index ed56a1c4ae73..bb7cd8b38043 100644
>> --- a/arch/x86/um/Kconfig
>> +++ b/arch/x86/um/Kconfig
>> @@ -26,6 +26,7 @@ config X86_32
>>  	select CLONE_BACKWARDS
>>  	select OLD_SIGSUSPEND3
>>  	select OLD_SIGACTION
>> +	select COREDUMP
>=20
>=20
> Do you know since when this is broken?


After some bisecting, it's broken since v3.15. I'll send a new patch incl=
uding this info.

 Micka=C3=ABl


--CJjkkBealcQIaSMS2G1uAFguuPdDo29d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWepolAAoJECLe/t9zvWqVHpkH+wd9NZ9KcT65wG6Cp1Ml0vp4
NRUpvxQgXdWTKxa/xF5rPAOBW7SSOngkZpJg+PDCjT6hNaD4N7xMKgdT8TJapSSu
kMhlNMjWx5ianm9Nv8JZc/XJYU6r3ipHOgduG52yppcgSNlV9La3tu3otnWyXf5Y
b9GIEWxva9qgIjkEF6FwIUJiY0ek8hPCj5Me70EX0L9o1FP/4kPYRAa5z1joeufb
YdzpOMygK3fE4NG5xSqJU29Rzkj0LUuo1b9ademabkOj2j/EBhWCtlEBmAnHytXj
6fx+aATXpthbwJVt64frajDxElFMP02KGga5txc67/mr9KLosNZ/VSFTtQQniXI=
=uK8T
-----END PGP SIGNATURE-----

--CJjkkBealcQIaSMS2G1uAFguuPdDo29d0--
