Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dgc9b-0004wM-8s	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 22:34:03 -0700
Received: from quack.cs.berkeley.edu ([128.32.132.234] helo=quack.quarl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dgc9X-0006mB-J1	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 22:34:00 -0700
From: Karl Chen <quarl@cs.berkeley.edu>
Message-ID: <quack.20050609T2234.87is0msrl6@meow.quarl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] hostfs permissions
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
Date: Thu, 09 Jun 2005 22:34:13 -0700
To: user-mode-linux-devel@lists.sourceforge.net


Hi, I'm doing some large-scale security experiments on Debian
security.  I'm using UML to do the whole thing on a cluster.

Hostfs seems to make everything owned by root -- even files
created by non-root users.  I'm currently using 2.4.26-3 (Debian
package).  I found a few posts via Google mentioning a patch to
fix this, but no other information.  What is the modified behavior
of hostfs permissions?  Has this been integrated into a newer
version, or is it in cvs, or if not, are there plans to?

[I think the ideal behavior, if UML is running as non-root, would
be if there were a temporary mapping of ownership (e.g. so chown
works) -- but that would be a lot of work to implement.]

I would be happy if there were uid and gid mount options as many
other fs types have -- to treat all files in the entire mount as
owned by a particular user/group.

-- 
Karl 2005-06-09 22:10


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
