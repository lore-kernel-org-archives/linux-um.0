Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTJeQ-0000aw-T2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 05:06:22 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BTJeQ-0006C1-6I for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 05:06:22 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Re: [uml-user] Sources of entropy?
In-Reply-To: <084601c440d6$67d64090$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0405271356001.12161-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 27 May 2004 14:06:06 +0200 (CEST)
To: roland <for_spam@gmx.de>
Cc: Chris Snyder <csnyder@mvpsoft.com>, Jeff Dike <jdike@addtoit.com>, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

On Sun, 23 May 2004, roland wrote:

> afaik, uml still has a general problem with /dev/random entropy.
> please read:
> http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107914271712404&w=2
> 
> proxying /dev/random from the host sounds like a good solution.

Better yet to implement a /dev/random entropy source in UML using the host 
/dev/random..  it should be as simple as a kernel thread polling for write 
on the UML /dev/random, pulling entropy in from the host as needed.

But if it is possible to proxy devices then obviously the above can easily
be done in a normal user process, moving entropy from the proxied random
device to the UML random device.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
