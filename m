Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bj1TK-00083e-Bv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jul 2004 12:55:50 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1Bj1TK-0000k7-4S
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jul 2004 12:55:50 -0700
Received: from tuxrocks.com (localhost.localdomain [127.0.0.1])
	by tuxrocks.com (8.12.10/8.12.8) with ESMTP id i69JtnVe020036
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 9 Jul 2004 13:55:49 -0600
Received: from localhost (frank@localhost)
	by tuxrocks.com (8.12.10/8.12.8/Submit) with ESMTP id i69Jtn8F020033
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 9 Jul 2004 13:55:49 -0600
From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-user] Re: [uml-devel] Fixing the 2.4 bugs - patches against
	2.4.24-1um
In-Reply-To: <200407081832.39138.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.60.0407091236400.18897@tuxrocks.com>
References: <200407012050.14867.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.58.0407071420550.9924@tuxrocks.com>
	<200407081832.39138.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Fri, 9 Jul 2004 13:55:48 -0600 (MDT)
To: user-mode-linux-devel@lists.sourceforge.net

On Thu, 8 Jul 2004, BlaisorBlade wrote:
> Yes, you are right. Compliments for that - I would have never seen such a
> panic (I understand you perfectly, but I missed it and would have missed it
> again). So thanks a lot for helping with it - I'll save that for when I'm
> back (I'm leaving now, so have no time at all to do anything). Your catch also
> means that UML will break without -DUM_FASTCALL, which is not nice: the buggy
> change you see has actually uncovered some other bug; if it weren't so, the
> bug you have fixed would only have hurted performance.

Correct.  I've verified that UML does break without -DUM_FASTCALL, even on 
the 'stable' 2.4.24-1um patch, so the problem was probably introduced at 
some point earlier.  Does anyone know the history behind UM_FASTCALL, its' 
effects, and when related modifications occurred?

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
