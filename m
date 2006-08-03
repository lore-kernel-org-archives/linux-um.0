Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 3 Aug 2006 09:29:51 -0700
Message-ID: <3A30AD378ECC6F41A4AC64F18E8B3F7F6E0E40@ala-mail04.corp.ad.wrs.com>
From: "Stephens, Allan" <allan.stephens@windriver.com>
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
To: Paolo Giarrusso <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

Hi Paolo:

Here are the latest results of my testing of uml_switch.

Guest 1 has eth0=daemon,00:00:00:00:11:00
Guest 2 has eth0=daemon,00:00:00:00:22:00 and
eth1=daemon,00:00:00:00:22:11

When I do my testing using "uml_switch" (no hub), all interfaces seem to
see only the packets that have been sent to their MAC addresses (plus
any packets broadcast to FF:FF:FF:FF:FF:FF).

When I do my testing using "uml_switch -hub", interface eth0 on Guest 2
sees packets that were destined for eth1 on Guest 2 and for eth0 on
Guest 1.  Similarly, eth1 on Guest 2 sees packets that were destined for
eth0 on Guest 2 and for eth0 on Guest 1.

I also retried things with multicast using:

Guest 1 has eth0=mcast,00:00:00:00:11:00,,1106
Guest 2 has eth0=mcast,00:00:00:00:22:00,,1106 and
eth1=mcast,00:00:00:00:22:11,,1106

In this case, every interface on both guests seems to see all packets --
including the ones that it is sending out itself!

So, as far as I can tell, packets sent using "uml_switch" are passed on
only to the interfaces that are supposed to receive it, packets sent
using "uml_switch -hub" are passed to all interfaces except the sender,
and packets sent using multicast are passed to all interfaces (including
the sender).

These differences may make sense to people who understand how the
various transport mechanisms work, but it still leave me with a
question: why, in the latter two cases, is UML allowing non-promiscuous
interfaces to receive traffic that wasn't sent to them?  I can
understand that configuring uml_switch as a hub means that packets may
be forwarded to places they don't need to go, but shouldn't these
packets still be filtered out somewhere further down the line?  As I
naive user, I'm not expecting a (simulated) interface to receive traffic
that wasn't addressed to it unless it has been explicitly configured as
promiscuous.

Regards,
Al

> -----Original Message-----
> From: Paolo Giarrusso [mailto:blaisorblade@yahoo.it] 
> Sent: Wednesday, August 02, 2006 11:05 AM
> To: Stephens, Allan; user-mode-linux-devel@lists.sourceforge.net
> Cc: user-mode-linux-user@lists.sourceforge.net
> Subject: RE: [uml-user] Promiscuous mode interface bug?
> 
> "Stephens, Allan" <allan.stephens@windriver.com> ha scritto: 
> 
> > Hi Paolo:
> > 
> > OK, let me take one more try at explaining what I've observed. 
> > (And my
> > apologies for making this whole issue more confusing than necessary 
> > ...
> > I'm pretty inexperienced when it comes to detailing with 
> the details 
> > of network interface operation.)
> > 
> > When I used "ethX=daemon", each interface I configured on a 
> UML guest 
> > forwarded only the traffic that was destined for it to my network 
> > protocol software -- indicating that the uml_switch application was 
> > getting UML to filter things correctly.
> 
> Does it works corrently even with uml_switch -hub or not?
> 
> > When I used "ethX=mcast", each interface I configured on a 
> UML guest 
> > forwarded all packets sent to the associated multicast group to my 
> > network protocol software
> which I guess operates with raw sockets...
> >, even though the interfaces were not
> > configured as "promiscuous".
> 
> > The latter observation was the source of my original 
> concern, causing 
> > me to ask "why doesn't UML mark the device as promiscuous if it is 
> > passing on all packets?".  Your subsequent explanations now make me 
> > think that I should have asked "why isn't UML filtering out the 
> > unwanted packets since the device isn't configured as promiscuous?".
> 
> > I just repeated my "ethX=mcast" testing to make sure I hadn't done 
> > something stupid, like configure both interfaces with the same MAC 
> > address, but I still see the same result.  This leads me to 
> conclude 
> > that there is a real problem with the way UML is filtering 
> packets on 
> > "ethX=mcast" interfaces.  Admittedly, I can circumvent this problem 
> > being by manually configuring the interfaces as promiscuous, but it 
> > still looks like a bug.
> 
> > Does this (finally) make sense?
> 
> Yes, it makes a lot of sense (in fact I'm forwarding this to 
> uml-devel); I have looked at the code but I don't see any 
> really _obvious_ difference. Everything depends on uml_switch 
> -hub result, which I'd like to see.
> 
> Thanks for your effort meanwhile!
> Bye
> 
> Chiacchiera con i tuoi amici in tempo reale! 
>  http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
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
