Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Sat, 19 Dec 2015 19:18:29 +0100
Message-Id: <1450549111-1297-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH v4 0/2] um: Protect memory mapped file
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This series protect the memory mapped file.

Changes since v3:
* add Tristan Schmelcher's ack

Changes since v2; addressed Tristan Schmelcher's comment:
* remove the whole fchmod call [1/2]

Changes since v1; addressed Richard Weinberger's comments:
* add attacker model to the patch description [1/2]
* remove errno reset [2/2]

Regards,
 Micka=C3=ABl

Micka=C3=ABl Sala=C3=BCn (2):
  um: Do not set unsecure permission for temporary file
  um: Use race-free temporary file creation

 arch/um/os-Linux/mem.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--=20
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

