Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTPMA-0007sn-8J for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 11:11:54 -0700
Received: from [47.81.138.65] (helo=zsc3s004.nortelnetworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTPM7-0000KI-4H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 11:11:51 -0700
Message-ID: <40B62F45.9000204@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] SKAS mode patch compatibility w/RH8 2.8.18-19.8.0 (Kernel
	panic: restore_registers - saving registers failed, errno = 3)
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
Date: Thu, 27 May 2004 14:11:17 -0400
To: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, Nuno Silva <nuno.silva@vgertech.com>

I am running the above combination on the host w/host-skas3a-RH8.patch 
(yes, feel bad for me as I can't change the host version - dictated by 
IT). For the guest I am running 2.4.24 w/uml-patch-2.4.24-1. I run both 
UP and SMP versions of the host.

I am getting

Kernel panic: restore_registers - saving registers failed, errno = 3

I am not sure if the ptrace patch has been applied to my host (how would 
I tell) but I am getting symptoms similar to those described below in a 
previous thread.

could it be that the SKAS patch is not happy with my host baseline?

I would like to try the 2.4.25 skas patch from 
http://www.user-mode-linux.org/~blaisorblade/ but not sure if that would 
help or hurt in my case...

Any words of wisdom appreciated.

regards, Giovanni


----------------------------------
List:       user-mode-linux-devel
Subject:    Re: [uml-devel] 2.4.20-4um Kernel panic: restore_registers - 
saving registers failed, errno = -1
From:       Matt Zimmerman <mdz () debian ! org>
Date:       2003-04-28 16:04:18
[Download message RAW]

On Mon, Apr 28, 2003 at 06:05:46PM +0200, Michael Koehne wrote:

 > Kernel panic: restore_registers - saving registers failed, errno = -1
 >
 >   the hosting system is Debian/Woody running 2.4.21-rc1+SKAS.

This is symptomatic of a host kernel which has the ptrace security patch +
skas (the former breaks the latter).  This is the case for the patch which
is in the 2.4.20-6 Debian sources; I do not know whether 2.4.21-rc1 is
different.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
