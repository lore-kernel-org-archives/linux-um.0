Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTEAr-0007Gd-JQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 May 2004 23:15:29 -0700
Received: from ns.theshore.net ([216.156.129.65] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BTEAr-0003bu-6L for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 May 2004 23:15:29 -0700
Message-ID: <006f01c443b2$29434290$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Thu, 27 May 2004 01:16:30 -0500
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello Laurent,

Thanks you for the performance patches.  I'm looking forwarding to testing them,
but ran into a snag while patching 2.4.24-um.

http://perso.wanadoo.fr/laurent.vivier/UML/um-sysemu-2.4.24-1.patch

Looks like it's against 2.4.22.  The patch is somewhat mangled, but once I get
around the rejects, I still get...

Checking syscall emulation patch for ptrace...missing
Kernel panic: check_ptrace : child exited with status 0x100
In idle task - not syncing

...on a host that doesn't have the sysemu patch.  It does run correctly on a host
with the sysemu patch.  I believe the 2.4-um sysemu patch needs updating, because
a few months back when I tried your first set of patches I received the same
thing.

Care to post a more recent 2.4-um sysemu patch for UML?

Thanks!
-Chris



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
