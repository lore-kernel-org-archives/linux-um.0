Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8T0P-00059d-5U for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 17:23:09 -0700
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C8T0L-0004IC-Lz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 17:23:09 -0700
Received: from localhost ([127.0.0.1] ident=adam)
	by gradall.private.brainfood.com with esmtp (Exim 3.36 #1 (Debian))
	id 1C8T0J-0001FV-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 Sep 2004 19:23:03 -0500
From: Adam Heath <doogie@brainfood.com>
Message-ID: <Pine.LNX.4.58.0409171920470.1171@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] uml, ptrace, and BKL
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
Date: Fri, 17 Sep 2004 19:23:01 -0500 (CDT)
To: user-mode-linux-devel@lists.sourceforge.net

So, LWN had an article this week in their kernel section about parts of the
kernel still using the BKL.  I did a little grepping, and to my surprise,
sys_ptrace() uses the BKL.

What this means to UML, is that there is an upper-bounds on how many instances
can be on a server at once.  BKL also keeps preemption from occuring.

If someone were to look into that, UML could be sped up quite a bit, I am
thinking.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
