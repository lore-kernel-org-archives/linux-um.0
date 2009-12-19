Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <clownix@clownix.net>) id 1NM7xN-0007NW-Mb
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Dec 2009 22:39:25 +0000
Received: from gateway10.websitewelcome.com ([67.18.14.12])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NM7xH-0001bT-8t for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Dec 2009 22:39:25 +0000
From: clownix <clownix@clownix.net>
Date: Sat, 19 Dec 2009 12:33:21 +0100
Message-Id: <1261222401.435.6.camel@localhost>
Mime-Version: 1.0
Subject: [uml-devel] linux-2.6.32 uml Segmentation fault
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>

Hello
For the 2.6.32 kernel there are 2 problems:

1: Compile error, this patch works for it:
--------------------------------------------

diff -Naur old_linux-2.6.32.1/security/keys/keyctl.c
linux-2.6.32.1/security/keys/keyctl.c
--- old_linux-2.6.32.1/security/keys/keyctl.c	2009-12-14
18:47:25.000000000 +0100
+++ linux-2.6.32.1/security/keys/keyctl.c	2009-12-15 22:40:32.565286766
+0100
@@ -1236,6 +1236,7 @@
  */
 long keyctl_session_to_parent(void)
 {
+#ifdef TIF_NOTIFY_RESUME 
 	struct task_struct *me, *parent;
 	const struct cred *mycred, *pcred;
 	struct cred *cred, *oldcred;
@@ -1326,6 +1327,9 @@
 error_keyring:
 	key_ref_put(keyring_r);
 	return ret;
+#else /* !TIF_NOTIFY_RESUME */ 
+       return -EOPNOTSUPP;
+#endif /* !TIF_NOTIFY_RESUME */ 
 }


2 A segfault during launch:
-----------------------------

Program received signal SIGSEGV, Segmentation fault.
0x0842487f in __libc_setup_tls ()
(gdb) bt
#0  0x0842487f in __libc_setup_tls ()
#1  0x08424a9a in __pthread_initialize_minimal ()
#2  0x08424525 in __libc_start_main ()
#3  0x08061021 in _start ()





------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

