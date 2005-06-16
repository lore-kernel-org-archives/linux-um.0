Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dil9V-0006YH-Rt	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Jun 2005 20:34:49 -0700
Received: from quack.cs.berkeley.edu ([128.32.132.234] helo=quack.quarl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dil9U-0007fg-BY	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Jun 2005 20:34:49 -0700
From: Karl Chen <quarl@cs.berkeley.edu>
Message-ID: <quack.20050615T2034.878y1bx9d3@quack.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] cr/nl tty settings for serial lines
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
Date: Wed, 15 Jun 2005 20:34:48 -0700
To: User-Mode-Linux Devel List <user-mode-linux-devel@lists.sourceforge.net>


Hi, I'm connecting serial lines in the UML to file descriptors in
the host to pipe information out of my UML.  I'd like to get data
without carriage returns, but whatever stty settings I use, it
translates nl to crnl.  Any ideas?  Would I have to use pty + stty
on host input pty?  I'm kludging it s/\r\n/\n/g for now...


-- 
Karl 2005-06-15 20:27


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
