Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5bXj-0007Re-TL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 19:53:43 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5bXf-0004Ay-6d
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 19:53:42 -0700
Message-Id: <200409100355.i8A3tNg1005671@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] crash with uml-2.6.8.1-um1 
In-Reply-To: Your message of "Thu, 02 Sep 2004 12:24:08 +0200."
	<4136F4C8.4040905@exse.net> 
References: <4136F4C8.4040905@exse.net> 
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
Date: Thu, 09 Sep 2004 23:55:23 -0400
To: Sebastian <seb@exse.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

seb@exse.net said:
> I know that this does not help to find the problem, what can I do ?
> How to produce a stacktrace ? 

Putting a breakpoint on panic and get a backtrace when it hits.

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
