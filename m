Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3KGj-0004pk-25	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Aug 2005 14:07:17 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3KGh-0003GH-PL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Aug 2005 14:07:17 -0700
Message-ID: <42FBBDF8.2020206@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Possible SKAS3 >= v8 bug
References: <42FB5D26.5020703@theshore.net>
In-Reply-To: <42FB5D26.5020703@theshore.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 11 Aug 2005 16:07:04 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Found this from in my remote syslog:

Unable to handle kernel paging request at virtual address 00002000
  printing eip:
00000000
*pde = 2a771001
Oops: 0000 [#1]
SMP
Modules linked in:
CPU:    2
EIP:    0200:[<00000000>]    Not tainted VLI
EFLAGS: 00010292   (2.6.11.11-1-bigmem)
EIP is at 0x0
eax: ef66b784   ebx: ef7ba000   ecx: ef60f540   edx: 00000000
esi: 00000001   edi: 00000000   ebp: ef7bbf14   esp: ef7bbf9c
ds: 007b   es: 007b   ss: 0068
Process 2.4.29-linode39 (pid: 11195, threadinfo=ef7ba000 task=ef60f540)
Stack: ef7bbfc4 ef7ba000 c0106fd7 00000005 be7ff890 c0104934 be7ff768 
be7ff760
        00000000 c0102639 be7ff768 00000000 40029d00 be7ff760 00000000 
be7ff928
        00000000 0000007b 0000007b 0000004e 40100fb1 00000073 00000246 
be7ff74c
Call Trace:
  [<c0106fd7>] do_syscall_trace+0x97/0x10e
  [<c0104934>] math_state_restore+0x24/0x40
  [<c0102639>] syscall_trace_entry+0x11/0x2a
Code:  Bad EIP value.

-Chris



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
