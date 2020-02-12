Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1u8D-0005D0-Hj
 for linux-um@lists.infradead.org; Wed, 12 Feb 2020 15:40:54 +0000
Received: by mail-wr1-x443.google.com with SMTP id k11so2912499wrd.9
 for <linux-um@lists.infradead.org>; Wed, 12 Feb 2020 07:40:52 -0800 (PST)
Message-ID: <44b7a3a49731dfabe9cdfbeb281ad9470e71b625.camel@researchut.com>
Subject: Re: Documentation for UML Vector network
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Wed, 12 Feb 2020 21:10:43 +0530
In-Reply-To: <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk>
References: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
 <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@researchut.com
Content-Type: multipart/mixed; boundary="===============2590776660757597519=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org


--===============2590776660757597519==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-j3HLLLnIyveW4nUVVHql"


--=-j3HLLLnIyveW4nUVVHql
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 2020-02-12 at 11:15 +0000, Anton Ivanov wrote:
> 1. A patch to make it transparent replacement for whatever is
> possible from the old transports is in the queue
>=20
> 2. I was going to spend most of next week to rewrite the bits and
> pieces from my website on how to use it and incorporate them into the
> official docs and submit them as a patch to Documentation.

I did skim through your website looking for pointers in that direction.

Given that UML@SourceForge is very outdated, I suggest a different
location. I also recollect Richard was considering moving to a wiki on
a much reliable and maintained location, like uml.wiki.kernel.org. But
I think that hasn't happened.

In my opinion, one good candidate where UML documentation could be
maintained is:
Documentation/virt/uml/UserModeLinux-HOWTO.txt


That document is a dump of the UML@SourceForge website content. Having
it in the kernel tree may have a better maintenance life.

--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--=-j3HLLLnIyveW4nUVVHql
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl5EHHwACgkQpjpYo/Lh
dWkECQ//dXX1H04wx/Ofy83rpKIrM9/ZFN8C026mPmTOfv5NQaYUh1juR/uLGPnh
OOmbg0HSmU2tbBh7I/ZNTlOdU2RvnIVd0j7eF4p0cfz0vAam353rYI5AMlAY7sDU
RqwCSxAiBXIioARrNgu6Ih0++hzsN6iTHAbtHe7rVL9r9qHsnReNcPVG0HLOvkD1
YRE7jKCy8FqfxZs1AZhtYu5opq1BW9gzewHi2XaRVuuCRW5vQGgyzYUENSwRHMgW
20A5DUUkxono6NgDDLmobpKbZrv2gpT4XiElKNQJ+bKZCtgeK8I47iHStd464pZR
yxcSh/ZRRSB54WI5NhFYq3AoTFzxtGY/WAWtYnCY994jFPIJvIf1+49QMeRz6AqW
7veZAfl7jaqRQXaNTfMBYrEBhcsQ1tSVRV5C51o7lJPFZk+xfqZCekRjechRZII6
zcFFSTCRUSTD7mn7wbQWwdTjtkfM8ag3uoAXzFG4mJ5IEaGcJhglm4wCzBZf56Zy
nZHNceFt+ETHfHxlrzhGGhbwx7xD19tztPdu6mWCbeySq9wJv1c/C0Xj60j44010
V6JDkkVWjsaFRigOz1OBOaCH2eaAH8ArD65BLat+1yaUR6/e8iyDlEnM3RYlG/YM
IOSfQ/zDT6N90nDP35JuTgKVwF31D1qgbzQo7vqb/DmBEq2yJ14=
=gJ3F
-----END PGP SIGNATURE-----

--=-j3HLLLnIyveW4nUVVHql--



--===============2590776660757597519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============2590776660757597519==--



