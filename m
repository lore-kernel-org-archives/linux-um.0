Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFepf-00084T-2U for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 13:25:47 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFeoj-0002CN-5s for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 13:25:47 -0700
Received: from minna.local (dialin-145-254-062-109.arcor-ip.net
	[145.254.62.109])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 2E48614365
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  7 Oct 2004 22:24:43 +0200 (CEST)
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
Message-ID: <RO4HJxErhAMlOpdbW1UCZm8=lge@web.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<vm4cST3zEEx6OdPLK17ocyg=lge@web.de>
	<20041006203539.GC22794@wotan.suse.de>
	<200410072041.51890.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410072041.51890.blaisorblade_spam@yahoo.it>
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
Date: Thu, 7 Oct 2004 22:24:54 +0200
To: user-mode-linux-devel@lists.sourceforge.net

/ 2004-10-07 20:41:51 +0200
\ BlaisorBlade:
> On Wednesday 06 October 2004 22:35, Andi Kleen wrote:
> > On Wed, Oct 06, 2004 at 08:48:23PM +0200, Lars Ellenberg wrote:

> > > FYI, full thread can be found for example at
> > > http://thread.gmane.org/gmane.linux.uml.devel/4607
> 
> > Paolo's analysis is basically correct. loopback sets this flag
> > for better performance.  Actually in 2.6 it probably doesn't help
> > very much anymore because TCP can do checksum copy RX now, and that
> > would get the checksum basically for free. But it's still there
> > and may still make things slightly faster.
> First thing: thanks a lot for your quick answer.
> 
> My discussion about "lo" was slightly unrelated to the exact problem, and a 
> bit confusing...
> 
> I was at first surprised from Ethereal complaining about the host kernel, so I 
> thought I could have a buggy Ethereal, and then went checking that it's a 
> Linux optimization, indeed.
> 
> > If UML taps the packets from lo it will see incorrect checksums.
> > Using a tun or ethertap device would avoid this.
> 
> > In the worst 
> > case you could also just delete the flag from the loopback
> > interface, it's only an optimization.
> 
> No, inside the Uml kernel they go through a virtual "ethN" interface, which 
> uses special code. That driver, in turn, will use either ethertap, or TAP (it 
> sends Ethernet frames), or even other mechanism.
> 
> You can find it (in 2.6.9-rc2 at least) in arch/um/drivers/net_*.c and 
> arch/um/os-Linux/drivers/*tap*.c. The code in *_kern.c files links against 
> the kernel API and includes, *_user.c against the host userspace includes.
> 
> And the problem is, probably, that the UML network drivers never declare their 
> checksumming status, as I said in the previous mail:
> 
> [quote]
> include/linux/skbuff.h describes the Checksum flags, and UML does not use 
> them: these two commands return no (relevant) output.
> 
> find arch/um/ -name '*.[ch]'|xargs grep NETIF
> find arch/um/ -name '*.[ch]'|xargs grep CHECKSUM
> [/quote]
> 
> And not even these ones:
> 
> find arch/um/ -name '*.[ch]'|xargs grep NETIF
> find arch/um/ -name '*.[ch]'|xargs grep CHECKSUM
> 
> Also, it's possible that there are even other bugs...

now, what I found:
arch/um/drivers/net_kern.c:
struct sk_buff *ether_adjust_skb(struct sk_buff *skb, int extra)
{
	if((skb != NULL) && (skb_tailroom(skb) < extra)){
	  	struct sk_buff *skb2;

		skb2 = skb_copy_expand(skb, 0, extra, GFP_ATOMIC);
		dev_kfree_skb(skb);
		skb = skb2;
	}
	if(skb != NULL) skb_put(skb, extra);
	return(skb);
}

net/core/skbuff.c:
 *	BUG ALERT: ip_summed is not copied. Why does this work? Is it used
 *	only by netfilter in the cases when checksum is recalculated? --ANK
 */
struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
				int newheadroom, int newtailroom, int gfp_mask)
{


does that trigger something in someones brain maybe?
someone "sees" it?

otherwise I keep poking around...

	lge



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
