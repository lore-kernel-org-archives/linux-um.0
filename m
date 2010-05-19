Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 6/8] uml: Pushdown the bkl from harddog_kern ioctl
Date: Wed, 19 May 2010 19:24:13 +0200
Message-Id: <1274289855-10001-7-git-send-regression-fweisbec@gmail.com>
In-Reply-To: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com>
References: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Jeff Dike <jdike@addtoit.com>, Uml <user-mode-linux-devel@lists.sourceforge.net>, Thomas Gleixner <tglx@linutronix.de>, John Kacur <jkacur@redhat.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Pushdown the bkl to harddog_ioctl.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Uml <user-mode-linux-devel@lists.sourceforge.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Kacur <jkacur@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/drivers/harddog_kern.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index d332503..cfcac1f 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -124,8 +124,8 @@ static ssize_t harddog_write(struct file *file, const char __user *data, size_t
 	return 0;
 }
 
-static int harddog_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, unsigned long arg)
+static int harddog_ioctl_unlocked(struct file *file,
+				  unsigned int cmd, unsigned long arg)
 {
 	void __user *argp= (void __user *)arg;
 	static struct watchdog_info ident = {
@@ -148,10 +148,22 @@ static int harddog_ioctl(struct inode *inode, struct file *file,
 	}
 }
 
+static long harddog_ioctl(struct file *file,
+			  unsigned int cmd, unsigned long arg)
+{
+	long ret;
+
+	lock_kernel();
+	ret = harddog_ioctl_unlocked(file, cmd, arg);
+	unlock_kernel();
+
+	return ret;
+}
+
 static const struct file_operations harddog_fops = {
 	.owner		= THIS_MODULE,
 	.write		= harddog_write,
-	.ioctl		= harddog_ioctl,
+	.unlocked_ioctl	= harddog_ioctl,
 	.open		= harddog_open,
 	.release	= harddog_release,
 };
-- 
1.6.2.3

