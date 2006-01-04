Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuFjS-0006Ll-8d for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:42 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EuFjR-0007PC-TU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:42 -0800
Message-Id: <200601042152.k04Lq2fS009247@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/9] UML - capture printk output for mconsole stack
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
Date: Wed, 04 Jan 2006 16:52:02 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The stack command now sends the printk output back to the mconsole
client.  This is done by registering a special console for the
mconsole driver.  This receives all printk output.  Normally, it is
ignored, but when a stack command is issued, any printk output will
be sent back to the client.  
This will capture any printk output, whether it is stack output or
not, since we can't tell the difference.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-04 14:08:25.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-04 14:52:11.000000000 -0500
@@ -20,6 +20,7 @@
 #include "linux/namei.h"
 #include "linux/proc_fs.h"
 #include "linux/syscalls.h"
+#include "linux/console.h"
 #include "asm/irq.h"
 #include "asm/uaccess.h"
 #include "user_util.h"
@@ -480,6 +481,82 @@ void mconsole_sysrq(struct mc_request *r
 }
 #endif
 
+static DEFINE_SPINLOCK(console_lock);
+static LIST_HEAD(clients);
+static char console_buf[MCONSOLE_MAX_DATA];
+static int console_index = 0;
+
+static void console_write(struct console *console, const char *string,
+			  unsigned len)
+{
+	struct list_head *ele;
+	int n;
+
+	if(list_empty(&clients))
+		return;
+
+	while(1){
+		n = min(len, ARRAY_SIZE(console_buf) - console_index);
+		strncpy(&console_buf[console_index], string, n);
+		console_index += n;
+		string += n;
+		len -= n;
+		if(len == 0)
+			return;
+
+		list_for_each(ele, &clients){
+			struct mconsole_entry *entry;
+
+			entry = list_entry(ele, struct mconsole_entry, list);
+			mconsole_reply_len(&entry->request, console_buf,
+					   console_index, 0, 1);
+		}
+
+		console_index = 0;
+	}
+}
+
+static struct console mc_console = { .name	= "mc",
+				     .write	= console_write,
+				     .flags	= CON_PRINTBUFFER | CON_ENABLED,
+				     .index	= -1 };
+
+static int mc_add_console(void)
+{
+	register_console(&mc_console);
+	return 0;
+}
+
+late_initcall(mc_add_console);
+
+static void with_console(struct mc_request *req, void (*proc)(void *),
+			 void *arg)
+{
+	struct mconsole_entry entry;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&entry.list);
+	entry.request = *req;
+	list_add(&entry.list, &clients);
+	spin_lock_irqsave(&console_lock, flags);
+
+	(*proc)(arg);
+
+	mconsole_reply_len(req, console_buf, console_index, 0, 0);
+	console_index = 0;
+
+	spin_unlock_irqrestore(&console_lock, flags);
+	list_del(&entry.list);
+}
+
+static void stack_proc(void *arg)
+{
+	struct task_struct *from = current, *to = arg;
+
+	to->thread.saved_task = from;
+	switch_to(from, to, from);
+}
+
 /* Mconsole stack trace
  *  Added by Allan Graves, Jeff Dike
  *  Dumps a stacks registers to the linux console.
@@ -489,7 +566,7 @@ void do_stack(struct mc_request *req)
 {
         char *ptr = req->request.data;
         int pid_requested= -1;
-        struct task_struct *from = NULL;
+	struct task_struct *from = NULL;
 	struct task_struct *to = NULL;
 
         /* Would be nice:
@@ -507,17 +584,15 @@ void do_stack(struct mc_request *req)
                 return;
         }
 
-        from = current;
-        to = find_task_by_pid(pid_requested);
+	from = current;
 
+	to = find_task_by_pid(pid_requested);
         if((to == NULL) || (pid_requested == 0)) {
                 mconsole_reply(req, "Couldn't find that pid", 1, 0);
                 return;
         }
-        to->thread.saved_task = current;
 
-        switch_to(from, to, from);
-        mconsole_reply(req, "Stack Dumped to console and message log", 0, 0);
+	with_console(req, stack_proc, to);
 }
 
 void mconsole_stack(struct mc_request *req)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
