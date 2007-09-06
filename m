Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ITItm-0003Bu-J0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 08:04:02 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ITItl-0007Ud-IN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 08:04:02 -0700
Received: from cakers-MacBook-Pro.local (mothership.theshore.net
	[71.59.102.47])
	by www.theshore.net (8.13.6/8.9.1) with ESMTP id l86F3u0A021990
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 6 Sep 2007 11:03:57 -0400
Message-ID: <46E016D8.4000803@theshore.net>
Date: Thu, 06 Sep 2007 11:03:52 -0400
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: [uml-devel] init_new_context_skas - new_mm failed, errno = -24
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

2.6.22.6-um

init_new_context_skas - new_mm failed, errno = -24
init_new_context_skas - new_mm failed, errno = -24
init_new_context_skas - new_mm failed, errno = -24
Kernel panic - not syncing: switch_mm_skas - PTRACE_SWITCH_MM failed, 
errno = 9


EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
     Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
085dbdfc:  [<080818fb>] show_regs+0xeb/0x110
085dbe18:  [<0806b41c>] panic_exit+0x2c/0x50
085dbe28:  [<080973fe>] notifier_call_chain+0x3e/0x60
085dbe48:  [<080974dd>] __atomic_notifier_call_chain+0x2d/0x40
085dbe64:  [<0809751e>] atomic_notifier_call_chain+0x2e/0x40
085dbe80:  [<08087fd2>] panic+0x72/0x110
085dbe9c:  [<0807e85c>] switch_mm_skas+0x5c/0x60
085dbeb4:  [<084b98f4>] schedule+0x2b4/0x5a0
085dbf24:  [<0806837d>] default_idle+0x2d/0x30
085dbf38:  [<0806bc78>] init_idle_skas+0x28/0x30
085dbf48:  [<08068388>] cpu_idle+0x8/0x10
085dbf50:  [<084b92fb>] rest_init+0x5b/0x60
085dbf64:  [<0804889d>] start_kernel+0x1bd/0x220
085dbf84:  [<0806bcac>] start_kernel_proc+0x2c/0x40
085dbf90:  [<0807a190>] run_kernel_thread+0x50/0x60
085dbfcc:  [<0806b9fe>] new_thread_handler+0x7e/0xd0
085dbffc:  [<00000000>] _stext+0xf7fb7f4c/0xc

Is this cause by a still-too-low max_map_count value?

-Chris

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
