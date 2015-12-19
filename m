Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Sat, 19 Dec 2015 19:18:31 +0100
Message-Id: <1450549111-1297-3-git-send-email-mic@digikod.net>
In-Reply-To: <1450549111-1297-1-git-send-email-mic@digikod.net>
References: <1450549111-1297-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH v4 2/2] um: Use race-free temporary file creation
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Open the memory mapped file with the O_TMPFILE flag when available.

Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Acked-by: Tristan Schmelcher <tschmelcher@google.com>
---
 arch/um/os-Linux/mem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 840d573..8b17676 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -106,6 +106,17 @@ static int __init make_tempfile(const char *templa=
te)
 		}
 	}
=20
+#ifdef O_TMPFILE
+	fd =3D open(tempdir, O_CLOEXEC | O_RDWR | O_EXCL | O_TMPFILE, 0700);
+	/*
+	 * If the running system does not support O_TMPFILE flag then retry
+	 * without it.
+	 */
+	if (fd !=3D -1 || (errno !=3D EINVAL && errno !=3D EISDIR &&
+			errno !=3D EOPNOTSUPP))
+		return fd;
+#endif
+
 	tempname =3D malloc(strlen(tempdir) + strlen(template) + 1);
 	if (tempname =3D=3D NULL)
 		return -1;
--=20
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

