Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeUa4-00025D-9p for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Dec 2004 00:32:20 -0800
Received: from stoneport.math.uic.edu ([131.193.178.160])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CeUa3-0006Qv-Jl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Dec 2004 00:32:20 -0800
Message-ID: <20041215083241.57075.qmail@cr.yp.to>
From: "D. J. Bernstein" <djb@cr.yp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [local] [kill] uml-utilities 20030903 uml_net slip_down()
	fails to check permissions
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
Date: 15 Dec 2004 08:32:41 -0000
To: securesoftware@list.cr.yp.to, user-mode-linux-devel@lists.sourceforge.net

Danny Lungstrom, a student in my Fall 2004 UNIX Security Holes course,
has discovered that uml_net, when installed setuid root (as is normal),
allows any local user to type

   ./uml_net 4 slip down eth0

to take down the computer's Ethernet connection. The connection stays
down until the system administrator manually brings it back up. I'm
publishing this notice, but all the discovery credits should be assigned
to Lungstrom.

The underlying bug is that, in slip.c, slip_down() has no idea whether
the user is actually allowed to take down the specified interface.

---D. J. Bernstein, Associate Professor, Department of Mathematics,
Statistics, and Computer Science, University of Illinois at Chicago


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
