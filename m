Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxUfz-0006px-9i for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 09:24:27 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AxUUj-0002S2-Hs for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 09:12:49 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402291817.31177.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] New Skas patch for 2.6 and SMP
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
Date: Sun, 29 Feb 2004 18:17:31 +0100
To: Sascha Rommelfangen <sascha.rommelfangen@gmx.de>, "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

I've uploaded a new SKAS patch on the site. Follow instructions on the 
homepage (http://www.user-mode-linux.org/~blaisorblade). It is against 2.6.3 
but applies cleanly on 2.6.0 and probably the kernels in between. It contains 
a change for CONFIG_SMP only, which I hope will solve the problems you get.

The change has been reviewed on uml-devel, however be careful with it - I do 
not have any SMP box to test it.

For UP kernels that patch carries no changes.

Hope It Works! Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
