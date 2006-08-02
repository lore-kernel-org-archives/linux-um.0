Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G8IHD-0001b6-Ke for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 08:04:51 -0700
Received: from web25219.mail.ukl.yahoo.com ([217.146.176.205])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G8IHD-0004rh-0b
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 08:04:51 -0700
Message-ID: <20060802150443.99963.qmail@web25219.mail.ukl.yahoo.com>
Date: Wed, 2 Aug 2006 17:04:43 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <3A30AD378ECC6F41A4AC64F18E8B3F7F6E0A21@ala-mail04.corp.ad.wrs.com>
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
To: "Stephens, Allan" <allan.stephens@windriver.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

"Stephens, Allan" <allan.stephens@windriver.com> ha scritto: 

> Hi Paolo:
> 
> OK, let me take one more try at explaining what I've observed. 
> (And my
> apologies for making this whole issue more confusing than necessary
> ...
> I'm pretty inexperienced when it comes to detailing with the
> details of
> network interface operation.)
> 
> When I used "ethX=daemon", each interface I configured on a UML
> guest
> forwarded only the traffic that was destined for it to my network
> protocol software -- indicating that the uml_switch application was
> getting UML to filter things correctly.

Does it works corrently even with uml_switch -hub or not?

> When I used "ethX=mcast", each interface I configured on a UML
> guest
> forwarded all packets sent to the associated multicast group to my
> network protocol software
which I guess operates with raw sockets...
>, even though the interfaces were not
> configured as "promiscuous".

> The latter observation was the source of my original concern,
> causing me
> to ask "why doesn't UML mark the device as promiscuous if it is
> passing
> on all packets?".  Your subsequent explanations now make me think
> that I
> should have asked "why isn't UML filtering out the unwanted packets
> since the device isn't configured as promiscuous?".

> I just repeated my "ethX=mcast" testing to make sure I hadn't done
> something stupid, like configure both interfaces with the same MAC
> address, but I still see the same result.  This leads me to
> conclude
> that there is a real problem with the way UML is filtering packets
> on
> "ethX=mcast" interfaces.  Admittedly, I can circumvent this problem
> being by manually configuring the interfaces as promiscuous, but it
> still looks like a bug.

> Does this (finally) make sense?

Yes, it makes a lot of sense (in fact I'm forwarding this to
uml-devel); I have looked at the code but I don't see any really
_obvious_ difference. Everything depends on uml_switch -hub result,
which I'd like to see.

Thanks for your effort meanwhile!
Bye

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
