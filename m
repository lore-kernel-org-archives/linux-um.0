Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPm6M-0006fS-DH for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 10:40:34 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BPm6K-0002Lm-MB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 10:40:33 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040517172111.GA12321@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] fix fault handling
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
Date: Mon, 17 May 2004 19:21:11 +0200
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

skas has a design bug: PTRACE_FAULTINFO doesn't pass enougth
informations.  Specifically the trap_no is missing, so you
don't know for sure whenever the SIGSEGV was a page fault or
a general protection fault.  I think that should be fixed in
skas4 (where we'll break backward compatibility anyway).

For the time being I've tried to fix that with the patch below,
which makes the uml kernel pass through general protection SEGV
to the app and seems to have no ill side effects.

  Gerd

--- linux-2.6.5/arch/um/kernel/skas/process.c.segv	2004-05-14 18:40:36.155621129 +0200
+++ linux-2.6.5/arch/um/kernel/skas/process.c	2004-05-14 19:49:00.762159068 +0200
@@ -54,6 +54,17 @@
 		panic("handle_segv - PTRACE_FAULTINFO failed, errno = %d\n",
 		      errno);
 
+	if (!(fault.is_write & 4)) {
+		/*
+		    kernel fault -- likely that was general
+ 		    protection fault (trap_no = 13), not a
+		    page fault (trap_no = 14).  But we don't
+		    know for sure as PTRACE_FAULTINFO doesn't
+		    tell us :-/
+		*/
+		bad_segv(fault.addr, 0, fault.is_write);
+		return;
+	}
 	segv(fault.addr, 0, FAULT_WRITE(fault.is_write), 1, NULL);
 }
 


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
