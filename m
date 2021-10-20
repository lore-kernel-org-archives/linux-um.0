Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdIgK-005n7F-Cf
 for linux-um@lists.infradead.org; Wed, 20 Oct 2021 20:59:29 +0000
Date: Thu, 21 Oct 2021 07:59:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Oct 18 ('make' error on ARCH=um)
Message-ID: <20211021075913.3d6f8adb@canb.auug.org.au>
In-Reply-To: <b0eddd67-e62f-c6c3-37d1-8c69f27c51fb@infradead.org>
References: <20211018203023.036d8362@canb.auug.org.au>
 <a1b2bdda-d1cf-807b-6a84-73a3e347639c@infradead.org>
 <20211019085811.362b4304@canb.auug.org.au>
 <CANiq72=+5w7KzVKmN57ud5+GGEiuRbtgezfROGAuO=b-OYeWAA@mail.gmail.com>
 <20211020155627.7d6f6637@canb.auug.org.au>
 <81c2e5c6-7388-3d1d-87a9-1b000517661b@infradead.org>
 <b0eddd67-e62f-c6c3-37d1-8c69f27c51fb@infradead.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0579500327319706929=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, Geoffrey Thomas <geofft@ldpreload.com>, Finn Behrens <me@kloenk.de>, Adam Bratschi-Kaye <ark.email@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, Boqun Feng <boqun.feng@gmail.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Sven Van Asbroeck <thesven73@gmail.com>, Gary Guo <gary@garyguo.net>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fox Chen <foxhlchen@gmail.com>, Ayaan Zaidi <zaidi.ayaan@gmail.com>, Douglas Su <d0u9.su@outlook.com>, Yuki Okushi <jtitor@2k36.org>

--===============0579500327319706929==
Content-Type: multipart/signed; boundary="Sig_/YFuEnSKXicKp7XvjTGlhP4K";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/YFuEnSKXicKp7XvjTGlhP4K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Wed, 20 Oct 2021 07:46:24 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> No problems like this in linux-next 2021-10-20.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/YFuEnSKXicKp7XvjTGlhP4K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFwgyEACgkQAVBC80lX
0GwC2Qf7BxUbVTPtimV8VXVOL1I/Ahks5nPzI6tI5l7qGtsNVHLbtIF56EiIxLXk
auT4QNSdysrlafV4dzRZPxA5DcXcYrpvfRcO75NuY+UB7aL45l0BU2T/xJrZk9Io
vQ7QaHvn8Hw7hZzK0pXoaxRX2WQixCFJIVsuEMD1BrgNzHxLFa/5N7DYdZTkT1s9
7yJXKH+DNiobOZXLXR7Zfm+DRfKUXHFOMAMdZLthngnTfd9LDlLqwOK4t3sl+4fj
1APoIHirsD9alN45IVTS+o51JmcnF6X0fpmZJPptV81fu+q1sLgFbYRwDq5zYig+
Evb2MxSTmucy16DUsqyCyvOhiqRYaQ==
=47v7
-----END PGP SIGNATURE-----

--Sig_/YFuEnSKXicKp7XvjTGlhP4K--


--===============0579500327319706929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0579500327319706929==--


