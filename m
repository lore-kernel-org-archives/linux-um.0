Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from gandalf.ozlabs.org ([2404:9400:2:0:216:3eff:fee2:21ea])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md3eh-003NSd-IG
 for linux-um@lists.infradead.org; Wed, 20 Oct 2021 04:56:49 +0000
Date: Wed, 20 Oct 2021 15:56:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Oct 18 ('make' error on ARCH=um)
Message-ID: <20211020155627.7d6f6637@canb.auug.org.au>
In-Reply-To: <CANiq72=+5w7KzVKmN57ud5+GGEiuRbtgezfROGAuO=b-OYeWAA@mail.gmail.com>
References: <20211018203023.036d8362@canb.auug.org.au>
 <a1b2bdda-d1cf-807b-6a84-73a3e347639c@infradead.org>
 <20211019085811.362b4304@canb.auug.org.au>
 <CANiq72=+5w7KzVKmN57ud5+GGEiuRbtgezfROGAuO=b-OYeWAA@mail.gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4378330873187701933=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, Geoffrey Thomas <geofft@ldpreload.com>, Finn Behrens <me@kloenk.de>, Adam Bratschi-Kaye <ark.email@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, Boqun Feng <boqun.feng@gmail.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Sven Van Asbroeck <thesven73@gmail.com>, Gary Guo <gary@garyguo.net>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fox Chen <foxhlchen@gmail.com>, Ayaan Zaidi <zaidi.ayaan@gmail.com>, Douglas Su <d0u9.su@outlook.com>, Yuki Okushi <jtitor@2k36.org>

--===============4378330873187701933==
Content-Type: multipart/signed; boundary="Sig_/X152GgG.dRbfF.3qwxnQxkD";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/X152GgG.dRbfF.3qwxnQxkD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Tue, 19 Oct 2021 00:18:44 +0200 Miguel Ojeda <miguel.ojeda.sandonis@gmai=
l.com> wrote:
>
> On Mon, Oct 18, 2021 at 11:58 PM Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> >
> > In commit
> >
> >   c862c7fee526 ("Kbuild: add Rust support")
> >
> > from the rust tree, these bits should probably not be there:
> >
> > -ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
> >  include $(srctree)/scripts/Makefile.clang
> > -endif =20
>=20
> So this was on purpose -- we need the Clang flags even in GCC builds
> for bindgen. But now there is that `$(error ...)` added there :(
>=20
> > Miguel, does that seem reasonable? =20
>=20
> Of course, for today please feel free to apply your fix (i.e. to put
> the conditional back to where it was). I will solve it on my side
> tomorrow.

Can you please check that this is fixed for you after I do the release
today?

--=20
Cheers,
Stephen Rothwell

--Sig_/X152GgG.dRbfF.3qwxnQxkD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFvoXsACgkQAVBC80lX
0GxsZwf+Jpxyh+PvH8WWGTQgv+jM6Ss1MTFH9SfxkgnZcbJ/Ib72CtXkbTd2/Ikk
SJMdQN+te3HzoBQF7PT4vAJywkNp4eH8OYB5+dG8Pt43Hyh0CveaspxInw6RZrSB
PIdOqQOI2NpIbbADPRG1G8MJKB8RB5jxpiUroK2EA8Pn9oJpm7z/hvhitrOeB115
AsqnjpHncYipZEYYOCCcbADzdbecvfQHKmzREFJCsP/PpyZ7lT9vBH4EKCsj9Vqh
RyjZqh/wlMfF3YDJOVyXHYt8P2DaxqoqWu8eleZUPHlSBMSy52/HTpIlAnfxqAzO
wp0H1891I4vFYaDcMivxaSQZr31wvw==
=iC2V
-----END PGP SIGNATURE-----

--Sig_/X152GgG.dRbfF.3qwxnQxkD--


--===============4378330873187701933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4378330873187701933==--


