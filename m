Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CdZ93-00046l-KC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Dec 2004 11:12:37 -0800
Received: from bay24-f30.bay24.hotmail.com ([64.4.18.80] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CdZ91-0006TV-7D for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Dec 2004 11:12:35 -0800
Message-ID: <BAY24-F3066C52785F7FFBF9E53EA83AA0@phx.gbl>
In-Reply-To: <7683.1102810263@marajade.sandelman.ottawa.on.ca>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] Re: What to do with uml_switch?
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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
Date: Sun, 12 Dec 2004 19:11:24 +0000
To: mcr@sandelman.ottawa.on.ca, blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com

Michael Richardson wrote:
> >>>>> "Blaisorblade" == Blaisorblade  <blaisorblade_spam@yahoo.it> writes:
>     Blaisorblade> My only advice is to start packaging at least the
>     Blaisorblade> initial work... Michael, you had offered to actually
>     Blaisorblade> maintain uml_switch, so why don't you start merging at
>     Blaisorblade> least the earliest Steve's cleanups?

I was hoping to have a working -monitor <port> option before I spoke up, but 
that's going to take a while to sort out.

So, in the mean time, I'd like to announce that I would like to take over as 
maintainer of uml_switch, if that's ok.

My intent is to have uml_switch as a functional, virtual, network switch, 
solidly performing the tasks normally expected of a real switch.  I would 
also like to see it as a platform that can support extensions for networking 
experiments and diagnostic tools.  Oh. and instead of "uml_router" or 
"uml_switch", I would like to propose a new name, "User Mode Switch", or 
"ums" for short. :)

>   Steve, please point me at your patches/cleanups.
>   Please understand that I may just start from my merged 
>uml_netjig/uml_switch.

At this point, it might be easier for me to incorporate the uml_netjig 
changes than the other way around.  I found 5 patches (1-5) for the 
uml_netjig foundation in the mailing list archive, and I'm OK with the basic 
premises I have seen:  that uml_switch should support multiple switches, and 
that  uml_switch should have a script friendly command interface for 
controlling those switches.  If we can agree that the other features like 
tcpdumps and fake ARPs, etc. are not core to the nature of a switch (but can 
be patched in when needed), then I would be happy to maintain the above 
premises as well.

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
