Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CybAz-0004QK-Hd for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 11:37:33 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CybAy-0001en-19
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 11:37:33 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Cyb9P-00068c-Qi for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 20:35:55 +0100
Received: from naked.iki.fi ([62.142.249.112])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Feb 2005 20:35:55 +0100
Received: from naked by naked.iki.fi with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Feb 2005 20:35:55 +0100
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <87zmyej125.fsf@aka.i.naked.iki.fi>
References: <87hdks5y35.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: UML tuntap driver problem with queueing
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
Date: Tue, 08 Feb 2005 21:37:06 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Nuutti Kotivuori wrote:
> As a workaround to the problem, I've added the IFF_ONE_QUEUE option
> to all the places that open a tap device (namely tunctl, uml_net and
> uml_router). The patch is attached. But the actual problem should
> most likely be fixed once found.

Just a heads up here to the UML folks in case it was missed - with the
current code, packet delivery to UML machines using tuntap driver
*will* mess up (stall totally or major bursts of lag) if more than 10
packets are queued to UML at a time.

This will happen if Linux reassembles packets (connection tracking is
enabled) and a packet of around 17000 bytes or more arrives, or if UML
is given packets faster than it can handle them (not very likely to
happen if the packets are received from a 100Mbit network, and not
generated locally, unless there is heavy load on the machine).

So this is a real problem, for which the patch given is a decent
workaround, as it works perfectly and only changes things if one
employs QoS on the tap device itself.

Ofcourse, the actual cause for this should be fixed (SIGIO mess up or
whatever it is).

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
