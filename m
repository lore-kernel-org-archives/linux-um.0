Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOMJH-0004Cm-Kx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:09:39 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOMJE-0001pT-BK
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:09:39 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 06 Mar 2007 00:08:52 +0100
Message-Id: <20070305230852.30695.8731.stgit@americanbeauty.home.lan>
In-Reply-To: <20070305230851.30695.26417.stgit@americanbeauty.home.lan>
References: <20070305230851.30695.26417.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 2/2] uml: avoid calling request_irq in atomic
	context
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

To avoid calling request_irq under a spinlock, and to simplify code around, code
a state machine to allow safely dropping and retaking sigio_lock during
initialization. The state variable is protected by a spinlock together with much
other stuff (so there's no reason to use atomic_t). See the long comment for
further details.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/sigio.c |   74 +++++++++++++++++++++++++++++-----------------
 1 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 88988fb..44a2d1f 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -29,6 +29,24 @@
  * exitcall.
  */
 static int write_sigio_pid = -1;
+/* State machine:
+ *
+ * write_sigio_workaround transitions from INACTIVE to STARTING; all methods
+ * exit when they detect the STARTING state, so it's effectively a lock without
+ * wait possibility. After initialization completes it goes to ACTIVE.
+ *
+ * Errors in initialization or in use (say the thread does not answer) move us
+ * to the BROKEN terminal state; this is a change (we went to INACTIVE), and it
+ * could be reverted so that we go back to INACTIVE, if this case is handled
+ * correctly without leaks.
+ *
+ * closing the device moves us to the CLOSED terminal state.
+ *
+ * The state must be read or written only with sigio_lock() held, even when we
+ * are in STARTING, to ensure global visibility across CPUs.
+ */
+enum {INACTIVE, STARTING, ACTIVE, BROKEN, CLOSED};
+static int write_sigio_state = INACTIVE;
 
 /* These arrays are initialized before the sigio thread is started, and
  * the descriptors closed after it is killed.  So, it can't see them change.
@@ -121,7 +139,7 @@ static int need_poll(struct pollfds *polls, int n)
 }
 
 /* Must be called with sigio_lock held, because it's needed by the marked
- * critical section.
+ * critical section. The lock could be moved inside, but it is not needed.
  */
 static void update_thread(void)
 {
@@ -146,6 +164,9 @@ static void update_thread(void)
 	if(write_sigio_pid != -1)
 		os_kill_process(write_sigio_pid, 1);
 	write_sigio_pid = -1;
+	/* Since the deinit is not complete, we cannot move into INACTIVE state.
+	 * Or can we? */
+	write_sigio_state = BROKEN;
 	close(sigio_private[0]);
 	close(sigio_private[1]);
 	close(write_sigio_fds[0]);
@@ -199,7 +220,7 @@ int ignore_sigio_fd(int fd)
 	 * sigio_cleanup has already run, then update_thread will hang
 	 * or fail because the thread is no longer running.
 	 */
-	if(write_sigio_pid == -1)
+	if(write_sigio_state != ACTIVE)
 		return -EIO;
 
 	flags = sigio_lock();
@@ -246,59 +267,53 @@ static void write_sigio_workaround(void)
 	unsigned long stack;
 	struct pollfd *p;
 	int err;
-	int l_write_sigio_fds[2];
-	int l_sigio_private[2];
-	int l_write_sigio_pid;
 	unsigned long flags;
 
 	/* We call this *tons* of times - and most ones we must just fail. */
 	flags = sigio_lock();
-	l_write_sigio_pid = write_sigio_pid;
-	sigio_unlock(flags);
-
-	if (l_write_sigio_pid != -1)
+	if (write_sigio_state != INACTIVE) {
+		sigio_unlock(flags);
 		return;
+	} else {
+		write_sigio_state = STARTING;
+	}
+	sigio_unlock(flags);
 
-	err = os_pipe(l_write_sigio_fds, 1, 1);
+	err = os_pipe(write_sigio_fds, 1, 1);
 	if(err < 0){
 		printk("write_sigio_workaround - os_pipe 1 failed, "
 		       "err = %d\n", -err);
 		return;
 	}
-	err = os_pipe(l_sigio_private, 1, 1);
+	err = os_pipe(sigio_private, 1, 1);
 	if(err < 0){
 		printk("write_sigio_workaround - os_pipe 2 failed, "
 		       "err = %d\n", -err);
 		goto out_close1;
 	}
 
-	p = setup_initial_poll(l_sigio_private[1]);
+	p = setup_initial_poll(sigio_private[1]);
 	if(!p)
 		goto out_close2;
 
-	flags = sigio_lock();
-
-	/* Did we race? Don't try to optimize this, please, it's not so likely
-	 * to happen, and no more than once at the boot. */
-	if(write_sigio_pid != -1)
-		goto out_free;
+	if (current_poll.poll)
+		kfree(current_poll.poll);
 
 	current_poll = ((struct pollfds) { .poll 	= p,
 					   .used 	= 1,
 					   .size 	= 1 });
 
-	if (write_sigio_irq(l_write_sigio_fds[0]))
+	if (write_sigio_irq(write_sigio_fds[0]))
 		goto out_clear_poll;
 
-	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
-	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
-
 	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
 					    CLONE_FILES | CLONE_VM, &stack, 0);
 
 	if (write_sigio_pid < 0)
 		goto out_clear;
 
+	flags = sigio_lock();
+	write_sigio_state = ACTIVE;
 	sigio_unlock(flags);
 	return;
 
@@ -312,15 +327,17 @@ out_clear_poll:
 	current_poll = ((struct pollfds) { .poll	= NULL,
 					   .size	= 0,
 					   .used	= 0 });
-out_free:
-	sigio_unlock(flags);
 	kfree(p);
 out_close2:
-	close(l_sigio_private[0]);
-	close(l_sigio_private[1]);
+	close(sigio_private[0]);
+	close(sigio_private[1]);
 out_close1:
-	close(l_write_sigio_fds[0]);
-	close(l_write_sigio_fds[1]);
+	close(write_sigio_fds[0]);
+	close(write_sigio_fds[1]);
+
+	flags = sigio_lock();
+	write_sigio_state = BROKEN;
+	sigio_unlock(flags);
 }
 
 void maybe_sigio_broken(int fd, int read)
@@ -357,6 +374,7 @@ static void sigio_cleanup(void)
 	if(write_sigio_pid != -1){
 		os_kill_process(write_sigio_pid, 1);
 		write_sigio_pid = -1;
+		write_sigio_state = CLOSED;
 	}
 }
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
