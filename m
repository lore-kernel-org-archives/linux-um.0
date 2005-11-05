Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYCQL-0000C0-6F for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 17:00:49 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EYCQI-0002EG-Ud
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 17:00:49 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jA52XVIp022186
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 4 Nov 2005 21:33:31 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511041900.37782.rob@landley.net>
Subject: [uml-devel] The web page doesn't say where to get the switch daemon.
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
Date: Fri, 4 Nov 2005 19:00:37 -0600
To: user-mode-linux-devel@lists.sourceforge.net

It's not on the networking page, or in the howto, it's not in the kernel 
tarball, and the download page just links to 
http://user-mode-linux.sourceforge.net/networking.html#switch

Let's see, the uml_net link from the download page (the difference between 
that and uml_switch is...?) links to a generic page about CVS, which isn't 
installed on my laptop.  (Subversion is, but doesn't help here.)  Ok, a web 
browsing link...  No tarball.  Ok, maybe it's one source file I can get and 
compile, ala ifenslave...

http://cvs.sourceforge.net/viewcvs.py/user-mode-linux/tools/net/

Ok, so:

A) None of the files in this directory have changed in over four years, yet 
there is no tarball.

B) None of them is obviously the switch daemon.

I think I'll put UML networking back on the TODO list and go do something 
else...

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
