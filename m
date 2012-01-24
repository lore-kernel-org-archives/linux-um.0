Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 24 Jan 2012 20:09:12 +0100
Message-Id: <1327432152-26992-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Switch to large mcmodel on x86_64
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

x86_64 UML is unable to load modules if more than 504MiB
of memory are used.
This happens because on x86_64 the UML process has a quite high
start address (typically around 0x6000000).
If UML's memory is larger than 504MiB VMALLOC_START happens to be after
0x8000000. This is no problem unless one loads a module which was built
with R_X86_64_32S relocations.
Symbols with a location > 0x8000000 cannot be used with R_X86_64_32S

To deal with this x86_64 UML has to be compiled with -mcmodel=3Dlarge
such that no R_X86_64_32S relocations are used.

Signed-off-by: Richard Weinberger <richard@nod.at>
Reported-by: =EC=A0=84=ED=95=98=EB=8A=98 <allskyee@gmail.com>
---
 arch/um/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 28688e6..123f073 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -28,6 +28,7 @@ ifeq ($(SUBARCH),i386)
 endif
 ifeq ($(SUBARCH),x86_64)
         HEADER_ARCH :=3D x86
+	KBUILD_CFLAGS +=3D -mcmodel=3Dlarge
 endif
=20
 HOST_DIR :=3D arch/$(HEADER_ARCH)
--=20
1.7.8.3

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

