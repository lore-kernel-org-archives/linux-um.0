Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwROk-0005ot-Sj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 16:28:11 -0700
Received: from agminet01.oracle.com ([141.146.126.228])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HwROk-00019p-F2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 16:28:10 -0700
Date: Thu, 7 Jun 2007 16:27:33 -0700
From: Zach Brown <zach.brown@oracle.com>
Message-ID: <20070607232733.GM17082@mami.zabbo.net>
References: <20070531181923.GA9904@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070531181923.GA9904@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Syslets - Fix cachemiss_thread return value
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Mason <chris.mason@oracle.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, May 31, 2007 at 02:19:23PM -0400, Jeff Dike wrote:
> cachemiss_thread should explicitly return 0 or error instead of
> task_ret_reg(current) (which is -ENOSYS anyway) because
> async_thread_helper is careful to put the return value in eax anyway.

Here's the fix I came up with for this.  Untested (my test boxes are
busy doing some aio+syslet perf runs :)).  What do you guys think?

- z

- - -

async: return task_ret_reg() from async_cachemiss_loop()

When a thread blocks in __async_schedule() it finds a thread waiting in
async_cachemiss_loop() to return to userspace.  The return value of
async_cachemiss_loop() is propagated to userspace as the return code of the
call which the thread blocked in.

Previously this return code was hard-coded to 0 and -1, which worked fine for
the first syslet syscall APIs.  sys_io_submit() wants a different return call
convention when it uses syslets.  So cachemiss_thread() was changed to return
task_ret_reg(), sys_io_submit() would set it to the value it wanted returned to
userspace.

But this, by itself, was buggy.  The syslet syscall APIs didn't set
task_ret_reg() like sys_io_submit() did, so they got garbage returned.  Both
Jeff Dike and Chris Mason saw this in testing, though I was lucky enough to
have my returned garbage pass the tests I initially tried.  It also didn't
catch the other callers of async_cachemiss_loop() which would be returning to
userspace on behalf of calls which blocked in __async_schedule().  This would
be a problem, say, if people mixed sys_threadlet_on() and sys_io_submit() in
the same task.

So this patch fixes those up.

We always return task_ret_reg() from async_cachemiss_loop().  If we're
returning to the user's stack and IP instead of on behalf of a blocking call we
set task_ret_reg() to -1 and then return it.

__exec_atom() sets task_ret_reg() to NULL if there's a chance that it will
block while executing the syscall in the atom.

Signed-off-by: Zach Brown <zach.brown@oracle.com>

diff -r f0d8ee165e2e kernel/async.c
--- a/kernel/async.c	Thu Jun 07 14:32:31 2007 -0700
+++ b/kernel/async.c	Thu Jun 07 16:14:16 2007 -0700
@@ -206,6 +206,13 @@ static long __exec_atom(struct task_stru
 
 	if (unlikely(atom->nr >= atom->nr_syscalls))
 		return -ENOSYS;
+
+	/*
+	 * If the syslet goes asynchronous then we want the cachemiss
+	 * thread to return NULL to userspace on our behalf.
+	 */
+	if (likely(t->async_ready))
+		task_ret_reg(t) = 0;
 
 	ret = atom->call_table[atom->nr](atom->args[0], atom->args[1],
 					 atom->args[2], atom->args[3],
@@ -515,7 +522,22 @@ exec_atom(struct async_head *ah, struct 
 
 	return last_uatom;
 }
-
+/**
+ * async_cachemiss_loop - wait as a "cachemiss" thread
+ * @at:	this thread's async_thread in its task_struct
+ * @ah:	The async_head for this thread's group of threads
+ * @t:	this thread's task_struct
+ *
+ * Sleep as a ready async "cachemiss" thread.  If another thread in our
+ * async_head blocks then __async_schedule may block that thread and transfer
+ * its userspace over to us to return in to.
+ *
+ * Before threads get to __async_schedule() they set task_ret_reg() to the
+ * value that should be returned to userspace if they block.  We return it so
+ * that our caller can return it to userspace, either through the usual syscall
+ * return path or through the helper which cachemiss_thread() returns to after
+ * being created.
+ */
 long async_cachemiss_loop(struct async_thread *at, struct async_head *ah,
 			  struct task_struct *t)
 {
@@ -542,10 +564,13 @@ long async_cachemiss_loop(struct async_t
 		 */
 		set_task_stack_reg(t, at->user_stack);
 		task_ip_reg(t) = at->user_ip;
-
-		return -1;
-	}
-	return 0;
+		/*
+		 * We're not returning on behalf of some call, communicate
+		 * that.
+		 */
+		task_ret_reg(t) = -1;
+	}
+	return task_ret_reg(t);
 }
 
 struct cachemiss_args {
@@ -559,14 +584,6 @@ struct cachemiss_args {
  * first time: initialize, pick up the user stack/IP addresses from
  * the head and then execute the cachemiss loop. If the cachemiss
  * loop returns then we return back to user-space.
- *
- * Our return code overwrites the task_ret_reg() in ptregs in the assembly
- * stub which execution returns to before returning to userspace.  We may
- * be returning to userspace on behalf of an interrupted call which might
- * want us to return something specific to user space.  We return 
- * task_ret_reg() from this function so that the tasks we're returning
- * on behalf of can use it to pass return codes to userspace.  Perhaps
- * we shouldn't have the asm stub overwrite task_ret_reg() instead..
  */
 static long cachemiss_thread(void *data)
 {
@@ -606,8 +623,7 @@ static long cachemiss_thread(void *data)
 	}
 	complete(&ah->start_done);
 
-	async_cachemiss_loop(at, ah, t);
-	return task_ret_reg(t);
+	return async_cachemiss_loop(at, ah, t);
 }
 
 /**

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
