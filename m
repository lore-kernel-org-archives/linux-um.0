Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNxYH-00006T-By for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 10:29:53 -0700
Received: from [47.81.138.65] (helo=zsc3s004.nortelnetworks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BNxYH-0003NA-4T for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 10:29:53 -0700
Received: from zsc3c028.us.nortel.com (zsc3c028.us.nortel.com [47.81.138.28])
	by zsc3s004.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id i4CHTj607091
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 May 2004 10:29:45 -0700 (PDT)
Message-ID: <40A25F08.3060004@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040800090204080907060208"
Subject: [uml-devel] 2.4.24 Kernel panic (patch 2.4.24-1)
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
Date: Wed, 12 May 2004 13:29:44 -0400
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------040800090204080907060208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

<oops - forgot to attach the back trace>

The following has been seen for some time on an intermittent basis. less
than 1:20 runs. Having trouble debugging it so I added some code to
panic.c:panic() to abort() and dump core. Also attached is a back trace
from that.

Kernel panic: handle_trap - failed to wait at end of syscall, errno = 2,
status = 383

appreciate any tips or tricks to get more information about this problem.

I have a core if that helps.

regards, Giovanni

ps. The kernel I am running is slightly modified but I do not believe
that is related. I will look more on a vanilla kernel just to be sure.


--------------040800090204080907060208
Content-Type: text/plain;
 name="uml_kernel_panic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml_kernel_panic.txt"

(gdb) bt
#0  0xa01643d1 in kill ()
    at /localdisk/builds/3pc/2.4.22-i686sim/2.4.22/include/linux/if_vlan.h:122
#1  0xa018cbcb in raise ()
    at /localdisk/builds/3pc/2.4.22-i686sim/2.4.22/include/linux/if_vlan.h:122
#2  0xa01646bd in abort ()
    at /localdisk/builds/3pc/2.4.22-i686sim/2.4.22/include/linux/if_vlan.h:122
#3  0xa00d01d5 in handle_trap () at process.c:88
#4  0xa00d042c in userspace (regs=0xade0827c) at process.c:166
#5  0xa00d0bee in fork_handler (sig=10) at process_kern.c:102
#6  <signal handler called>
#7  0xa01643d1 in kill ()
    at /localdisk/builds/3pc/2.4.22-i686sim/2.4.22/include/linux/if_vlan.h:122
#8  0xa00d4728 in os_usr1_process (pid=Cannot access memory at address 0x8
) at process.c:95

--------------040800090204080907060208--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
