Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWvOi-0004rY-3i
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 02:28:48 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWvOh-0007ms-Ma
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 02:28:47 -0800
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0312181036220.31295@earth>
Message-ID: <Pine.LNX.4.58.0312181122070.32554@earth>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
 <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>
  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
 <Pine.LNX.4.58.0312181036220.31295@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [patch] fix PTRACE_LDT, skas-fix-2.4.23-A0
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
Date: Thu, 18 Dec 2003 11:27:47 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>


the patch below (against the 2.4 host-skas patch) fixes a bug in the
PTRACE_LDT logic: when modifying the LDT of another MM, the new LDT must
not be loaded.

	Ingo

--- linux/arch/i386/kernel/ldt.c.orig	
+++ linux/arch/i386/kernel/ldt.c	
@@ -104,7 +104,8 @@ static int write_ldt(struct task_struct 
 		wmb();
 		mm->context.segments = segments;
 		mm->context.cpuvalid = 1UL << smp_processor_id();
-		load_LDT(mm);
+		if (current->active_mm == mm)
+			load_LDT(mm);
 	}
 
 	lp = (__u32 *) ((ldt_info.entry_number << 3) + (char *) mm->context.segments);


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
