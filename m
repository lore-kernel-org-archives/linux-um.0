Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcrYq-000325-13 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 12:40:20 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CcrYo-0002pz-U6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 12:40:19 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: What to do with uml_switch?
References: <BAY24-F14D010172174FC8FBD303F83B50@phx.gbl>
In-Reply-To: <BAY24-F14D010172174FC8FBD303F83B50@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412101936.43526.blaisorblade_spam@yahoo.it>
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
Date: Fri, 10 Dec 2004 19:36:43 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Steve Schmidtke <steve_schmidtke@hotmail.com>, mcr@xelerance.com, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com

On Tuesday 07 December 2004 17:06, Steve Schmidtke wrote:
> Michael Richardson wrote:
> >     Steve> I like these 3, but could you not just connect another UML
> >     Steve> guest to the switch and run arp -s pub and tcpdump to
> >     Steve> accomplish the same thing?

> >   Sure, no problem :-)
> >   Please send:
> >  a) MORE RAM
> >     16-way system

> >  b) Paulo to come and debug why UMLs to "rogue", and clog up
> >     memory and system state.
> >     (Remember we start and stop some 1000 of them every night)
> >     The more that we run, the worse the situation.
??? Could you give more detail? If you're getting host memory leaks, maybe 
updating SKAS could help... please send a separate message on that... there 
was with -V1 a big memory leak in some unusual situations.
> >   Starting a UML to answer ARP and ICMP echo requests is silly.
> >   Particularly since our test system now takes 2-3 hours to run on a
> >multigigahertz box with lots of ram
>
> Agreed, it would be an unwieldy solution.  And it's obvious you need fine
> grained control to manage packets in your test environment, sorry if it
> sounded like I was telling you what you should do.  What I was trying to
> point out (and thinking out loud) is that an ARP generator can be connected
> *to* uml_switch, it doesn't have to be built *into* uml_switch.

> Strip down 
> the UML kernel's daemon_user.c and what you have is a framework to talk
> socket datagrams to a uml_switch.  Add code to accept and generate
> arbitrary ethernet frames, add you now have an independant pluggable
> diagnostic tool anyone can use on the fly.  This is a solution that would
> probably satisfy 95% of us mere mortals.

It seems reasonable to me too, and a good application of the Unix KISS 
principle...

This way, it is also easier to control the frame injection, since the injector 
is a separate program.

However I've seen the timing argument and the discussion went much further 
while I was away, which is good... as I said, I just wanted to make you start 
working on that, not to work on it myself, since I have 0 experience for 
this.

My only advice is to start packaging at least the initial work... Michael, you 
had offered to actually maintain uml_switch, so why don't you start merging 
at least the earliest Steve's cleanups?

Maintainance does not only mean development, also caring about such details 
and merging good patches from anybody else...
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
