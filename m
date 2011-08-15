Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Mon, 15 Aug 2011 15:34:10 +0200
Message-Id: <1313415250-15428-1-git-send-email-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] UserModeLinux-HOWTO.txt: fix a typo
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 Documentation/virtual/uml/UserModeLinux-HOWTO.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/virtual/uml/UserModeLinux-HOWTO.txt b/Docume=
ntation/virtual/uml/UserModeLinux-HOWTO.txt
index a7af9cf..77dfecf 100644
--- a/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
+++ b/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
@@ -770,7 +770,7 @@
=20
=20
=20
-  will cause serial line 3 to accept input on the host's /dev/tty3 and
+  will cause serial line 3 to accept input on the host's /dev/tty2 and
   display output on an xterm.  That's a silly example - the most commo=
n
   use of this syntax is to reattach the main console to stdin and stdo=
ut
   as shown above.
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

