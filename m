Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Jul 2011 19:36:51 +0300
Message-ID: <1310056611.3528.50.camel@vivanov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 2/3] uml: drivers/slip_user.c memory leak fix
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, vitalivanov@gmail.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

>>From d4f92205b89eedb5054091b9fc0e0186e9acd88b Mon Sep 17 00:00:00 2001
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Date: Thu, 7 Jul 2011 19:27:32 +0300
Subject: [PATCH 2/3] uml: drivers/slip_user.c memory leak fix

Do not free memory when you failed to allocate it.

Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
---
 arch/um/drivers/slip_user.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index a1c2d2c..cbacfc4 100644
--- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -102,7 +102,7 @@ static int slip_tramp(char **argv, int fd)
 		       "buffer\n");
 		os_kill_process(pid, 1);
 		err = -ENOMEM;
-		goto out_free;
+		goto out_close;
 	}
 
 	close(fds[1]);
@@ -112,7 +112,6 @@ static int slip_tramp(char **argv, int fd)
 	err = helper_wait(pid);
 	close(fds[0]);
 
-out_free:
 	kfree(output);
 	return err;
 
-- 
1.7.0.4



