Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQoHe-0005HS-VB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 07:12:30 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQoHe-0006fV-6x for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 07:12:30 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
In-Reply-To: <04f101c43e05$ffcdea20$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0405201609240.7143-100000@filer.marasystems.com>
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
Date: Thu, 20 May 2004 16:12:10 +0200 (CEST)
To: roland <for_spam@gmx.de>
Cc: Laurent Vivier <LaurentVivier@wanadoo.fr>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 20 May 2004, roland wrote:

> if i run a getpid-loop inside one uml, the other uml`s behaviour becomes
> quite sluggish - this doesn`t seem to have a relation to laurents patch - i
> just recognized this for the first time, because i never did getpid-loops
> inside a uml. :)

I would suspect this is due to the high dependency on context switching by 
UML in system calls.. but I do not have a clearcut explanation.

What can be said is that applications running on the host is by far not as 
dependent on context switching responsiveness to "feel good", and a CPU 
hog in one UML does not cause any noticeable amount of extra context 
switches, not much different from a CPU hog on the host in terms of 
performance.

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
