Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTHw-0006Pk-9T	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:24 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DbTHv-0006t2-KW	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:24 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050527003837.DF9AD1AEE84@zion.home.lan>
Subject: [uml-devel] [patch 2/8] uml: add MOD_LICENSE to random driver
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
Date: Fri, 27 May 2005 02:38:37 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Add a MODULE_LICENSE("GPL") to the driver, remove some unused macros and
add the GPL license (it's GPL-licensed anyway since it's a GPL-derivative,
apart that Jeff Dike releases GPL software, in case anybody is wondering).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/drivers/random.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -puN arch/um/drivers/random.c~uml-random-mod-license arch/um/drivers/random.c
--- linux-2.6.12/arch/um/drivers/random.c~uml-random-mod-license	2005-05-02 15:45:03.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/random.c	2005-05-02 15:53:46.000000000 +0200
@@ -1,5 +1,10 @@
-/* Much of this ripped from hw_random.c */
-
+/* Copyright (C) 2005 Jeff Dike <jdike@addtoit.com> */
+/* Much of this ripped from drivers/char/hw_random.c, see there for other
+ * copyright.
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
+ */
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
@@ -12,8 +17,6 @@
  */
 #define RNG_VERSION "1.0.0"
 #define RNG_MODULE_NAME "random"
-#define RNG_DRIVER_NAME   RNG_MODULE_NAME " virtual driver " RNG_VERSION
-#define PFX RNG_MODULE_NAME ": "
 
 #define RNG_MISCDEV_MINOR		183 /* official */
 
@@ -98,7 +101,7 @@ static int __init rng_init (void)
 
 	err = misc_register (&rng_miscdev);
 	if (err) {
-		printk (KERN_ERR PFX "misc device register failed\n");
+		printk (KERN_ERR RNG_MODULE_NAME ": misc device register failed\n");
 		goto err_out_cleanup_hw;
 	}
 
@@ -120,3 +123,6 @@ static void __exit rng_cleanup (void)
 
 module_init (rng_init);
 module_exit (rng_cleanup);
+
+MODULE_DESCRIPTION("UML Host Random Number Generator (RNG) driver");
+MODULE_LICENSE("GPL");
_


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
