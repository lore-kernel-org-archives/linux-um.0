Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbPEH-0005Nn-O0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 12:13:05 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CbPEE-0006fz-Vn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 12:13:05 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: What to do with uml_switch?
References: <BAY24-F43C12817C138B110B213583B30@phx.gbl>
In-Reply-To: <BAY24-F43C12817C138B110B213583B30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412062116.43380.blaisorblade_spam@yahoo.it>
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
Date: Mon, 6 Dec 2004 21:16:42 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Steve Schmidtke <steve_schmidtke@hotmail.com>, mcr@marajade.sandelman.ottawa.on.ca, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com

On Sunday 05 December 2004 21:20, Steve Schmidtke wrote:
> Michael Richardson wrote:
> >  uml_netjig is a tool which does the following:
> >   1) moves packets using "daemon" mode a la uml_switch.
> >  2) has an expect-friendly command line interface  3) can create
> >*multiple* switches and keep them seperate

> If they are separate, why not just run multiple uml_switches?

Probably easier to manage... simplicity is good, but not as important, or 
important in the same way, for userspace problems. Don't apply on uml_switch 
the same inclusion criteria you use for the kernel.

> >  4) can record all packets to a .pcap file
> >  5) can play packets from a .pcap file at a given rate     (or under
> >command line interface control)
> >  6) can optionally answer ARP queries for imaginary nodes.

> I like these 3, but could you not just connect another UML guest to the
> switch and run arp -s pub and tcpdump to accomplish the same thing?

Needing another UML guest to do something which can be accomplished in a 
simpler way (supposing it's not too badly coded / heavy / intrusive in the 
patch) could even be reported as a bug, on the reverse!

Another problem: it's doable even without support for "pcap transport" in UML 
(which is currently broken in 2.6)? I know what to do to fix that (build 
problem only), only it's a bit ugly to fix - or requires pcap maintainers to 
fix up some screwage:

a symbol which *should* be static is global, in the static libraries it gets 
obviously exported, it's called vmap, conflicts with the kernel functions 
with the same name, and since it's also a common symbol (i.e. it can share 
the space of the function, see LD manual) it crashes UML silently, by trying 
to overwrite the vmap() code when you use it - funny breakage, isn't it? 
Would you imagine somebody to be able to screw up things so much? And is 
there a polite way to get it fixed? Yes, but needs time to settle down

I've recently learned to fix that with objcopy --keep-global, just haven't 
done it yet).

> >  7) can talk to tuntap device(s) as uml_switch could.
> >
> >  My patches refactor uml_switch to get uml_netjig + uml_switch'

> I am still not clear if uml_netjig is a separate program running on top of
> uml_switch or inside it, but (and I apologize for being dense if this is
> what you are doing) I think the proper way to accomplish what you want is
> to create a "-monitor <socket>" option to uml switch to filter all network
> traffic through.  Then create a monitor program that can attach/detach from
> a uml_switch at will through the monitor socket.  A hook to filter packets
> entering uml_switch and a new function to inject packets (with/without
> updating MAC tables) might be all that's necessary.  All your traffic
> management and expect code could reside in the external monitor program.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
