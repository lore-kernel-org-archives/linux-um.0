Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bcz4R-0003lg-NP for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 21:09:11 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bcz4P-0001sD-Tr for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 21:09:10 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1Bcz4M-0005ji-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Jun 2004 06:09:06 +0200
Received: from pd9e58a6e.dip.t-dialin.net ([217.229.138.110])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Jun 2004 06:09:06 +0200
Received: from skoehler by pd9e58a6e.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Jun 2004 06:09:06 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <cbavp0$nss$1@sea.gmane.org>
References: <20040621034434.GC2735@thump.bur.st>
	<20040622135044.GG25291@patrick.wattle.id.au>
	<200406222035.06782.blaisorblade_spam@yahoo.it>
	<20040623004832.GD18570@thump.bur.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <20040623004832.GD18570@thump.bur.st>
Subject: [uml-devel] Re: hostfs / current->fsuid
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
Date: Wed, 23 Jun 2004 06:09:08 +0200
To: user-mode-linux-devel@lists.sourceforge.net

> Yes, however NFS has a remarkable ability to fuck up locking more often
> than not (at least on linux)

beside that, i think that the network-protocol could have been designed 
much simpler and more firewall-friendly.

BTW: i am one of those, that think that NFS is faster than hostfs.
I cannot explain why, but i would guess, that - at least for parallel 
file-access - the networking-code required less context-switches, since 
the network-packets are perhaps queued before giving them to the 
host-system.

That's just a guess, so you may prove me wrong ;-)



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
