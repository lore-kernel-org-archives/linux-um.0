Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNxRM-0006qR-Jd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 10:22:44 -0700
Received: from zrc2s0jx.nortelnetworks.com ([47.103.122.112])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNxRM-00045d-65 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 10:22:44 -0700
Received: from zsc3c028.us.nortel.com (zsc3c028.us.nortel.com [47.81.138.28])
	by zrc2s0jx.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id i4CHMZ600438
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 May 2004 12:22:35 -0500 (CDT)
Message-ID: <40A25D59.1080802@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 12 May 2004 13:22:33 -0400
To: user-mode-linux-devel@lists.sourceforge.net

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



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
