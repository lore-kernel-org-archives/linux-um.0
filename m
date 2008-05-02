Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrooU-00089b-MH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 23:32:10 -0700
Received: from wa-out-1112.google.com ([209.85.146.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JrooT-0008Mt-BG
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 23:32:10 -0700
Received: by wa-out-1112.google.com with SMTP id j5so336084wah.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 01 May 2008 23:32:09 -0700 (PDT)
Date: Fri, 2 May 2008 14:36:14 +0800 (CST)
Message-ID: <alpine.LFD.1.10.0805021430280.3349@localhost.localdomain>
MIME-Version: 1.0
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [SPAM] [uml-devel] [Patch] (Resend) arch/um/kernel/irq.c: clean up
	some functions
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


Make activate_fd() and free_irq_by_irq_and_dev() static.
Remove init_aio_irq() since it has no users.

Compile testing passed.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <wangcong@zeuux.org>

---
  arch/um/include/irq_kern.h |    2 --
  arch/um/include/irq_user.h |    2 --
  arch/um/kernel/irq.c       |   35 ++---------------------------------
  3 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/arch/um/include/irq_kern.h b/arch/um/include/irq_kern.h
index 4f77559..fba3895 100644
--- a/arch/um/include/irq_kern.h
+++ b/arch/um/include/irq_kern.h
@@ -13,8 +13,6 @@ extern int um_request_irq(unsigned int irq, int fd, int type,
  			  irq_handler_t handler,
  			  unsigned long irqflags,  const char * devname,
  			  void *dev_id);
-extern int init_aio_irq(int irq, char *name,
-			irq_handler_t handler);

  #endif

diff --git a/arch/um/include/irq_user.h b/arch/um/include/irq_user.h
index e60b318..c6c784d 100644
--- a/arch/um/include/irq_user.h
+++ b/arch/um/include/irq_user.h
@@ -21,8 +21,6 @@ struct irq_fd {
  enum { IRQ_READ, IRQ_WRITE };

  extern void sigio_handler(int sig, struct uml_pt_regs *regs);
-extern int activate_fd(int irq, int fd, int type, void *dev_id);
-extern void free_irq_by_irq_and_dev(unsigned int irq, void *dev_id);
  extern void free_irq_by_fd(int fd);
  extern void reactivate_fd(int fd, int irqnum);
  extern void deactivate_fd(int fd, int irqnum);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 91587f8..3d7aad0 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -102,7 +102,7 @@ void sigio_handler(int sig, struct uml_pt_regs *regs)

  static DEFINE_SPINLOCK(irq_lock);

-int activate_fd(int irq, int fd, int type, void *dev_id)
+static int activate_fd(int irq, int fd, int type, void *dev_id)
  {
  	struct pollfd *tmp_pfd;
  	struct irq_fd *new_fd, *irq_fd;
@@ -216,7 +216,7 @@ static int same_irq_and_dev(struct irq_fd *irq, void *d)
  	return ((irq->irq == data->irq) && (irq->id == data->dev));
  }

-void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
+static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
  {
  	struct irq_and_dev data = ((struct irq_and_dev) { .irq  = irq,
  							  .dev  = dev });
@@ -403,37 +403,6 @@ void __init init_IRQ(void)
  	}
  }

-int init_aio_irq(int irq, char *name, irq_handler_t handler)
-{
-	int fds[2], err;
-
-	err = os_pipe(fds, 1, 1);
-	if (err) {
-		printk(KERN_ERR "init_aio_irq - os_pipe failed, err = %d\n",
-		       -err);
-		goto out;
-	}
-
-	err = um_request_irq(irq, fds[0], IRQ_READ, handler,
-			     IRQF_DISABLED | IRQF_SAMPLE_RANDOM, name,
-			     (void *) (long) fds[0]);
-	if (err) {
-		printk(KERN_ERR "init_aio_irq - : um_request_irq failed, "
-		       "err = %d\n",
-		       err);
-		goto out_close;
-	}
-
-	err = fds[1];
-	goto out;
-
- out_close:
-	os_close_file(fds[0]);
-	os_close_file(fds[1]);
- out:
-	return err;
-}
-
  /*
   * IRQ stack entry and exit:
   *
-- 
1.5.2.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
