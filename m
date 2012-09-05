Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 05 Sep 2012 18:38:50 +0200
Message-ID: <87harca0h1.fsf@tucsk.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] uml: fix compile error in deliver_alarm()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Martin =?utf-8?Q?P=C3=A4rtel?= <martin.partel@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

=46rom: Miklos Szeredi <mszeredi@suse.cz>

=46ix the following compile error on UML.

arch/um/os-Linux/time.c: In function 'deliver_alarm':
arch/um/os-Linux/time.c:117:3: error: too few arguments to function 'al=
arm_handler'
arch/um/os-Linux/internal.h:1:6: note: declared here

The error was introduced by commit d3c1cfcd (um: pass siginfo to guest
process) in 3.6-rc1.

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
CC: Martin P=C3=A4rtel <martin.partel@gmail.com>
---
 arch/um/os-Linux/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/um/os-Linux/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/um/os-Linux/time.c	2012-09-05 17:18:27.00000000=
0 +0200
+++ linux-2.6/arch/um/os-Linux/time.c	2012-09-05 18:34:35.000000000 +02=
00
@@ -114,7 +114,7 @@ static void deliver_alarm(void)
 	skew +=3D this_tick - last_tick;
=20
 	while (skew >=3D one_tick) {
-		alarm_handler(SIGVTALRM, NULL);
+		alarm_handler(SIGVTALRM, NULL, NULL);
 		skew -=3D one_tick;
 	}
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

