Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aweda-0005mj-Ai for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 01:50:30 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AweTg-0006wO-KI
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 01:40:16 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040227092656.GA12168@bytesex.org>
References: <20040226212655.GA5191@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226212655.GA5191@bytesex.org>
Subject: [uml-devel] Re: [patch] module symbol fix
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
Date: Fri, 27 Feb 2004 10:26:56 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Feb 26, 2004 at 10:26:55PM +0100, Gerd Knorr wrote:
>   Hi,
> 
> recent gcc versions need this one ...

Another one of this kind (without this gcc may optimizes away the static
declared but unreferenced stuff, resulting in initrd= and --help options
not working any more for example ...).

  Gerd

--- linux-um-2.6.3/arch/um/include/init.h.used	2004-02-27 09:34:57.874205081 +0100
+++ linux-um-2.6.3/arch/um/include/init.h	2004-02-27 09:44:32.415275725 +0100
@@ -40,9 +40,9 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#define __init          __attribute__ ((__section__ (".text.init")))
+#define __init          __attribute__ ((used,__section__ (".text.init")))
 #define __exit          __attribute__ ((unused, __section__(".text.exit")))
-#define __initdata      __attribute__ ((__section__ (".data.init")))
+#define __initdata      __attribute__ ((used,__section__ (".data.init")))
 
 #endif
 
@@ -94,11 +94,11 @@
  * Mark functions and data as being only used at initialization
  * or exit time.
  */
-#define __uml_init_setup	__attribute__ ((unused,__section__ (".uml.setup.init")))
-#define __uml_setup_help	__attribute__ ((unused,__section__ (".uml.help.init")))
-#define __uml_init_call		__attribute__ ((unused,__section__ (".uml.initcall.init")))
-#define __uml_postsetup_call	__attribute__ ((unused,__section__ (".uml.postsetup.init")))
-#define __uml_exit_call		__attribute__ ((unused,__section__ (".uml.exitcall.exit")))
+#define __uml_init_setup	__attribute__ ((used,__section__ (".uml.setup.init")))
+#define __uml_setup_help	__attribute__ ((used,__section__ (".uml.help.init")))
+#define __uml_init_call		__attribute__ ((used,__section__ (".uml.initcall.init")))
+#define __uml_postsetup_call	__attribute__ ((used,__section__ (".uml.postsetup.init")))
+#define __uml_exit_call		__attribute__ ((used,__section__ (".uml.exitcall.exit")))
 
 #endif /* _LINUX_UML_INIT_H */
 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
