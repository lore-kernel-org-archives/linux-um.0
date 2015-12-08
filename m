Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56674E18.7020905@nod.at>
Date: Tue, 8 Dec 2015 22:39:36 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DXT6oVT45Lb2TmNGuSDf1pIMLvAkoAVHo"
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML fixes for 4.4-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DXT6oVT45Lb2TmNGuSDf1pIMLvAkoAVHo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Linus,

The following changes since commit 527e9316f8ec44bd53d90fb9f611fa7ffff52b=
b9:

  Linux 4.4-rc4 (2015-12-06 15:43:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.4-=
rc5

for you to fetch changes up to 887a9853092c09e20598f4a7f91ac1cfb762be50:

  um: fix returns without va_end (2015-12-08 22:26:00 +0100)

----------------------------------------------------------------
This pull request contains various bug fixes, most of them are
fall out from the merge window.

----------------------------------------------------------------
Geyslan G. Bem (1):
      um: fix returns without va_end

Lorenzo Colitti (1):
      arch: um: fix error when linking vmlinux.

Richard Weinberger (2):
      um: Fix get_signal() usage
      um: Fix fpstate handling

 arch/um/Makefile           |  2 +-
 arch/um/drivers/net_user.c | 10 ++++++----
 arch/um/kernel/signal.c    |  2 +-
 arch/x86/um/signal.c       | 18 ++++++++++--------
 scripts/link-vmlinux.sh    |  2 +-
 5 files changed, 19 insertions(+), 15 deletions(-)


--DXT6oVT45Lb2TmNGuSDf1pIMLvAkoAVHo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJWZ04cAAoJEPmeIjfg4UaaPcoP/0rGWf8vE+SYFYNUHC5C8j/3
j4QB9gVaNEE4ty4uSTKdg1UbkNzy4Wg9srqXeI92Pi+PrOIXHc94YJDqyP8ms0n5
N4tyqxMIyqsVlsFjUuATdPUoTJWPo7yqQnDsQ+Ab5/Ov5eqf++nuGyJw1h3B817L
2Tl0npT7Mb70MD8s5cabOJs126YtKEPybmI+4DuseRnjUE0QkhFs12yvX8lYD7gu
tZdbzewVhexXety1TUOa/zktFKz3WFee8jHp5WDBOPhwwhkSkVxTX8CzAGbuTpXq
oNkm08KZZP03mBPbXT+pxv8wJkzALTCHKrgJ0qHiDT4wWXXfaRzuKtCg0Oum/S/l
cBVEQFM/DHfBzm8uMXD1o3tYhJk+fb69zzsBNETqzplBeYJddRWLR1cuVHLe5AlG
zvM2hEVri0KJCsB1pY9UwIlLozeMcfBbaTdgJMQ86XMNFHNLXcqb6y1LP3KSY+jm
XlKKll+V0fDVianA3PjndVyUkuqBxhJARQ/DrkJaH0Ze9uUFMVxhS+Iw+vQ6cUmm
JmF79b4Q3FESmgCHz/5nUFgM/doCDXWP0hUvJ3XbRhxIv7ba2UOUzztDSAkNdMd5
i68MgvI85iaNriJWRPEyC1EptFy9yveN90Kw2Pm/ZiGs7Q90RZcc+vn5WY4e+5w9
W5/Dr31nr7OOjKHzvtuh
=b+k2
-----END PGP SIGNATURE-----

--DXT6oVT45Lb2TmNGuSDf1pIMLvAkoAVHo--
