Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B14KG-0001pH-3h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Mar 2004 06:04:48 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B13eR-0007WC-MG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Mar 2004 05:21:36 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040310133219.GC30984@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] dump core on panics
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
Date: Wed, 10 Mar 2004 14:32:19 +0100
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

New debugging feature: make the uml kernel dump core on panic
when booted with "core=1".

  Gerd

Index: linux-um-2.6.4-rc3/kernel/panic.c
===================================================================
--- linux-um-2.6.4-rc3.orig/kernel/panic.c	2004-03-10 09:21:29.172468194 +0100
+++ linux-um-2.6.4-rc3/kernel/panic.c	2004-03-10 11:52:31.646327958 +0100
@@ -37,6 +37,17 @@ static int __init panic_setup(char *str)
 }
 __setup("panic=", panic_setup);
 
+#ifdef __arch_um__
+extern void abort(void);
+static int dump_core = 0;
+static int __init dump_core_setup(char *str)
+{
+	dump_core = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+__setup("core=", dump_core_setup);
+#endif
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -60,6 +71,10 @@ NORET_TYPE void panic(const char * fmt, 
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	printk(KERN_EMERG "Kernel panic: %s\n",buf);
+#ifdef __arch_um__
+	if (dump_core)
+		abort();
+#endif
 	if (in_interrupt())
 		printk(KERN_EMERG "In interrupt handler - not syncing\n");
 	else if (!current->pid)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
