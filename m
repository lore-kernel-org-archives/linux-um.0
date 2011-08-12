Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Fri, 12 Aug 2011 02:24:10 +0200
Message-Id: <1313108650-5941-1-git-send-email-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: drivers/xterm.c: fix a file descriptor leak
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

I could use out_close1, but that seems to be the code path to close the
fd returned by os_create_unix_socket, and using it to close the fd
returned by mkstemp might lead to some confusion, so I don't do it.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 arch/um/drivers/xterm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index 8ac7146..2e1de57 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -123,6 +123,7 @@ static int xterm_open(int input, int output, int pr=
imary, void *d,
 		err =3D -errno;
 		printk(UM_KERN_ERR "xterm_open : unlink failed, errno =3D %d\n",
 		       errno);
+		close(fd);
 		return err;
 	}
 	close(fd);
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

