Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6cn2-0006Ms-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:21:12 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6cn0-0003qm-4t
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:21:10 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96LAij06634
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:10:49 -0400
Message-Id: <200310062122.h96LMeGj020779@ccure.karaya.com>
Subject: Re: [uml-devel] (no subject) 
In-Reply-To: Your message of "Thu, 25 Sep 2003 18:09:43 PDT."
             <40929.10.126.13.181.1064488183.squirrel@202.155.84.178> 
References: <40929.10.126.13.181.1064488183.squirrel@202.155.84.178> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 06 Oct 2003 17:22:39 -0400
To: kooper@inf.its-sby.edu
Cc: user-mode-linux-devel@lists.sourceforge.net

kooper@inf.its-sby.edu said:
> What i need to know is how process that is traced by UML is stopped
> when entering in kernel mode which is triggered by signal handling in
> UML kernel. Or process still running while executing signal handler..
> I dont know in which code i could find that...

Look at arch/um/kernel/skas/process.c.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
