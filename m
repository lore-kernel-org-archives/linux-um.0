Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFdD8-0005Vk-65 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:41:54 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CFdD6-0002bQ-IS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:41:54 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<vm4cST3zEEx6OdPLK17ocyg=lge@web.de>
	<20041006203539.GC22794@wotan.suse.de>
In-Reply-To: <20041006203539.GC22794@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410072041.51890.blaisorblade_spam@yahoo.it>
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
Date: Thu, 7 Oct 2004 20:41:51 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andi Kleen <ak@suse.de>, Lars Ellenberg <Lars.Ellenberg@linbit.com>, lmb@suse.de

On Wednesday 06 October 2004 22:35, Andi Kleen wrote:
> On Wed, Oct 06, 2004 at 08:48:23PM +0200, Lars Ellenberg wrote:
> > > So this could help you for now, while we try to find a clue about this.
> > > Quite frankly, I must say that I'm not seeing any network kernel hacker
> > > here (correct me if I'm wrong), so it will take some time to debug it.
> > > Maybe Gerd Knorr is an exception, actually.

> > Well, then I take Andi Kleen and Lars Marowsky-Br?e into CC for now.
> > Lars, because I expect him to be interessted in having UML as full
> > featured cluster simulation tool available, and Andi because I hope he
> > might know the network code much better than me...

> > FYI, full thread can be found for example at
> > http://thread.gmane.org/gmane.linux.uml.devel/4607

> Paolo's analysis is basically correct. loopback sets this flag
> for better performance.  Actually in 2.6 it probably doesn't help
> very much anymore because TCP can do checksum copy RX now, and that
> would get the checksum basically for free. But it's still there
> and may still make things slightly faster.
First thing: thanks a lot for your quick answer.

My discussion about "lo" was slightly unrelated to the exact problem, and a 
bit confusing...

I was at first surprised from Ethereal complaining about the host kernel, so I 
thought I could have a buggy Ethereal, and then went checking that it's a 
Linux optimization, indeed.

> If UML taps the packets from lo it will see incorrect checksums.
> Using a tun or ethertap device would avoid this.

> In the worst 
> case you could also just delete the flag from the loopback
> interface, it's only an optimization.

No, inside the Uml kernel they go through a virtual "ethN" interface, which 
uses special code. That driver, in turn, will use either ethertap, or TAP (it 
sends Ethernet frames), or even other mechanism.

You can find it (in 2.6.9-rc2 at least) in arch/um/drivers/net_*.c and 
arch/um/os-Linux/drivers/*tap*.c. The code in *_kern.c files links against 
the kernel API and includes, *_user.c against the host userspace includes.

And the problem is, probably, that the UML network drivers never declare their 
checksumming status, as I said in the previous mail:

[quote]
include/linux/skbuff.h describes the Checksum flags, and UML does not use 
them: these two commands return no (relevant) output.

find arch/um/ -name '*.[ch]'|xargs grep NETIF
find arch/um/ -name '*.[ch]'|xargs grep CHECKSUM
[/quote]

And not even these ones:

find arch/um/ -name '*.[ch]'|xargs grep NETIF
find arch/um/ -name '*.[ch]'|xargs grep CHECKSUM

Also, it's possible that there are even other bugs...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
