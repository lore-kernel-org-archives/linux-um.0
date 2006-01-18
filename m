Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1Am-0007KR-HG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:36 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez1Al-0000ti-Vh
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:36 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118001935.14622.13619.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 5/9] uml: sigio code - reduce spinlock hold time
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 18 Jan 2006 01:19:36 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In a previous patch I shifted an allocation to being atomic.

In this patch, a better but more intrusive solution is implemented, i.e. hold
the lock only when really needing it, especially not over pipe operations, nor
over the culprit allocation.

Additionally, while at it, add a missing kfree in the failure path, and make
sure that if we fail in forking, write_sigio_pid is -1 and not, say, -ENOMEM.

And fix whitespace, at least for things I was touching anyway.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/sigio_user.c |   83 ++++++++++++++++++++++++++++++-------------
 1 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/arch/um/kernel/sigio_user.c b/arch/um/kernel/sigio_user.c
index 62e5cfd..55ef415 100644
--- a/arch/um/kernel/sigio_user.c
+++ b/arch/um/kernel/sigio_user.c
@@ -337,70 +337,103 @@ int ignore_sigio_fd(int fd)
 	return(err);
 }
 
-static int setup_initial_poll(int fd)
+static struct pollfd* setup_initial_poll(int fd)
 {
 	struct pollfd *p;
 
-	p = um_kmalloc_atomic(sizeof(struct pollfd));
-	if(p == NULL){
+	p = um_kmalloc(sizeof(struct pollfd));
+	if (p == NULL) {
 		printk("setup_initial_poll : failed to allocate poll\n");
-		return(-1);
+		return NULL;
 	}
 	*p = ((struct pollfd) { .fd  	= fd,
 				.events 	= POLLIN,
 				.revents 	= 0 });
-	current_poll = ((struct pollfds) { .poll 	= p,
-					   .used 	= 1,
-					   .size 	= 1 });
-	return(0);
+	return p;
 }
 
 void write_sigio_workaround(void)
 {
 	unsigned long stack;
+	struct pollfd *p;
 	int err;
+	int l_write_sigio_fds[2];
+	int l_sigio_private[2];
+	int l_write_sigio_pid;
 
+	/* We call this *tons* of times - and most ones we must just fail. */
 	sigio_lock();
-	if(write_sigio_pid != -1)
-		goto out;
+	l_write_sigio_pid = write_sigio_pid;
+	sigio_unlock();
 
-	err = os_pipe(write_sigio_fds, 1, 1);
+	if (l_write_sigio_pid != -1)
+		return;
+
+	err = os_pipe(l_write_sigio_fds, 1, 1);
 	if(err < 0){
 		printk("write_sigio_workaround - os_pipe 1 failed, "
 		       "err = %d\n", -err);
-		goto out;
+		return;
 	}
-	err = os_pipe(sigio_private, 1, 1);
+	err = os_pipe(l_sigio_private, 1, 1);
 	if(err < 0){
-		printk("write_sigio_workaround - os_pipe 2 failed, "
+		printk("write_sigio_workaround - os_pipe 1 failed, "
 		       "err = %d\n", -err);
 		goto out_close1;
 	}
-	if(setup_initial_poll(sigio_private[1]))
+
+	p = setup_initial_poll(l_sigio_private[1]);
+	if(!p)
 		goto out_close2;
 
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL, 
+	sigio_lock();
+
+	/* Did we race? Don't try to optimize this, please, it's not so likely
+	 * to happen, and no more than once at the boot. */
+	if(write_sigio_pid != -1)
+		goto out_unlock;
+
+	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
 					    CLONE_FILES | CLONE_VM, &stack, 0);
 
-	if(write_sigio_pid < 0) goto out_close2;
+	if (write_sigio_pid < 0)
+		goto out_clear;
 
-	if(write_sigio_irq(write_sigio_fds[0])) 
+	if (write_sigio_irq(l_write_sigio_fds[0])) 
 		goto out_kill;
 
- out:
+	/* Success, finally. */
+	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
+	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
+
+	current_poll = ((struct pollfds) { .poll 	= p,
+					   .used 	= 1,
+					   .size 	= 1 });
+
 	sigio_unlock();
 	return;
 
  out_kill:
-	os_kill_process(write_sigio_pid, 1);
+	l_write_sigio_pid = write_sigio_pid;
 	write_sigio_pid = -1;
+	sigio_unlock();
+	/* Going to call waitpid, avoid holding the lock. */
+	os_kill_process(l_write_sigio_pid, 1);
+	goto out_free;
+
+ out_clear:
+	write_sigio_pid = -1;
+ out_unlock:
+	sigio_unlock();
+ out_free:
+	kfree(p);
  out_close2:
-	os_close_file(sigio_private[0]);
-	os_close_file(sigio_private[1]);
+	os_close_file(l_sigio_private[0]);
+	os_close_file(l_sigio_private[1]);
  out_close1:
-	os_close_file(write_sigio_fds[0]);
-	os_close_file(write_sigio_fds[1]);
-	sigio_unlock();
+	os_close_file(l_write_sigio_fds[0]);
+	os_close_file(l_write_sigio_fds[1]);
+	return;
 }
 
 int read_sigio_fd(int fd)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
