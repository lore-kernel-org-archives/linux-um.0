Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8ctD-0005F2-F5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 03:28:39 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D8ctB-0003D1-Ba
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 03:28:38 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1D8csi-00080d-CA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 12:28:08 +0100
Received: from naked.iki.fi ([62.142.249.112])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Mar 2005 12:28:08 +0100
Received: from naked by naked.iki.fi with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Mar 2005 12:28:08 +0100
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <87psya4btv.fsf@aka.i.naked.iki.fi>
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: tun/tap network throughput problem
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
Date: Tue, 08 Mar 2005 13:27:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Young Koh wrote:
> i found other postings discussing queues of tun/tap devices when
> packets are coming to UML kernel and between two UML machines. but i
> couldn't find posting about packets from UML to other machine, even
> though they are all related, it looks.
>
> anybody has any idea where packets are being dropped and how i can
> solve it?

Remember to check the packet drop readings from inside the UML kernel
as well as on all interfaces on the host side.

Since you are sending large packets, I would suggest making sure that
all involved interfaces have large enough txqueues.

You can monitor queue buildup by:

  watch -n1 tc -d -s qdisc show

There should be no places for silent drops in the packet handling
things - go around and try to find where the packets are dropping (or
being queued forever).

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
