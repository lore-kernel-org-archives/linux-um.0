Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cbi6n-00087O-Dg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 08:22:37 -0800
Received: from bay24-f4.bay24.hotmail.com ([64.4.18.54] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cbi6m-0000pY-0K for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 08:22:36 -0800
Message-ID: <BAY24-F497D39F4DD7020932ACAB83B50@phx.gbl>
In-Reply-To: <20041206192526.GC12953@bytesex>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [uml-devel] Re: What to do with uml_switch?
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
Date: Tue, 07 Dec 2004 16:21:17 +0000
To: kraxel@bytesex.org, mcr@marajade.sandelman.ottawa.on.ca
Cc: blaisorblade_spam@yahoo.it, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Gerd Knorr wrote:
> >   3) can create *multiple* switches and keep them seperate
>
>Hmm, not sure I like that idea.  Is this with vlan tagging support?
>How can this be configured?  Is the command mode the only way, or can
>you also use some config file or command line switches for that?

I thought about adding vlan support, but then realized if I wasn't going to 
code up some sort of multi-membership system (union ports?), it would be 
simpler just to run multiple uml_switches.  It should be obvious I don't 
know what I'm talking about, so I left it alone. :)

> >   4) can record all packets to a .pcap file
> >   5) can play packets from a .pcap file at a given rate
> >      (or under command line interface control)
> >   6) can optionally answer ARP queries for imaginary nodes.
>
>Hmm, I don't think it is a good idea to put that kind of testing code
>into the switch daemon.  I'd make the switch daemon behave as close as
>possible to a real switch, then use the normal tools you use for real
>networks as well.  I think uml_switch should just support a monitor port
>which will see all traffic (even the switched one), that is the usual
>way how it's done on physical hardware.

I'm eating my own dog food (since I too suggested a monitor port), and I've 
coded up a framework for doing just that.  I need to test it more before 
submitting a patch for review and comment.

Steve Schmidtke




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
