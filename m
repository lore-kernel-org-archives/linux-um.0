Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8NzE-0002ph-7Z
 for linux-um@lists.infradead.org; Thu, 12 Sep 2019 12:14:09 +0000
Received: by mail-pl1-x641.google.com with SMTP id k1so11717267pls.11
 for <linux-um@lists.infradead.org>; Thu, 12 Sep 2019 05:14:07 -0700 (PDT)
Message-ID: <2947157812216eae1aad2840b8981163a7af2209.camel@debian.org>
Subject: Re: Bug#938962: user-mode-linux needs update for new linux
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Thu, 12 Sep 2019 17:44:02 +0530
In-Reply-To: <CAHt6kzG5V3N9i68jMvxwz-5kk9h709QZsqcH9uM+cthCam87Lg@mail.gmail.com>
References: <20190830152801.GA23318@debian.org>
 <f13e90782de567a8537a15dec1834a9b8c27bd6b.camel@debian.org>
 <CAHt6kzG5V3N9i68jMvxwz-5kk9h709QZsqcH9uM+cthCam87Lg@mail.gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@debian.org
Content-Type: multipart/mixed; boundary="===============0127271452299290666=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>
Cc: 938962@bugs.debian.org


--===============0127271452299290666==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+3T570S6nMOOKkAPJpQP"


--=-+3T570S6nMOOKkAPJpQP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am not sure if this has been reported upstream but with libpcap 1.9,
user mode linux fails to build. The build failure happens with both,
5.2 and 4.19 LTS kernels.

A much detailed report is available at:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D938962

libpcap 1.9 introduces `pcap_open` which is also declared in linux
headers in arch/um/drivers/pcap_user.c


Thanks,
Ritesh

On Sat, 2019-09-07 at 17:18 +0200, Romain Francoise wrote:
> Hi,
>=20
> On Tue, Sep 3, 2019 at 3:21 PM Ritesh Raj Sarraf <rrs@debian.org>
> wrote:
> [...]
> > In file included from /usr/include/pcap.h:43,
> >                  from arch/um/drivers/pcap_user.c:7:
> > /usr/include/pcap/pcap.h:835:18: note: previous declaration of
> > =E2=80=98pcap_open=E2=80=99 was here
> >  PCAP_API pcap_t *pcap_open(const char *source, int snaplen, int
> > flags,
> >                   ^~~~~~~~~
> > make[2]: *** [scripts/Makefile.build:309:
> > arch/um/drivers/pcap_user.o] Error 1
>=20
> libpcap 1.9 includes support for remote capture, which was originally
> a part of WinPcap extensions. The `pcap_open()' symbol is part of
> that
> API and that's why it's defined in the header file even though remote
> support is not enabled in Debian. I suggest you rename the function
> defined in your program so that it doesn't conflict with libpcap.
--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-+3T570S6nMOOKkAPJpQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl16NooACgkQpjpYo/Lh
dWlaXRAAld5HyPSq3EJqTWgMVT/xlFKQAos1glktwIrxfKKKqf9Su2loNHoXZgl8
c1rpg0TeZnayDM7VraDN3POrCmwLjLoTbeSE3hfGIXBQLvb9dXlLTL1Uc5r2McYz
nbuibkIXZXP5FRuqyvXlhbhm3F9CeDLMcRfa00nyVGJjgTGfhG9a6f3b3aPFCHKm
Y2YeOiuuZ2FqLzpULoMJinfmLdeyuKOxB800xKCnRglHhu6T38Mw96Mko9RouhlL
GUJ7LCTPXvnt+l0G1feRTdUHbtSAHhKDK5DDbTD7jud2hmXVIaNFso0SxHYaiDhQ
A77dfYNBxybqLBctMVVTcIrnIlFW0WUez0af7xnGFJdrrPEejvEIRUPTveBfjKgL
yrwhL5mTNFxcgDtR+VnzLPUED5p7T3R0q2F9KqA3j+zLdsSm0h1QvHZGpBf/tCiG
TZsDAUG93iqFVB6TrhO/PJEaGSQOBXWtnSGHvre4p4NECXZLb9CnUlZ5HHUdb19i
twuOXb/zgN3pKm4SpdeiNYjIBhMaQkgFW5fgVk/qPrC2V2pBUvA/2D8qnaPbLKE+
qgrIV5GV9WkFxXj/qpuXuyToHFO2UW4psJH94uTjihLp2VsaKvJ1li0UWZYcSpRu
uEOrdSFRt89A6a0rQ3bObMXnWmFAftf3tiqPUL7lCKrw+nN/+68=
=WmX9
-----END PGP SIGNATURE-----

--=-+3T570S6nMOOKkAPJpQP--



--===============0127271452299290666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0127271452299290666==--



