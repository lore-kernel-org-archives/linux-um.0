Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMJP4-0000Sb-GP	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 23:02:22 -0700
Received: from xproxy.gmail.com ([66.249.82.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EMJP1-0001ss-S5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 23:02:22 -0700
Received: by xproxy.gmail.com with SMTP id s7so156843wxc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 02 Oct 2005 23:02:13 -0700 (PDT)
Message-ID: <2accc2ff0510022302i427f5730w56c3d0c28f7ff201@mail.gmail.com>
From: Nelson Castillo <nelsoneci@gmail.com>
Reply-To: Nelson Castillo <nelsoneci@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14000_16696091.1128319333288"
Subject: [uml-devel] Using __initcall from um/drivers/chan_kern.c / fun with
	keyboard
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
Date: Mon, 3 Oct 2005 01:02:13 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Linux en-Caja <linuxencaja@googlegroups.com>

------=_Part_14000_16696091.1128319333288
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, I'm sending a patch that allows me to query the
number of keys pressed by the user (I'll copy [4]).

Actually, I'm counting scancodes and some keys
send more than one.

It works well.

--------------
# cat /proc/keystrokes
29
--------------

I read [1] and skimmed over [2] and I think I'm using
the __init and __initcall macros well, but I get this
error when I try to use them:

CC      arch/um/drivers/chan_kern.o
arch/um/drivers/chan_kern.c:111: error: `proc_kst_init' undeclared
here (not in a function)
arch/um/drivers/chan_kern.c:98: warning: `proc_kts_init' defined but not us=
ed
make[1]: *** [arch/um/drivers/chan_kern.o] Error 1
make: *** [arch/um/drivers] Error 2

98   : static int __init proc_kts_init(void)
99   : {

111 : __initcall(proc_kst_init);

What should I do/try?

Can I use these macros in um/drivers/chan_kern.c?

Related questions:

* Is there a better place to to this in UML?

* What would be the right place to do in
   ix86 (or arch independant)?

  Blaisorblade told me to it in serio[3], but I don't know
  where I should put the hooks. I think I can also use
  drivers/char/keyboard.c

[1]http://people.netfilter.org/~rusty/unreliable-guides/kernel-hacking/rout=
ines-init-again.html
[2]http://geek.vtnet.ca/doc/initcall/review.html
[3]http://marc.theaimsgroup.com/?l=3Duser-mode-linux-user&m=3D1128274783076=
26&w=3D2
[4]http://bodq.vstu.edu.ua/activity/data/k.html

--
Homepage : http://geocities.com/arhuaco

The first principle is that you must not fool yourself
and you are the easiest person to fool.
     -- Richard Feynman.

------=_Part_14000_16696091.1128319333288
Content-Type: text/x-patch; name=config_proc_keystrokes.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config_proc_keystrokes.patch"

diff -u linux-2.6.13.2.orig/arch/um/drivers/chan_kern.c linux-2.6.13.2/arch/um/drivers/chan_kern.c
--- linux-2.6.13.2.orig/arch/um/drivers/chan_kern.c	2005-09-16 20:02:12.000000000 -0500
+++ linux-2.6.13.2/arch/um/drivers/chan_kern.c	2005-10-03 00:22:14.000000000 -0500
@@ -19,6 +19,101 @@
 #include "line.h"
 #include "os.h"
 
+#define CONFIG_PROC_KSTROKES
+
+/*
+ * I'm trying to learn how to intercept keyboard keystrokes in
+ * Linux. I want to gather some statistics. 
+ *
+ * For instance, a count of each pressed key (A-Z). I guess I will
+ * have to do ( counter % 100) on each counter for security reasons.
+ * 
+ * Arhuaco. Oct 2 / 2005.
+ */
+
+#ifdef CONFIG_PROC_KSTROKES
+
+#define KST_DEBUG 1
+#define KST_LOG_LEN 32
+
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h> 
+
+/*
+ * Do we need this to use __init and __initcall?
+ * #include <linux/module.h>  */ 
+
+unsigned int kst_count = 0;
+
+#if KST_DEBUG 
+char kst_log[KST_LOG_LEN];
+int  kst_actual = 0;
+#endif
+
+static int proc_kst_show(struct seq_file *m, void *v)
+{
+  #if KST_DEBUG 
+    int error = 0;
+    int i;
+
+    error =
+  #endif
+
+  seq_printf(m, "%d\n", kst_count);
+
+  #if KST_DEBUG 
+
+  for (i = 0; !error && i < KST_LOG_LEN; i++)
+  {
+    if (i)
+      error = seq_putc(m, ' ');
+
+    if (!error)
+      error = seq_printf(m, "%x", kst_log[i]);
+  }
+
+  if (!error)
+    seq_printf(m, "\nactual %d\n", kst_actual);
+
+  #endif
+
+  return 0;
+}
+
+static int proc_kst_open(struct inode *inode, struct file *file)
+{
+  return single_open(file, proc_kst_show, NULL);
+}
+
+static struct file_operations proc_kst_operations = {
+  .open     = proc_kst_open,
+  .read     = seq_read,
+  .llseek   = seq_lseek,
+  .release  = single_release,
+};
+
+
+static int /*__init*/ proc_kts_init(void)
+{
+  struct proc_dir_entry *e;
+
+  e = create_proc_entry("keystrokes", 0, NULL);
+
+  if (e)
+    e->proc_fops = &proc_kst_operations;
+  else
+    printk(KERN_ERR "chan_kern.c : /proc/keystrokes creation failed \n");
+
+  return 0;
+}
+
+/* __initcall(proc_kst_init);  <<== Make it work */
+
+int kst_did_init = 0;
+
+#endif /* CONFIG_PROC_KSTROKES */
+
 #ifdef CONFIG_NOCONFIG_CHAN
 
 /* The printk's here are wrong because we are complaining that there is no
@@ -113,6 +208,22 @@
 		return(0);
 	else if(n == 0)
 		return(-EIO);
+
+#ifdef CONFIG_PROC_KSTROKES
+  kst_count ++;
+
+  if (!kst_did_init) /* TODO: use __initcall */
+  {        
+    proc_kts_init();
+    kst_did_init = 1;
+  }
+  
+  #if KST_DEBUG 
+    kst_log[kst_actual] = *c_out;
+    kst_actual          = (kst_actual + 1) % KST_LOG_LEN;
+  #endif
+#endif
+
 	return(n);
 }
 


------=_Part_14000_16696091.1128319333288
Content-Type: text/x-patch; 
	name=config_proc_keystrokes__initcall-not-working.patch; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config_proc_keystrokes__initcall-not-working.patch"

--- linux-2.6.13.2.orig/arch/um/drivers/chan_kern.c	2005-09-16 20:02:12.000000000 -0500
+++ linux-2.6.13.2/arch/um/drivers/chan_kern.c	2005-10-03 00:57:26.000000000 -0500
@@ -19,6 +19,99 @@
 #include "line.h"
 #include "os.h"
 
+#define CONFIG_PROC_KSTROKES
+
+/*
+ * I'm trying to learn how to intercept keyboard keystrokes in
+ * Linux. I want to gather some statistics. 
+ *
+ * For instance, a count of each pressed key (A-Z). I guess I will
+ * have to do ( counter % 100) on each counter for security reasons.
+ * 
+ * Arhuaco. Oct 2 / 2005.
+ */
+
+#ifdef CONFIG_PROC_KSTROKES
+
+#define KST_DEBUG 1
+#define KST_LOG_LEN 32
+
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h> 
+
+/*
+ * Do we need this to use __init and __initcall?
+ * #include <linux/module.h>  */ 
+
+unsigned int kst_count = 0;
+
+#if KST_DEBUG 
+char kst_log[KST_LOG_LEN];
+int  kst_actual = 0;
+#endif
+
+static int proc_kst_show(struct seq_file *m, void *v)
+{
+  #if KST_DEBUG 
+    int error = 0;
+    int i;
+
+    error =
+  #endif
+
+  seq_printf(m, "%d\n", kst_count);
+
+  #if KST_DEBUG 
+
+  for (i = 0; !error && i < KST_LOG_LEN; i++)
+  {
+    if (i)
+      error = seq_putc(m, ' ');
+
+    if (!error)
+      error = seq_printf(m, "%x", kst_log[i]);
+  }
+
+  if (!error)
+    seq_printf(m, "\nactual %d\n", kst_actual);
+
+  #endif
+
+  return 0;
+}
+
+static int proc_kst_open(struct inode *inode, struct file *file)
+{
+  return single_open(file, proc_kst_show, NULL);
+}
+
+static struct file_operations proc_kst_operations = {
+  .open     = proc_kst_open,
+  .read     = seq_read,
+  .llseek   = seq_lseek,
+  .release  = single_release,
+};
+
+
+static int __init proc_kts_init(void)
+{
+  struct proc_dir_entry *e;
+
+  e = create_proc_entry("keystrokes", 0, NULL);
+
+  if (e)
+    e->proc_fops = &proc_kst_operations;
+  else
+    printk(KERN_ERR "chan_kern.c : /proc/keystrokes creation failed \n");
+
+  return 0;
+}
+
+__initcall(proc_kst_init);
+
+#endif /* CONFIG_PROC_KSTROKES */
+
 #ifdef CONFIG_NOCONFIG_CHAN
 
 /* The printk's here are wrong because we are complaining that there is no
@@ -113,6 +206,16 @@
 		return(0);
 	else if(n == 0)
 		return(-EIO);
+
+#ifdef CONFIG_PROC_KSTROKES
+  kst_count ++;
+
+  #if KST_DEBUG 
+    kst_log[kst_actual] = *c_out;
+    kst_actual          = (kst_actual + 1) % KST_LOG_LEN;
+  #endif
+#endif
+
 	return(n);
 }
 

------=_Part_14000_16696091.1128319333288--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
