Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dgpu8-00068g-22	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 13:15:00 -0700
Received: from quack.cs.berkeley.edu ([128.32.132.234] helo=quack.quarl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dgpu6-00089I-Fy	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 13:14:59 -0700
Subject: Re: [uml-devel] hostfs permissions
References: <quack.20050609T2234.87is0msrl6@meow.quarl.org>
	<200506101803.21108.blaisorblade@yahoo.it>
From: Karl Chen <quarl@cs.berkeley.edu>
In-Reply-To: <200506101803.21108.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Fri, 10 Jun 2005 18:03:20 +0200")
Message-ID: <quack.20050610T1314.87aclyvuim@quack.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 10 Jun 2005 13:14:57 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>>>> On 2005-06-10 09:03 PDT, Blaisorblade  writes:
    >> Hostfs seems to make everything owned by root -- even files
    >> created by non-root users.
    Blaisorblade> So you are running uml as root?

    Blaisorblade> Or you are running UML as non-root but with
    Blaisorblade> hostfs as root filesystem? 

I'm running uml as non-root (that's part of the reason for using
UML, so I can do everything as non-root), and not using hostfs as
the root file system.  I just need to share one directory tree,
and some processes inside the uml need to run as non-root.

    Blaisorblade> 1) HUMFS, implementing the ideal behaviour below

Humfs looks promising; I'm investigating - thanks.

    >> I would be happy if there were uid and gid mount options as
    >> many other fs types have -- to treat all files in the
    >> entire mount as owned by a particular user/group.

    Blaisorblade> Well, I'm going to add those options to UML 2.6
    Blaisorblade> but I'll be able to work on this only next
    Blaisorblade> week... However this should not be too much
    Blaisorblade> work.

Great! Thanks!  Let me know if I can help with anything.

-- 
Karl 2005-06-10 13:06


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
