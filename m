Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cbhss-0007Ee-JY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 08:08:14 -0800
Received: from bay24-f14.bay24.hotmail.com ([64.4.18.64] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cbhsq-0006ov-Un for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 08:08:13 -0800
Message-ID: <BAY24-F14D010172174FC8FBD303F83B50@phx.gbl>
In-Reply-To: <4972.1102296202@marajade.sandelman.ottawa.on.ca>
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
Date: Tue, 07 Dec 2004 16:06:44 +0000
To: mcr@xelerance.com
Cc: blaisorblade_spam@yahoo.it, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Michael Richardson wrote:
>     Steve> I like these 3, but could you not just connect another UML
>     Steve> guest to the switch and run arp -s pub and tcpdump to
>     Steve> accomplish the same thing?
>
>   Sure, no problem :-)
>   Please send:
>	 a) MORE RAM
>	    16-way system
>
>	 b) Paulo to come and debug why UMLs to "rogue", and clog up
>	    memory and system state.
>	    (Remember we start and stop some 1000 of them every night)
>	    The more that we run, the worse the situation.
>
>   Starting a UML to answer ARP and ICMP echo requests is silly.
>   Particularly since our test system now takes 2-3 hours to run on a
>multigigahertz box with lots of ram

Agreed, it would be an unwieldy solution.  And it's obvious you need fine 
grained control to manage packets in your test environment, sorry if it 
sounded like I was telling you what you should do.  What I was trying to 
point out (and thinking out loud) is that an ARP generator can be connected 
*to* uml_switch, it doesn't have to be built *into* uml_switch.  Strip down 
the UML kernel's daemon_user.c and what you have is a framework to talk 
socket datagrams to a uml_switch.  Add code to accept and generate arbitrary 
ethernet frames, add you now have an independant pluggable diagnostic tool 
anyone can use on the fly.  This is a solution that would probably satisfy 
95% of us mere mortals.

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
