Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.1.10.1001041421450.4942@dr-wily.mit.edu>
References: <alpine.DEB.1.10.1001041421450.4942@dr-wily.mit.edu>
Date: Fri, 18 Jun 2010 15:49:32 +0200
Message-ID: <AANLkTinji7n8Hd1Ldci_ruH0r8qglGjC00YQkb-MEwoV@mail.gmail.com>
Subject: [RESEND][REGRESSION] um: CONFIG_STATIC_LINK=y broken
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: tabbott@ksplice.com, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Andrew, Linus, Jeff, ... anyone?
Please apply this patch.

CONFIG_STATIC_LINK is still broken. :(

//richard
---------- Forwarded message ----------
From: Tim Abbott <tabbott@ksplice.com>
Date: Mon, Jan 4, 2010 at 10:08 PM
Subject: [REGRESSION] um: CONFIG_STATIC_LINK=3Dy broken
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org,
richard -rw- weinberger <richard.weinberger@gmail.com>, Sam Ravnborg
<sam@ravnborg.org>


Hi Linus,

The following patch fixes a regression that I caused in 2.6.32 when
cleaning up the um architecture's linker scripts.

I've not heard anything from the um maintainers (they have had since
Richard Weinberger reported that this patch fixed the problem on December
22), so I'm sending this to you now (and CCing stable@ since it affects
2.6.32).

=EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD-Tim Abbott

--

um: remove PAGE_SIZE alignment in linker script causing kernel segfault.

The linker script cleanup that I did in commit
5d150a97f9391f5bcd7ba0d59d7a11c3de3cea80 accidentally introduced an
ALIGN(PAGE_SIZE) when converting to use INIT_TEXT_SECTION; Richard
Weinberger reported that this causes the kernel to segfault with
CONFIG_STATIC_LINK=3Dy.

I'm not certain why this extra alignment is a problem, but it seems likely
it is because previously

__init_begin =3D _stext =3D _text =3D _sinittext

and with the extra ALIGN(PAGE_SIZE), _sinittext becomes different from the
rest. =EF=BF=BDSo there is likely a bug here where something is assuming th=
at
_sinittext is the same as one of those other symbols. =EF=BF=BDBut revertin=
g the
accidental change fixes the regression, so it seems worth committing that
now.

Signed-off-by: Tim Abbott <tabbott@ksplice.com>
Reported-by: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
=EF=BF=BDarch/um/kernel/uml.lds.S | =EF=BF=BD =EF=BF=BD2 +-
=EF=BF=BD1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index e7a6cca..664f942 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -22,7 +22,7 @@ SECTIONS
=EF=BF=BD _text =3D .;
=EF=BF=BD _stext =3D .;
=EF=BF=BD __init_begin =3D .;
- =EF=BF=BDINIT_TEXT_SECTION(PAGE_SIZE)
+ =EF=BF=BDINIT_TEXT_SECTION(0)
=EF=BF=BD . =3D ALIGN(PAGE_SIZE);

=EF=BF=BD .text =EF=BF=BD =EF=BF=BD =EF=BF=BD:
--
1.6.5.7
