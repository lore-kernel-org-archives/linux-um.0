Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6y6N-0000s7-Ak for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Sep 2004 14:11:07 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C6y6K-0000Dn-Vi
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Sep 2004 14:11:07 -0700
Message-Id: <200409132214.i8DMEwL7003829@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] handle_trap - failed to wait at end of syscall 
In-Reply-To: Your message of "Mon, 13 Sep 2004 21:39:33 +0200."
	<200409132139.33256.blaisorblade_spam@yahoo.it> 
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<411CE23C.4070903@nortelnetworks.com>
	<4145BF3F.3090502@nortelnetworks.com>
	<200409132139.33256.blaisorblade_spam@yahoo.it> 
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
Date: Mon, 13 Sep 2004 18:14:58 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Joe Marzot <gmarzot@nortelnetworks.com>

blaisorblade_spam@yahoo.it said:
> However, it is not possible nor desirable to do this in CATCH_EINTR -
> retry if  errno == EINTR is a general rule valid in every Unix program
> ever, while this  is very specific to this call.
>
> do {
>    CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
> } while (WIFSTOPPED(status) && (STOPSIG(status) == SIGHUP)) 

I'd still like to understand exactly what's going on here.  UML interprets
a SIGHUP to itself as a "shut down now" command, while it should not see
SIGHUP from a terminal going away.

Figuring out why it is should point us at the correct fix.

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
