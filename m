Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cu45f-0007B0-9o for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 23:29:19 -0800
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cu45a-0007su-1f
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 23:29:19 -0800
Message-ID: <41F897D8.4010509@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Making sure 2.6.11-rc2-bk* works
References: <200501260038.13619.blaisorblade@yahoo.it>
In-Reply-To: <200501260038.13619.blaisorblade@yahoo.it>
Content-Type: multipart/mixed; boundary="------------010209020900020103030701"
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
Date: Thu, 27 Jan 2005 00:27:20 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010209020900020103030701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Blaisorblade wrote:
| Jeff, now we need actively to make sure everything we think is crucial is
| merged in 2.6.11 - release is approaching (after -rc2 only a handful of
| patches is being merged, and the announce says "Make sure I have
| everything"), so you should make sure to send Andrew anything needed
on top
| of 2.6.11-rc2-bk3 (I say the -bk tree on purpose, because that's what
becomes
| the real released tree) to make it compile.
<snip>

With a stable and working -um kernel in mind, here is a patch needed to
make 2.6.11-rc2-bk* compile (patch is against -bk4).  Without it, the
build fails with errors like "error: `__NR_vperfctr_open' undeclared
here (not in a function)"

I think we need to get this in soon if we want to make sure they get
into 2.6.11


This patch removes some invalid entries from the syscall table
(arch/um/kernel/sys_call_table.c), allowing ARCH=um to compile for
2.6.11-rc2-bk*

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+JfYaI0dwg4A47wRAmbCAJwKJ5k9Sghhxwjv3PJx3mYYNn6xQACgvbBV
d0p116AeQzwnizlnZSMiEHk=
=RJF2
-----END PGP SIGNATURE-----

--------------010209020900020103030701
Content-Type: text/plain;
 name="make_um_compile_for_2.6.11"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make_um_compile_for_2.6.11"

diff -Naur linux-2.6.11-rc2-bk4/arch/um/kernel/sys_call_table.c linux-2.6.11-rc2-bk4_fixed/arch/um/kernel/sys_call_table.c
--- linux-2.6.11-rc2-bk4/arch/um/kernel/sys_call_table.c	2005-01-26 23:51:51.000000000 -0700
+++ linux-2.6.11-rc2-bk4_fixed/arch/um/kernel/sys_call_table.c	2005-01-26 20:52:13.000000000 -0700
@@ -54,11 +54,6 @@
 extern syscall_handler_t sys_set_mempolicy;
 extern syscall_handler_t sys_sys_kexec_load;
 extern syscall_handler_t sys_sys_setaltroot;
-extern syscall_handler_t sys_vperfctr_open;
-extern syscall_handler_t sys_vperfctr_control;
-extern syscall_handler_t sys_vperfctr_unlink;
-extern syscall_handler_t sys_vperfctr_iresume;
-extern syscall_handler_t sys_vperfctr_read;
 
 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
@@ -281,11 +276,6 @@
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

--------------010209020900020103030701--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
