Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrXyW-0004pp-Ta for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 01:15:16 -0700
Received: from sccrmhc13.comcast.net ([204.127.202.64])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BrXyW-0007Xr-JE for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 01:15:16 -0700
Message-ID: <410DF801.3040004@hevanet.com>
From: Matt Clay <mattclay@hevanet.com>
MIME-Version: 1.0
References: <200407280315.08207.alydar@users.sourceforge.net>
	<20040801155231.GA19648@ccure.user-mode-linux.org>
	<410D4E2A.8020704@hevanet.com> <200408020115.47228.allen@home0.com>
In-Reply-To: <200408020115.47228.allen@home0.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0 "
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
Date: Mon, 02 Aug 2004 01:14:57 -0700
To: Allen Chan <allen@home0.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, 260111@bugs.debian.org

Allen Chan wrote:
> After a little poking around, it appears that chan_kern.c and 
> chan_user.c have very different interpretations of what struct 
> termios should be . On my debian unstable system,

I updated my um/include/asm/arch/termbits.h to match the standard 60 byte 
termios struct, and this fixed the kernel hang during boot.  However, it did 
not make the random failures on calls to tcsetattr go away.

The result is that I sometimes get the following during boot:

<snip>
NET4: Linux TCP/IP 1.0 for NET4.0
                                  IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
<snip>

Instead of the correct output:

<snip>
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
<snip>

Notice the indented "IP Protocols"?  That's where tcsetattr failed.

  - Matt


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
