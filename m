Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPNja-0006jC-CC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 11:57:34 -0800
Received: from w12a.httpserveur.net ([67.15.80.77]
	helo=websiteout12.httpserveur.net)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JPNjY-0003c5-1g
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 11:57:34 -0800
Message-ID: <47B34BA0.30006@club-internet.fr>
Date: Wed, 13 Feb 2008 20:57:20 +0100
From: clowncoder <vincent-perrier@club-internet.fr>
MIME-Version: 1.0
Subject: [uml-devel] g_timeout_add
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hello,
It seems that g_timeout_add glib timeouts are not accurate
when there is no gtk activity on an uml target.

This may be a glib problem since I cannot check
that it does not occur on my host.

When gtk events occur through mouse moves, then
the timeout is good (a 5 sec timeout) if no graphical
activity exists, the timeout takes an average of 12 sec,
even if there is console activity on the uml machine.

Sorry that my host has no gtk to double-check on a
physical machine.
Vincent Perrier

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
