Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKfCR-0003X7-3O for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 08:17:43 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BKfCQ-0004Tn-Ex for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 08:17:42 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] UML kernel panic
In-Reply-To: <Pine.LNX.4.44.0405030903300.18483-100000@tuxrocks.com>
Message-ID: <Pine.LNX.4.44.0405031714130.15869-100000@filer.marasystems.com>
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
Date: Mon, 3 May 2004 17:17:13 +0200 (CEST)
To: Frank Sorenson <frank@tuxrocks.com>
Cc: Henrik Nordstrom <uml@henrik.marasystems.com>, roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 3 May 2004, Frank Sorenson wrote:

> The panics are "Segfault with no mm"
> 
> gdb backtraces can be found here:
> http://sco.tuxrocks.com/uml/trace6.txt
> http://sco.tuxrocks.com/uml/trace7.txt

Unfortunately both of these traces are incomplete and only shows what 
happened after the segfault, not where the segfault occurred.

But it does look like a UML problem. The reason to panic is a segfault 
while trying to resolve a VM page fault. But it would be interesting to 
know what/where triggered the first page fault.

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
