Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhupH-0001gT-C6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 15:56:03 -0700
Received: from fmmailgate04.web.de ([217.72.192.242])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhupF-00005K-52
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 15:56:03 -0700
Received: from web.de 
	by fmmailgate04.web.de (Postfix) with SMTP id B30D851B7432
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat,  5 Apr 2008 00:55:27 +0200 (CEST)
Date: Sat, 05 Apr 2008 00:55:26 +0200
Message-Id: <226197483@web.de>
MIME-Version: 1.0
From: devzero@web.de
Subject: [uml-devel] FW: cosmetic issue - segfault when uml kernel panics
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

sorry for crossposting, but this was meant for user-mode-linux-devel, not user-mode-linux-user



hi there, 

i never gave much about this, and iirc, it has always been like this - but it just came to my mind, so i`d like to give a comment here.

if you start uml just by executing ./linux, besides that kernel panic you get a rather long error message and a segmentation fault in the end.

just wondering if an end user should see that at all - is this inentional or is it just misbehaviour which not yet has been adressed ?

regards
roland



Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
console [mc-1] enabled
Couldn't stat "root_fs" : err = 2
Failed to initialize ubd device 0 :Couldn't determine size of device's file
VFS: Cannot open root device "98:0" or unknown-block(98,0)
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)

EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:bffde5f8 EFLAGS: 00000246
 Not tainted
EAX: 00000000 EBX: 00002a61 ECX: 00000013 EDX: 00002a61
ESI: 00002a5d EDI: 00000001 EBP: bffde61c DS: 007b ES: 007b
09c5ae70: [<08069a34>] show_regs+0xb4/0xb9
09c5ae9c: [<0805889f>] panic_exit+0x25/0x3b
09c5aeb0: [<0808478c>] notifier_call_chain+0x21/0x46
09c5aed0: [<08084827>] __atomic_notifier_call_chain+0x17/0x19
09c5aeec: [<0808483e>] atomic_notifier_call_chain+0x15/0x17
09c5af08: [<080705f6>] panic+0x52/0xdd
09c5af28: [<08049a59>] mount_block_root+0xf8/0x10e
09c5af7c: [<08049abb>] mount_root+0x4c/0x54
09c5afa0: [<08049bcf>] prepare_namespace+0x10c/0x133
09c5afa8: [<08049787>] kernel_init+0x68/0x71
09c5afb4: [<08063d25>] run_kernel_thread+0x37/0x42
09c5afe0: [<08056562>] new_thread_handler+0x57/0x7e
09c5affc: [<00000000>] 0x0

Segmentation fault
_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
