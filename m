Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlThJ-0006Rs-3Z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 05:56:09 -0800
Received: from thebsh.namesys.com ([212.16.7.65])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AlThI-0004hV-9w for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 05:56:08 -0800
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16406.28144.943056.461426@laputa.namesys.com>
Subject: [uml-devel] [PATCH]: 2.6.2-rc2: kill arch/um/sys-i386/extable.c
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
Date: Tue, 27 Jan 2004 16:56:00 +0300
To: Jeff Dike <JDike@Addtoit.COM>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello,

2.6.2-rc2 moved search_extable() into generic code (lib/extable.c), so
there is no need to duplicate i386's version in the UML.

Patch attached removes extable.c from the Makefile. extable.c itself is
easier to kill locally, than by patch. :)

Nikita.
===== arch/um/sys-i386/Makefile 1.16 vs edited =====
--- 1.16/arch/um/sys-i386/Makefile	Tue Jan 27 15:47:46 2004
+++ edited/arch/um/sys-i386/Makefile	Tue Jan 27 16:35:54 2004
@@ -1,4 +1,4 @@
-obj-y = bugs.o checksum.o extable.o fault.o ksyms.o ldt.o ptrace.o \
+obj-y = bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o \
 	ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o time.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
