Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AUuDf-0007PO-47
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Dec 2003 12:49:03 -0800
Received: from osiris.silug.org ([64.240.156.225])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AUuDe-0002Ew-PC
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Dec 2003 12:49:02 -0800
From: Steven Pritchard <steve@silug.org>
Subject: Re: [uml-devel] linux-2.4.23
Message-ID: <20031212204855.GB632@osiris.silug.org>
References: <200312121917.05059.petschge@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312121917.05059.petschge@gmx.de>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Dec 2003 14:48:55 -0600
To: petschge@web.de
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Dec 12, 2003 at 07:17:05PM +0100, Patrick Kilian wrote:
> when trying to compile linux-2.4.23 from kernel.org patched with 
> uml_patch-2.4.22-uml6 I get the following error:
[...]
> binfmt_elf.c:806: macro `ELF_PLAT_INIT' used with too many (2) args

This was answered a week or two ago (by someone else).

--- include/asm-um/archparam-i386.h.orig	2003-12-06 20:36:55.000000000 -0600
+++ include/asm-um/archparam-i386.h	2003-12-06 20:51:59.000000000 -0600
@@ -23,7 +23,7 @@
 #define ELF_DATA        ELFDATA2LSB
 #define ELF_ARCH        EM_386
 
-#define ELF_PLAT_INIT(regs) do { \
+#define ELF_PLAT_INIT(regs, load_addr) do { \
 	PT_REGS_EBX(regs) = 0; \
 	PT_REGS_ECX(regs) = 0; \
 	PT_REGS_EDX(regs) = 0; \

Steve
-- 
Steven Pritchard - K&S Pritchard Enterprises, Inc.
Email: steve@kspei.com             http://www.kspei.com/
Phone: (618)398-7360               Mobile: (618)567-7320


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
