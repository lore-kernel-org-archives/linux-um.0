Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5bah-00081d-Lk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 19:56:47 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5ba5-0007jY-33
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 19:56:27 -0700
Message-Id: <200409100356.i8A3uQg1005723@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML hanging while deactivating swap 
In-Reply-To: Your message of "Fri, 03 Sep 2004 23:34:37 +0200."
	<chao0q$ajs$1@sea.gmane.org> 
References: <chao0q$ajs$1@sea.gmane.org> 
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
Date: Thu, 09 Sep 2004 23:56:26 -0400
To: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

skoehler@upb.de said:
> ubd1 of my UML is a swapfs, and when halting or rebooting it, it hangs
>  while the swap is deactivated (i guess swapoff -a is executed). 

Can you narrow it down within the shutdown process?  Adding -x to the #!
lines of the relevant scripts is a good way to do this.

Also, can you get a stack trace from UML?

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
