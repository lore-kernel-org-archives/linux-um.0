Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxTCC-0006g3-C7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 08:54:08 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CxTCA-0005kE-Mu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Feb 2005 08:54:08 -0800
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502051051.46242.rob@landley.net>
Subject: [uml-devel] [patch] Make User Mode Linux compile in 2.6.11-rc3
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
Date: Sat, 5 Feb 2005 10:51:45 -0500
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>

As of yesterday afternoon, the UML build still breaks in sys_call_table.c, 
here's the patch I submitted earlier (which got me past the break when I 
tried it).  Last week, this produced what seemed like a working UML.

Now there's a second break in mm/memory.c: the move to four level page
tables conflicts with a stub in our headers.  Not quite sure how to fix that.
Jeff?

(Yeah, I know Andrew's tree works.  But wouldn't it be nice if the kernel.org 
tree to worked too, before 2.6.11 release.)

Rob

----------  Forwarded Message  ----------

Subject: [uml-devel] [patch] Make User Mode Linux compile in 2.6.11-rc2-bk6.
Date: Saturday 29 January 2005 05:51 am
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

User Mode Linux doesn't compile in 2.6.11-rc2-bk6.  Here's the change I
made to sys_call_table.c to make it compile.  (I ran the result and brought
up a shell.)

We're really close to finally having a usable UML kernel in mainline.
2.6.9's ARCH=um built but was very unstable, 2.6.10 didn't even build
for me, but 2.6.11-rc1-mm2 builds fine unmodified, and ran my tests
correctly to completion.

Here's the patch.  Nothing fancy, it simply removes or stubs out all the
syscalls the compiler complains about.

Rob

Signed-off-by: Rob Landley <rob@landley.net>

--- linux-2.6.10/arch/um/kernel/sys_call_table.c	2005-01-28
 21:20:38.000000000 -0600 +++
 linux-2.6.10-um/arch/um/kernel/sys_call_table.c	2005-01-28
 21:40:30.735892144 -0600 @@ -20,7 +20,7 @@
 #define NFSSERVCTL sys_ni_syscall
 #endif

-#define LAST_GENERIC_SYSCALL __NR_vperfctr_read
+#define LAST_GENERIC_SYSCALL (NR_syscalls-1)

 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
 #define LAST_SYSCALL LAST_GENERIC_SYSCALL
@@ -52,13 +52,7 @@
 extern syscall_handler_t sys_mbind;
 extern syscall_handler_t sys_get_mempolicy;
 extern syscall_handler_t sys_set_mempolicy;
-extern syscall_handler_t sys_sys_kexec_load;
 extern syscall_handler_t sys_sys_setaltroot;
-extern syscall_handler_t sys_vperfctr_open;
-extern syscall_handler_t sys_vperfctr_control;
-extern syscall_handler_t sys_vperfctr_unlink;
-extern syscall_handler_t sys_vperfctr_iresume;
-extern syscall_handler_t sys_vperfctr_read;

 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
@@ -273,7 +267,7 @@
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
-	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load,
+	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
 #if 0
 	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
@@ -281,11 +275,6 @@
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
-	[ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open,
-	[ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control,
-	[ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink,
-	[ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume,
-	[ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,

 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] =


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
