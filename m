Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CH4NL-00047n-W5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 10:54:23 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CH4NK-0007HH-A2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 10:54:23 -0700
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
Message-ID: <j7l8RdbM+9uLzg0PWMggkBg=lge@web.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<vm4cST3zEEx6OdPLK17ocyg=lge@web.de>
	<20041006203539.GC22794@wotan.suse.de>
	<200410072041.51890.blaisorblade_spam@yahoo.it>
	<RO4HJxErhAMlOpdbW1UCZm8=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RO4HJxErhAMlOpdbW1UCZm8=lge@web.de>
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
Date: Mon, 11 Oct 2004 19:55:12 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Beekhof <andrew@beekhof.net>, Lars Marowsky-Bree <lmb@suse.de>

/ 2004-10-07 22:24:54 +0200
\ Lars Ellenberg:

> now, what I found:
> arch/um/drivers/net_kern.c:
> struct sk_buff *ether_adjust_skb(struct sk_buff *skb, int extra)
> {
> 	if((skb != NULL) && (skb_tailroom(skb) < extra)){
> 	  	struct sk_buff *skb2;
> 
> 		skb2 = skb_copy_expand(skb, 0, extra, GFP_ATOMIC);
> 		dev_kfree_skb(skb);
> 		skb = skb2;
> 	}
> 	if(skb != NULL) skb_put(skb, extra);
> 	return(skb);
> }
> 
> net/core/skbuff.c:
>  *	BUG ALERT: ip_summed is not copied. Why does this work? Is it used
>  *	only by netfilter in the cases when checksum is recalculated? --ANK
>  */
> struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
> 				int newheadroom, int newtailroom, int gfp_mask)
> {
> 
> 
> does that trigger something in someones brain maybe?
> someone "sees" it?
> 
> otherwise I keep poking around...

since UML => Host does not work, but
Host => UML does, this suggests that
the bug is somewhere on the sending side.

I was not able to track it down.

but, I just patched out the "verify checksum" from the receiving part,
and get 16000 byte through now, sometimes more (this seems to be a
buffer issue).

so for now, I just don't care for the ip checksum on my UMLs,
and I have to live with no fragmented UDP from UML => Host.
but between my UMLs, I have now up to 16k UDP, that should be enough for
the moment beeing.


bute but effective: dont care for checksums.  at first I had additional
printks in the code wherever it said "goto inhdr_error", to find where
exactly it breaks.
only the now #if 0'ed one triggered.

	Lars Ellenberg


--- linux-2.6.6/net/ipv4/ip_input.c.orig	2004-10-11 19:35:57.000000000 +0200
+++ linux-2.6.6/net/ipv4/ip_input.c	2004-10-11 19:53:58.000000000 +0200
@@ -403,8 +403,10 @@
 
 	iph = skb->nh.iph;
 
+#if 0
 	if (ip_fast_csum((u8 *)iph, iph->ihl) != 0)
 		goto inhdr_error; 
+#endif
 
 	{
 		__u32 len = ntohs(iph->tot_len); 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
