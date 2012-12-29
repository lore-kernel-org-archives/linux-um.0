Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sergei Trofimovich <slyfox@gentoo.org>
Date: Sun, 30 Dec 2012 01:37:31 +0300
Message-Id: <1356820651-8495-2-git-send-email-slyfox@gentoo.org>
In-Reply-To: <1356820651-8495-1-git-send-email-slyfox@gentoo.org>
References: <1356820651-8495-1-git-send-email-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: =?UTF-8?q?=5BPATCH=202/2=5D=20um=3A=20fix=20build=20failure=20due=20to=20mess-up=20of=20sig=5Finfo=20protorype?=
To: 
Cc: Sergei Trofimovich <slyfox@gentoo.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, =?UTF-8?q?Martin=20P=C3=A4rtel?= <martin.partel@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/os-Linux/signal.c:18:8: error: conflicting types for 'sig_info'
In file included from /home/slyfox/linux-2.6/arch/um/os-Linux/signal.c:=
12:0:
arch/um/include/shared/as-layout.h:64:15: note: previous declaration of=
 'sig_info' was here

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
CC: Jeff Dike <jdike@addtoit.com>
CC: Richard Weinberger <richard@nod.at>
CC: "Martin P=C3=A4rtel" <martin.partel@gmail.com>
CC: Al Viro <viro@zeniv.linux.org.uk>
CC: user-mode-linux-devel@lists.sourceforge.net
CC: user-mode-linux-user@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
---
 arch/um/os-Linux/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index b1469fe..9d9f1b4 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -15,7 +15,7 @@
 #include <sysdep/mcontext.h>
 #include "internal.h"
=20
-void (*sig_info[NSIG])(int, siginfo_t *, struct uml_pt_regs *) =3D {
+void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) =3D=
 {
 	[SIGTRAP]	=3D relay_signal,
 	[SIGFPE]	=3D relay_signal,
 	[SIGILL]	=3D relay_signal,
--=20
1.8.0.2

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

