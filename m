Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G8xZ0-0007cv-FC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Aug 2006 04:09:58 -0700
Received: from web25221.mail.ukl.yahoo.com ([217.146.176.207])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G8xYy-0001iQ-HZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Aug 2006 04:09:58 -0700
Message-ID: <20060804110949.78699.qmail@web25221.mail.ukl.yahoo.com>
Date: Fri, 4 Aug 2006 13:09:49 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20060803214501.GA5677@ccure.user-mode-linux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [uml-user] Promiscuous mode interface bug?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, "Stephens, Allan" <allan.stephens@windriver.com>
Cc: Paolo Giarrusso <blaisorblade@yahoo.it>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Thu, Aug 03, 2006 at 01:08:51PM -0700, Stephens, Allan wrote:
> > Where I think my confusion is arising is in the details of how
> the
> > filtering
> > controlled by the promiscuous setting is actually done.  If a
> packet
> > with 
> > the "wrong" destination address arrives at an interface, who
> checks to
> > see
> > whether the interface has been configured as promiscuous and
> > passes/discards it
> > accordingly?  I have naively assumed that this was handled in
> hardware
> > on the
> > NIC card in a real system, but is it really done by software?  

> Ah, a light goes on.  I believe that it is done on the card.

Yes, it is, you can set one (or even more, for special purposes) MAC
addresses to accept on a card or configure it as "no hardware
filtering done"; I've observed a network driver doing this, and I
think set_mac is the hook for this.

> > What I seem to
> > be
> > observing in my UML testing is that *nobody* is doing this
> filtering,
> > resulting in
> > unwanted packets being handed to my protocol (which sits directly
> on top
> > of the
> > Ethernet driver).  
> 
> And since UML doesn't have "cards", it may be that the driver
> should do the
> filtering at the bottom layer and it isn't.

I agree too; we may check however if the network stack implements
support for such "dumb" cards (probably by setting a flag) to avoid
coding it ourselves.

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
