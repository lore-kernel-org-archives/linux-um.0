Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D14YV-0001XF-GB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Feb 2005 07:24:03 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D14YR-0005yJ-Q3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Feb 2005 07:24:03 -0800
Message-ID: <42121406.40901@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS-v8: RC2 released against 2.6.7 - 2.6.11-rc3-bk6
	kernels
References: <200502110411.35438.blaisorblade@yahoo.it>
	<169101c512ef$6c905850$0201a8c0@hawk>
	<170001c512f4$2c279940$0201a8c0@hawk>
In-Reply-To: <170001c512f4$2c279940$0201a8c0@hawk>
Content-Type: multipart/mixed; boundary="------------060904080003000101050904"
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
Date: Tue, 15 Feb 2005 16:23:50 +0100
To: "Christopher S. Aker" <caker@theshore.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060904080003000101050904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Christopher S. Aker wrote:
>>I just rolled a 2.6.11-rc4+cfq-ts-21 host kernel and I'll be testing this today.
> 
> 
> 2.6.11 doesn't seem to be ready for host duty yet:
> 
Yes. There is a bug in the v8-rc2 patch for 2.6.11
Try the attached fix, please.

       Bodo


To BlaisorBlade: I tested the v8-rc2 for 2.6.9, too. It works fine for me.

--------------060904080003000101050904
Content-Type: text/x-diff;
 name="skas-2.6.11-v8-rc2-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="skas-2.6.11-v8-rc2-fix.patch"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch fixes a bug in SKAS3 host patch v8-rc2 for 2.6.11,
that causes syscalls not to be intercepted, when PTRACE_SYSEMU
is used.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- linux-2.6.11-rc4/arch/i386/kernel/ptrace.c.orig	2005-02-15 15:33:26.000000000 +0100
+++ linux-2.6.11-rc4/arch/i386/kernel/ptrace.c	2005-02-15 15:58:18.000000000 +0100
@@ -802,7 +802,7 @@ int do_syscall_trace(struct pt_regs *reg
 	if (is_singlestep)
 		send_sigtrap(current, regs, 0);
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
 		return 0;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish

--------------060904080003000101050904--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
