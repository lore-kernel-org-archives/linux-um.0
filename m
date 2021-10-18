Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcaeF-00HMc2-9a
 for linux-um@lists.infradead.org; Mon, 18 Oct 2021 21:58:24 +0000
Date: Tue, 19 Oct 2021 08:58:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Oct 18 ('make' error on ARCH=um)
Message-ID: <20211019085811.362b4304@canb.auug.org.au>
In-Reply-To: <a1b2bdda-d1cf-807b-6a84-73a3e347639c@infradead.org>
References: <20211018203023.036d8362@canb.auug.org.au>
 <a1b2bdda-d1cf-807b-6a84-73a3e347639c@infradead.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3760527700408758331=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Geoffrey Thomas <geofft@ldpreload.com>, Finn Behrens <me@kloenk.de>, Adam Bratschi-Kaye <ark.email@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, Boqun Feng <boqun.feng@gmail.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Sven Van Asbroeck <thesven73@gmail.com>, Gary Guo <gary@garyguo.net>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fox Chen <foxhlchen@gmail.com>, Ayaan Zaidi <zaidi.ayaan@gmail.com>, Douglas Su <d0u9.su@outlook.com>, Yuki Okushi <jtitor@2k36.org>

--===============3760527700408758331==
Content-Type: multipart/signed; boundary="Sig_/fM5toOcPkNFI__oUNn4DYU6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fM5toOcPkNFI__oUNn4DYU6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Oct 2021 14:14:59 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 10/18/21 2:30 AM, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20211015:
> >  =20
>=20
> UML (arch=3Dum) with SUBARCH of i386 or x86_64,
> using gcc, not clang:
>=20
> make[1]: Entering directory '/work/lnx/next/linux-next-20211018/UM64'
> ../scripts/Makefile.clang:19: *** Specify CROSS_COMPILE or add '--target=
=3D' option to scripts/Makefile.clang.  Stop.
> make[1]: Leaving directory '/work/lnx/next/linux-next-20211018/UM64'
> make: *** [Makefile:226: __sub-make] Error 2
>=20
>=20
> Just use a make target of defconfig:
>=20
> make ARCH=3Dum SUBARCH=3Dx86_64 O=3DUM64 defconfig

OK, I missed that.

In commit

  c862c7fee526 ("Kbuild: add Rust support")

from the rust tree, these bits should probably not be there:

Makefile:
@@ -586,13 +628,11 @@ endif
 # Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
 # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
 # and from include/config/auto.conf.cmd to detect the compiler upgrade.
 CC_VERSION_TEXT =3D $(subst $(pound),,$(shell LC_ALL=3DC $(CC) --version 2=
>/dev/null | head -n 1))
=20
-ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
 include $(srctree)/scripts/Makefile.clang
-endif
=20
 # Include this also for config targets because some architectures need
 # cc-cross-prefix to determine CROSS_COMPILE.
 ifdef need-compiler
 include $(srctree)/scripts/Makefile.compiler

in scripts/Makefile.clang the

ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
endif

pair near the end become unnecessary.

So I will apply the following to the merge of the rust tree today:

diff --git a/Makefile b/Makefile
index b4482fd3a0cc..3d7c777d831f 100644
--- a/Makefile
+++ b/Makefile
@@ -630,7 +630,9 @@ endif
 # and from include/config/auto.conf.cmd to detect the compiler upgrade.
 CC_VERSION_TEXT =3D $(subst $(pound),,$(shell LC_ALL=3DC $(CC) --version 2=
>/dev/null | head -n 1))
=20
+ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
 include $(srctree)/scripts/Makefile.clang
+endif
=20
 # Include this also for config targets because some architectures need
 # cc-cross-prefix to determine CROSS_COMPILE.
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 38f555d0cb0d..b8e331f98471 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -40,9 +40,7 @@ TENTATIVE_CLANG_FLAGS	+=3D -Werror=3Dignored-optimization=
-argument
=20
 export TENTATIVE_CLANG_FLAGS
=20
-ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
 CLANG_FLAGS	+=3D $(TENTATIVE_CLANG_FLAGS)
 KBUILD_CFLAGS	+=3D $(CLANG_FLAGS)
 KBUILD_AFLAGS	+=3D $(CLANG_FLAGS)
 export CLANG_FLAGS
-endif


Miguel, does that seem reasonable?

--=20
Cheers,
Stephen Rothwell

--Sig_/fM5toOcPkNFI__oUNn4DYU6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFt7fMACgkQAVBC80lX
0GwBdQf9H+gB+Zj1Hl1xzpasMggxd4A/XDlphqZKR5nWT0i1QV6gJSOKHhS5z/hu
ELHdqPZ+Ug0rRlQ55MhZCTFem+QfJnCQI8frP4Mv9o+cYa9B1FXnSr/3A+Uhfnko
ca5yfq6rh8v7b0ay7l3nLle+OwcY5/eEsIOKejvE4CU30cCrSnM2y/5iHdDmaRn9
i4HCvsDvQfTXWna2Vu/XGXfJfK5qF1mo+CUjCsxJYNiar7cA+lsh7pI/yxtsXKPU
XRSX30VxHq8sEwrZaCK2upa3m22BayR3EdDJRhJpM484tMus4/KS8GXVSaA/MnA0
yXhP3qCueN6G4aOhIgF7Ea0xxor2UQ==
=3kMV
-----END PGP SIGNATURE-----

--Sig_/fM5toOcPkNFI__oUNn4DYU6--


--===============3760527700408758331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============3760527700408758331==--


