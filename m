Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPpZz-0005bq-HH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 13:55:39 -0800
Received: from smtp19.mail.bbt.yahoo.co.jp ([202.93.83.112])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CPpZx-00083a-Oc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 13:55:39 -0800
Message-ID: <418AA550.40309@yahoo.co.jp>
From: kaz <shigekazun@yahoo.co.jp>
MIME-Version: 1.0
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
	<418AA2B4.5090002@yahoo.co.jp>
In-Reply-To: <418AA2B4.5090002@yahoo.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Sorry. Re: SKAS3/2.6-V7 failed with 2.6.8.1
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
Date: Fri, 05 Nov 2004 06:55:28 +0900
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi,

kaz wrote:
> 
> host-skas3-2.6.9-v7.patch failed with 2.6.8.1.  The error message was as below;

Sorry.
host-skas3-2.6.7-v7.patch finely applied to 2.6.8.1.

$ cat ../host-skas3-2.6.7-v7.patch | patch -p1
patching file arch/i386/kernel/entry.S
patching file arch/i386/kernel/ptrace.c
patching file include/asm-i386/thread_info.h
patching file include/linux/ptrace.h
patching file kernel/fork.c
Hunk #1 succeeded at 1008 (offset -1 lines).
patching file include/linux/mm.h
Hunk #1 succeeded at 575 (offset 1 line).
Hunk #2 succeeded at 636 (offset 1 line).
patching file include/linux/proc_mm.h
patching file mm/Makefile
patching file mm/mmap.c
Hunk #1 succeeded at 736 (offset 11 lines).
Hunk #2 succeeded at 1006 (offset 18 lines).
patching file mm/mprotect.c
Hunk #3 succeeded at 217 (offset 6 lines).
Hunk #4 succeeded at 288 (offset 6 lines).
patching file mm/proc_mm.c
patching file arch/i386/Kconfig
Hunk #1 succeeded at 757 (offset 37 lines).
patching file arch/i386/kernel/ldt.c
patching file arch/i386/kernel/sys_i386.c
patching file include/asm-i386/desc.h
Hunk #1 succeeded at 124 (offset 1 line).
patching file include/asm-i386/ptrace.h
patching file include/asm-i386/mmu_context.h
patching file arch/um/include/skas_ptrace.h



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
