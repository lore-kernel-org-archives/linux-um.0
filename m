Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEQP4-0006ad-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 01:44:42 -0800
Received: from bay2-dav35.bay2.hotmail.com ([65.54.246.92] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AEQOF-0001QA-Nn
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 28 Oct 2003 01:43:51 -0800
From: "James McMechan" <James_McMechan@hotmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000E_01C39CDF.0C3EFB00"
Message-ID: <BAY2-DAV35Jc0xvlUQ9000007e8@hotmail.com>
Subject: [uml-devel] short fixes for modules on 2.6.0-test
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 27 Oct 2003 23:07:09 -0800
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.

------=_NextPart_000_000E_01C39CDF.0C3EFB00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Some of these have appeared before,
but they still have not made mainline.
Oh well, thankfully the apply_alternatives
function works nicely as a nop, since if
we don't update the spinlock functions
all that happens is that it uses the old
unoptimized functions
------=_NextPart_000_000E_01C39CDF.0C3EFB00
Content-Type: application/octet-stream;
	name="mod-diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mod-diff"

diff -Nur uml-2.6.0-test8/arch/um/kernel/mem.c =
work-2.6.0-test8/arch/um/kernel/mem.c=0A=
--- uml-2.6.0-test8/arch/um/kernel/mem.c	2003-10-23 22:17:36.000000000 =
-0700=0A=
+++ work-2.6.0-test8/arch/um/kernel/mem.c	2003-10-25 09:11:53.000000000 =
-0700=0A=
@@ -686,6 +686,7 @@=0A=
 =0A=
 	return(region->start_pfn + (page - (struct page *) region->mem_map));=0A=
 }=0A=
+EXPORT_SYMBOL(page_to_pfn);=0A=
 =0A=
 struct mem_region *pfn_to_region(unsigned long pfn, int *index_out)=0A=
 {=0A=
diff -Nur uml-2.6.0-test8/arch/um/kernel/um_arch.c =
work-2.6.0-test8/arch/um/kernel/um_arch.c=0A=
--- uml-2.6.0-test8/arch/um/kernel/um_arch.c	2003-10-23 =
22:17:36.000000000 -0700=0A=
+++ work-2.6.0-test8/arch/um/kernel/um_arch.c	2003-10-25 =
07:51:25.000000000 -0700=0A=
@@ -415,6 +415,10 @@=0A=
 	check_sigio();=0A=
 }=0A=
 =0A=
+void apply_alternatives(void *start, void *end)=0A=
+{=0A=
+}=0A=
+=0A=
 /*=0A=
  * Overrides for Emacs so that we follow Linus's tabbing style.=0A=
  * Emacs will notice this stuff at the end of the file and automatically=0A=
diff -Nur uml-2.6.0-test8/include/asm-um/elf.h =
work-2.6.0-test8/include/asm-um/elf.h=0A=
--- uml-2.6.0-test8/include/asm-um/elf.h	2003-07-27 10:04:15.000000000 =
-0700=0A=
+++ work-2.6.0-test8/include/asm-um/elf.h	2003-10-23 22:38:20.000000000 =
-0700=0A=
@@ -15,4 +15,7 @@=0A=
 =0A=
 #define USE_ELF_CORE_DUMP=0A=
 =0A=
+#define R_386_32	1=0A=
+#define R_386_PC32	2=0A=
+=0A=
 #endif=0A=

------=_NextPart_000_000E_01C39CDF.0C3EFB00--


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
