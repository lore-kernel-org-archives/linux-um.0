Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEA9c-0005Bi-Rp for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 10:28:12 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CEA8O-0007Wa-OE for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 10:28:12 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041003134313.E0FF4CC06@zion.localdomain>
Subject: [uml-devel] [patch 1/1] Uml: add generic ptrace requests
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
Date: Sun, 03 Oct 2004 15:43:13 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


When we don't know how to handle ptrace(2) calls, call the arch-independent
ptrace_request like i386 (and I guess other archs) do, instead of returning
-EIO.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/ptrace.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/ptrace.c~uml-add-generic-ptrace-requests arch/um/kernel/ptrace.c
--- linux-2.6.9-current/arch/um/kernel/ptrace.c~uml-add-generic-ptrace-requests	2004-10-03 15:41:12.023298992 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/ptrace.c	2004-10-03 15:41:12.026298536 +0200
@@ -287,7 +287,7 @@ int sys_ptrace(long request, long pid, l
 	}
 #endif
 	default:
-		ret = -EIO;
+		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
  out_tsk:
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
