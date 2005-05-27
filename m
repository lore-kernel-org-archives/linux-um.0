Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTIT-0006RT-0K	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:57 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DbTHz-0004oJ-At	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:56 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050527003846.909B81AEE8A@zion.home.lan>
Subject: [uml-devel] [patch 5/8] uml: fixlet for arch_prctl_skas
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
Date: Fri, 27 May 2005 02:38:46 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Fix it a bit (after some cross checking with "man arch_prctl"). There were:
*) typos FS/GS and back
*) FS in place of FS_BASE (and the same for GS)
*) the procedure used put_user on &addr, where addr was the parameter (i.e.
changed its param with put_user, completely useless) rather than interpreting
addr as a pointer, as requested in this case (see the man page).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/sys-x86_64/syscalls.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff -puN arch/um/sys-x86_64/syscalls.c~uml-fixlet-arch-prctl arch/um/sys-x86_64/syscalls.c
--- linux-2.6.git/arch/um/sys-x86_64/syscalls.c~uml-fixlet-arch-prctl	2005-05-25 01:13:20.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/syscalls.c	2005-05-25 01:14:05.000000000 +0200
@@ -133,23 +133,27 @@ static long arch_prctl_tt(int code, unsi
 
 #ifdef CONFIG_MODE_SKAS
 
+/* XXX: Must also call arch_prctl in the host, beside saving the segment bases! */
 static long arch_prctl_skas(int code, unsigned long addr)
 {
 	long ret = 0;
 
 	switch(code){
-	case ARCH_SET_GS:
-		current->thread.regs.regs.skas.regs[GS_BASE / sizeof(unsigned long)] = addr;
-		break;
 	case ARCH_SET_FS:
 		current->thread.regs.regs.skas.regs[FS_BASE / sizeof(unsigned long)] = addr;
 		break;
+	case ARCH_SET_GS:
+		current->thread.regs.regs.skas.regs[GS_BASE / sizeof(unsigned long)] = addr;
+		break;
 	case ARCH_GET_FS:
-		ret = put_user(current->thread.regs.regs.skas.regs[GS / sizeof(unsigned long)], &addr);
+		ret = put_user(current->thread.regs.regs.skas.
+				regs[FS_BASE / sizeof(unsigned long)],
+				(unsigned long __user *)addr);
 	        break;
 	case ARCH_GET_GS:
-		ret = put_user(current->thread.regs.regs.skas.regs[FS / sizeof(unsigned \
-long)], &addr);
+		ret = put_user(current->thread.regs.regs.skas.
+				regs[GS_BASE / sizeof(unsigned long)],
+				(unsigned long __user *)addr);
 	        break;
 	default:
 		ret = -EINVAL;
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
