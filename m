Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQatk-0003fC-Eg for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 16:54:56 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQatk-0007Py-3u
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 16:54:56 -0700
Message-Id: <200405200040.i4K0eYDt002107@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] /dev/fd/62: No such file or directory 
In-Reply-To: Your message of "Mon, 17 May 2004 22:16:16 +0200."
	<030101c43c4b$cf6bd1a0$2000000a@schlepptopp> 
References: <030101c43c4b$cf6bd1a0$2000000a@schlepptopp> 
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
Date: Wed, 19 May 2004 20:40:34 -0400
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

for_spam@gmx.de said:
> can anybody give me a hint, what`s the problem, and how to (probably)
> fix this ? 

Can you trace these back to the system call within which these happen?

Figuring out which command in which script causes it, and putting a strace
in front of it should do the trick.

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
