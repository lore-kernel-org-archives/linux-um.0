Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKon9-0005hI-Vx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 18:32:15 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BKon9-0007k4-F3
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 18:32:15 -0700
Message-Id: <200405040215.i442FAml026592@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML kernel panic 
In-Reply-To: Your message of "Sat, 01 May 2004 14:49:46 MDT."
	<Pine.LNX.4.44.0405011439220.30233-100000@tuxrocks.com> 
References: <Pine.LNX.4.44.0405011439220.30233-100000@tuxrocks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 03 May 2004 22:15:10 -0400
To: Frank Sorenson <frank@tuxrocks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

frank@tuxrocks.com said:
> I'm getting a UML kernel panic whenever I run the j2eesdk (Java with
> EJB - http://java.sun.com/j2ee/1.4/download.html#sdk) installer.  The
> panic is  "Segfault with no mm". 

Can you disable CONFIG_GCOV and see if that makes the problem go away?  And
mentioning that you had enabled it would have been a good idea.

This is still a bug, but I'd like to make sure that this is the cause.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
