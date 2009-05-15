Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Joe Perches <joe@perches.com>
Date: Fri, 15 May 2009 10:59:39 -0700
Message-Id: <6d8b845124bb1e826e30ba943ccb04ac5379be21.1242407227.git.joe@perches.com>
In-Reply-To: <cover.1242407227.git.joe@perches.com>
References: <cover.1242407227.git.joe@perches.com>
In-Reply-To: <cover.1242407227.git.joe@perches.com>
References: <cover.1242407227.git.joe@perches.com>
Subject: [uml-devel] [PATCH 05/11] arch/um: Convert #ifdef DEBUG
	printk(KERN_DEBUG to pr_debug(
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

From: Joe Perches <joe@perches.com>

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/um/drivers/hostaudio_kern.c |   38 +++++++++++---------------------------
 1 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 368219c..2f5b343 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -75,9 +75,7 @@ static ssize_t hostaudio_read(struct file *file, char __user *buffer,
 	void *kbuf;
 	int err;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostaudio: read called, count = %d\n", count);
-#endif
+	pr_debug("hostaudio: read called, count = %d\n", count);
 
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (kbuf == NULL)
@@ -102,9 +100,7 @@ static ssize_t hostaudio_write(struct file *file, const char __user *buffer,
 	void *kbuf;
 	int err;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostaudio: write called, count = %d\n", count);
-#endif
+	pr_debug("hostaudio: write called, count = %d\n", count);
 
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (kbuf == NULL)
@@ -129,9 +125,7 @@ static unsigned int hostaudio_poll(struct file *file,
 {
 	unsigned int mask = 0;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostaudio: poll called (unimplemented)\n");
-#endif
+	pr_debug("hostaudio: poll called (unimplemented)\n");
 
 	return mask;
 }
@@ -143,9 +137,8 @@ static int hostaudio_ioctl(struct inode *inode, struct file *file,
 	unsigned long data = 0;
 	int err;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostaudio: ioctl called, cmd = %u\n", cmd);
-#endif
+	pr_debug("hostaudio: ioctl called, cmd = %u\n", cmd);
+
 	switch(cmd){
 	case SNDCTL_DSP_SPEED:
 	case SNDCTL_DSP_STEREO:
@@ -185,9 +178,7 @@ static int hostaudio_open(struct inode *inode, struct file *file)
 	int r = 0, w = 0;
 	int ret;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostaudio: open called (host: %s)\n", dsp);
-#endif
+	pr_debug("hostaudio: open called (host: %s)\n", dsp);
 
 	state = kmalloc(sizeof(struct hostaudio_state), GFP_KERNEL);
 	if (state == NULL)
@@ -212,9 +203,8 @@ static int hostaudio_release(struct inode *inode, struct file *file)
 {
 	struct hostaudio_state *state = file->private_data;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostaudio: release called\n");
-#endif
+	pr_debug("hostaudio: release called\n");
+
 	os_close_file(state->fd);
 	kfree(state);
 
@@ -228,9 +218,7 @@ static int hostmixer_ioctl_mixdev(struct inode *inode, struct file *file,
 {
 	struct hostmixer_state *state = file->private_data;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostmixer: ioctl called\n");
-#endif
+	pr_debug("hostmixer: ioctl called\n");
 
 	return os_ioctl_generic(state->fd, cmd, arg);
 }
@@ -241,9 +229,7 @@ static int hostmixer_open_mixdev(struct inode *inode, struct file *file)
 	int r = 0, w = 0;
 	int ret;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostmixer: open called (host: %s)\n", mixer);
-#endif
+	pr_debug("hostmixer: open called (host: %s)\n", mixer);
 
 	state = kmalloc(sizeof(struct hostmixer_state), GFP_KERNEL);
 	if (state == NULL)
@@ -271,9 +257,7 @@ static int hostmixer_release(struct inode *inode, struct file *file)
 {
 	struct hostmixer_state *state = file->private_data;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "hostmixer: release called\n");
-#endif
+	pr_debug("hostmixer: release called\n");
 
 	os_close_file(state->fd);
 	kfree(state);
-- 
1.6.3.1.9.g95405b.dirty


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

