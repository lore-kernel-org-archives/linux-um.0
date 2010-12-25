Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] uml: use simple_write_to_buffer
Date: Sat, 25 Dec 2010 15:03:57 +0900
Message-Id: <1293257039-2580-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <n>
References: <n>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Simplify write file operation for mmapper by using
simple_write_to_buffer().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/drivers/mmapper_kern.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/mmapper_kern.c b/arch/um/drivers/mmapper_kern.c
index 8501e7d..4ad91c6 100644
--- a/arch/um/drivers/mmapper_kern.c
+++ b/arch/um/drivers/mmapper_kern.c
@@ -37,13 +37,7 @@ static ssize_t mmapper_write(struct file *file, const char __user *buf,
 	if (*ppos > mmapper_size)
 		return -EINVAL;
 
-	if (count > mmapper_size - *ppos)
-		count = mmapper_size - *ppos;
-
-	if (copy_from_user(&v_buf[*ppos], buf, count))
-		return -EFAULT;
-
-	return count;
+	return simple_write_to_buffer(v_buf, mmapper_size, ppos, buf, count);
 }
 
 static long mmapper_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-- 
1.7.3.4

