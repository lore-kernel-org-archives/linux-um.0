Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6q3n-0004Oz-Jx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 05:08:11 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D6q3l-0005VX-TW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 05:08:11 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1D6ppd-0001y7-Kr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 13:53:34 +0100
Received: from naked.iki.fi ([62.142.249.112])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 03 Mar 2005 13:53:33 +0100
Received: from naked by naked.iki.fi with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 03 Mar 2005 13:53:33 +0100
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <87hdjs6gmn.fsf@aka.i.naked.iki.fi>
References: <200503021553.14862.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: uml_switch security fixing
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
Date: Thu, 03 Mar 2005 14:47:12 +0200
To: user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it wrote:
> Suggestions?

FWIW, we have gone off using switch daemon entirely. We are using
simply preallocated tap devices, connected to bridges via normal Linux
bridging controls. Works cleaner and faster, more places to dump the
traffic from and it allows normal linux traffic queueing and
firewalling to be used to limit transfers between machines.

All physical networks and virtual network (networks not connected to
any physical interfaces) are implemented as bridges.

The only problem was the tap device queue hang (SIGIO problem), which
was resolved with the one queue option (and hopefully fixed in UML or
mainline kernel later).

-- Naked



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
