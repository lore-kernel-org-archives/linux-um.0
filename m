Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cc7zO-0006sc-Q2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 12:00:42 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cc7zL-0008J5-WD
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 12:00:41 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: What to do with uml_switch?
Message-ID: <20041208193348.GC4853@bytesex>
References: <200412040452.32722.blaisorblade_spam@yahoo.it>
	<29928.1102218163@marajade.sandelman.ottawa.on.ca>
	<20041206192526.GC12953@bytesex>
	<5810.1102524702@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5810.1102524702@marajade.sandelman.ottawa.on.ca>
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
Date: Wed, 8 Dec 2004 20:33:48 +0100
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, Steve Schmidtke <steve_schmidtke@hotmail.com>, Felix =?iso-8859-1?Q?M=FCri?= <uml@uxu.ch>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

>     Gerd> Hmm, not sure I like that idea.  Is this with vlan tagging
>     Gerd> support?  How can this be configured?  Is the command mode the
>     Gerd> only way, or can you also use some config file or command line
>     Gerd> switches for that?
> 
>   No VLANs. 

Would be cool I think, so you could debug vlan code in the kernel using
uml for example.

>   It creates multiple sockets, and you tell the UML(s) about the multiple
> interfaces. 

That is clear.  How to you tell uml_switch which sockets it should
create?

>   Please read the mentione paper.

I've looked at it, it doesn't answer the configuration question through.
Your openswan test setup seems to use command mode.  It's not clear
whenever that is the only way to do it.  It shouldn't, for running tests
that likely is perfect, but for other applications I just want a static
configuration and uml_switch shouldn't wait for commands on stdin/out.

>   Secondly, I do not put these things into uml_switch.
>   Rather, I *refactor* things so that uml_switch and uml_netjig share
> back end code. uml_switch has none of the above things, only the same
> port.c code.

Oh, so for uml_netjig you just link in some more some object files which
do the arp answering, packet injection and so on?  That wasn't clear to
me.  This makes much more sense ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
