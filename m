Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWl0L-0006bF-B3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 16:27:29 -0800
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CWl0J-0003FO-Mb
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 16:27:29 -0800
Message-Id: <200411240242.iAO2gI7p006614@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML 2.4 shmem.c changes? panic w/ backtrace 
In-Reply-To: Your message of "Tue, 23 Nov 2004 11:01:57 EST."
	<41A35EF5.4080302@enterasys.com> 
References: <41A35EF5.4080302@enterasys.com> 
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
Date: Tue, 23 Nov 2004 21:42:18 -0500
To: "D. Bahi" <dbahi@enterasys.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

dbahi@enterasys.com said:
> i know things are hot and heavy in 2.6 but i hope somebody can spare a
> thought about this panic i'm struggling to understand. 

Is this easily reproduced?

The stack isn't ringing any bells with me, particularly since none of my code
appears on the stack until the bug has already happened.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
