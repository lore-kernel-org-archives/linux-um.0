Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp7hv-0008I0-LJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 08:20:23 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cp7hq-0005J4-Vm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 08:20:23 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131722.35838.blaisorblade@yahoo.it>
Subject: [uml-devel] Anyone running nested UMLs? It seem to work well enough...
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
Date: Thu, 13 Jan 2005 17:22:35 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Well, inside my 2.6.9-bs5 session, I compiled a kernel as little stress-test, 
it worked, and just for fun I tried running it (even if I didn't tune 
CONFIG_NEST_LEVEL)... well, to my biggest surprise, the nested UML was able 
to boot and work well enough.

A lot of "segmentation fault" messages appeared, but I expected that this 
feature wouldn't work at all... (and also I didn't tune CONFIG_NEST_LEVEL, as 
I said, and it makes sense that this causes the Segfaults). So it's nice to 
see this working.

However, is anybody using them? For which reasons?

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
