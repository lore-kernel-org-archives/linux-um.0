Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrVAg-0003Fc-JN for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Aug 2004 22:15:38 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BrVAf-0005XX-Ub for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Aug 2004 22:15:38 -0700
From: Allen Chan <allen@home0.com>
References: <200407280315.08207.alydar@users.sourceforge.net>
	<20040801155231.GA19648@ccure.user-mode-linux.org>
	<410D4E2A.8020704@hevanet.com>
In-Reply-To: <410D4E2A.8020704@hevanet.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408020115.47228.allen@home0.com>
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
Date: Mon, 2 Aug 2004 01:15:46 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Matt Clay <mattclay@hevanet.com>, Jeff Dike <jdike@addtoit.com>, 260111@bugs.debian.org

After a little poking around, it appears that chan_kern.c and 
chan_user.c have very different interpretations of what struct 
termios should be . On my debian unstable system,

In chan_kern.c:
	sizeof(struct termios) == 36

In chan_user.c:
	sizeof(struct termios) == 60

It appears that the tcgetattr() and tcsetattr() calls are expecting 
pointers to structures of size 60, but are getting pointers to 
structures of size 36 instead when placed inside chan_kern.c.  On a 
tcgetattr() call, the next 24 bytes on the stack after the local 
structure become open game for memory corruption.  On a tcsetattr() 
call, actions may be taken based on 24 bytes worth of data which is 
likely to be garbage.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
