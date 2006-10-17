Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZwT9-0001zM-D1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:27 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZwT6-0002UP-Qr
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:27 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 23:27:19 +0200
Message-Id: <20061017212719.26445.39606.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 08/10] uml: cleanup run_helper() API to fix a leak
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
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Freeing the stack is left uselessly to the caller of run_helper in some cases -
this is taken from run_helper_thread, but here it is useless, so no caller needs
it and the only place where this happens has a potential leak - in case of error
neither run_helper() nor xterm_open() call free_stack().
At this point passing a pointer is not needed - the stack pointer should be passed
directly, but this change is not done here.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/xterm.c   |    2 --
 arch/um/os-Linux/helper.c |    7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index 386f8b9..850221d 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -136,8 +136,6 @@ int xterm_open(int input, int output, in
 		return(pid);
 	}
 
-	if(data->stack == 0) free_stack(stack, 0);
-
 	if (data->direct_rcv) {
 		new = os_rcv_fd(fd, &data->helper_pid);
 	} else {
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index e887179..c316dfc 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -52,7 +52,8 @@ static int helper_child(void *arg)
 }
 
 /* Returns either the pid of the child process we run or -E* on failure.
- * XXX The alloc_stack here breaks if this is called in the tracing thread */
+ * XXX The alloc_stack here breaks if this is called in the tracing thread, so
+ * we need to receive a preallocated stack (a local buffer is ok). */
 int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv,
 	       unsigned long *stack_out)
 {
@@ -118,10 +119,8 @@ out_close:
 		close(fds[1]);
 	close(fds[0]);
 out_free:
-	if (stack_out == NULL)
+	if ((stack_out == NULL) || (*stack_out == 0))
 		free_stack(stack, 0);
-	else
-		*stack_out = stack;
 	return ret;
 }
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
