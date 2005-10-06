Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENOtq-0005Ql-Ms	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Oct 2005 23:06:38 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ENOtp-0006ZN-DO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Oct 2005 23:06:38 -0700
Received: from [192.168.1.4] (mothership.theshore.net [68.52.33.110])
	by www.theshore.net (8.12.9/8.9.1) with ESMTP id j9666WIB032658
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 6 Oct 2005 02:06:32 -0400
Message-ID: <4344BF5F.8000603@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] echo 0 > /proc/sysemu == failed to wait at end of syscall
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
Date: Thu, 06 Oct 2005 01:08:31 -0500
To: user-mode-linux-devel@lists.sourceforge.net

2.6.13.3-um

# echo 0 > /proc/sysemu

Kernel panic - not syncing: handle_trap - failed to wait at end of 
syscall, errno = 0, status = 2943


EIP: 0073:[<40129e18>] CPU: 0 Not tainted ESP: 007b:bfa14f6c EFLAGS: 
00000246
     Not tainted
EAX: ffffffda EBX: 00000001 ECX: 080e8c08 EDX: 00000002
ESI: 00000002 EDI: 00000000 EBP: bfa14f90 DS: 007b ES: 007b
8f4a7c10:  [<80048536>] notifier_call_chain+0x1e/0x38
8f4a7c30:  [<80037ea9>] panic+0x55/0x104
8f4a7c50:  [<80022163>] handle_trap+0xb3/0x114
8f4a7c80:  [<800224ce>] userspace+0x176/0x1b0
8f4a7cd0:  [<80023020>] force_flush_all_skas+0x24/0x28
8f4a7cf0:  [<80022afd>] fork_handler+0xbd/0xd0
8f4a7d00:  [<80022ae0>] fork_handler+0xa0/0xd0
8f4a7d20:  [<8032f638>] __restore+0x0/0x8
8f4a7d60:  [<8032f891>] kill+0x11/0x20

-Chris


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
