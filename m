Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Fri, 4 Aug 2006 09:01:21 -0400 (EDT)
From: Steven James <pyro@linuxlabs.com>
In-Reply-To: <20060803214501.GA5677@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.63.0608040840520.5542@localhost.localdomain>
References: <3A30AD378ECC6F41A4AC64F18E8B3F7F6E0F66@ala-mail04.corp.ad.wrs.com>
	<20060803214501.GA5677@ccure.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Paolo Giarrusso <blaisorblade@yahoo.it>, "Stephens,  Allan" <allan.stephens@windriver.com>, user-mode-linux-user@lists.sourceforge.net


On Thu, 3 Aug 2006, Jeff Dike wrote:

> On Thu, Aug 03, 2006 at 01:08:51PM -0700, Stephens, Allan wrote:
>> Where I think my confusion is arising is in the details of how the
>> filtering
>> controlled by the promiscuous setting is actually done.  If a packet
>> with
>> the "wrong" destination address arrives at an interface, who checks to
>> see
>> whether the interface has been configured as promiscuous and
>> passes/discards it
>> accordingly?  I have naively assumed that this was handled in hardware
>> on the
>> NIC card in a real system, but is it really done by software?
>
> Ah, a light goes on.  I believe that it is done on the card.
>
>> What I seem to
>> be
>> observing in my UML testing is that *nobody* is doing this filtering,
>> resulting in
>> unwanted packets being handed to my protocol (which sits directly on top
>> of the
>> Ethernet driver).
>
> And since UML doesn't have "cards", it may be that the driver should do the
> filtering at the bottom layer and it isn't.


IIRC, most but not all cards will do the filtering in hardware unless 
they're in promiscuous mode. However if the card is in promiscuous mode or 
doesn't support filtering, the next step is when eth_type_trans sets the 
pkt_type of the skb to PACKET_OTHERHOST. I remember there being something 
odd about the handling of ethernet headers a good while ago.

In any event, doing the filtering in the device would help, but won't work 
when it's promisc (for example if tcpdump is running).

G'day,
sjames


>
> 				Jeff
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
