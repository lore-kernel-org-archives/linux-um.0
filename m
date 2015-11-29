Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Sun, 29 Nov 2015 15:03:21 +0100
Message-Id: <1448805802-12156-2-git-send-email-mic@digikod.net>
In-Reply-To: <1448805802-12156-1-git-send-email-mic@digikod.net>
References: <1448805802-12156-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH v2 1/2] um: Set secure access mode for temporary file
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Replace the insecure mode 0777 with 0700 for temporary file to prohibit
other users to change the executable mapped code.

An attacker could gain access to the mapped file descriptor from the
temporary file (before it is unlinked) in a read-only mode but it shoul=
d
not be accessible in write mode to avoid arbitrary code execution.

Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
---
 arch/um/os-Linux/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 897e9ad..798aeb4 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -142,7 +142,7 @@ static int __init create_tmp_file(unsigned long lon=
g len)
 	if (fd < 0)
 		exit(1);
=20
-	err =3D fchmod(fd, 0777);
+	err =3D fchmod(fd, 0700);
 	if (err < 0) {
 		perror("fchmod");
 		exit(1);
--=20
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

