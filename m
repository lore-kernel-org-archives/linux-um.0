Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3vv7-0004x2-Br for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 03:42:41 -0800
Received: from pegasus.hiit.fi ([212.68.1.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3vv5-0008T2-Ss for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 03:42:40 -0800
Received: from iki.fi (fortytwo.hiit.fi [212.68.5.83])
	by pegasus.hiit.fi (Postfix) with ESMTP id BB4EB220009
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 18 Mar 2004 13:42:28 +0200 (EET)
Message-ID: <40598B24.7040700@iki.fi>
From: Kristian Slavov <kristian.slavov@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Using GDB in debugging UML kernel (2.6)
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
Date: Thu, 18 Mar 2004 13:42:28 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I'm trying to debug my kernel code with UML and have run into couple of 
troubles. My host kernel is 2.6.3 patched with host-skas3-2.6.3-v1, the UML 
kernel is 2.6.3 with uml-patch-2.6.3-rc2-1. Both systems run Debian testing (sarge).

* GDB 5.3 with GCC 2.95

GDB does not recognize most of the structures. For example, try typing 'info 
types xfrm_state' (requires IPv6 + IPsec stuff compiled in kernel).
GDB will list many files. Some of them will show 'struct xfrm_state', most of 
them 'struct unknown'.
If I have a breakpoint in one of those file (that don't recognize the structure) 
I can't print the structure. I've tried 'print {struct xfrm_state *}variable' 
etc... but still nothing.
I don't really like to dump memory and try to interpret the structures manually.

* GDB 5.3 with GCC 3.3.3

info types xfrm_state shows the same files as above, but all of them now 
recognize the xfrm_state. The problem in this case is that GDB will only show me
one frame in the backtrace :( Not really useful having breakpoint in panic().

Actually I've exerienced this same behaviour with GCC-2.95 too. I changed -g to 
-ggdb in Linux makefiles. Perhaps GCC-3.3's -g is equal to GCC-2.95's -ggdb?

* GDB 6.0 with GCC 2.95 or 3.3.3

UML kernel does not send SIGTRAP at the beginning, or GDB ignores it. I checked 
info signal and the SIGTRAP's actions were 'stop, print, don't pass'. This is 
the same in both GDBs.

Now the actual question :)
What kind of setups do you use to debug UML? Do you have some ideas/suggestions 
to help me?

TIA
-- 
Kristian Slavov


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
