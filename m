Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHBBe-0003jv-2h for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 18:10:46 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CHBBZ-0001Jz-My for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 18:10:45 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] SOLVED: uml "ip header error" for large (fragmented)
	udp packets
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<xneXIovOv53ZtptO+AU2uyI=lge@web.de>
	<20041012001140.GB17340@wotan.suse.de>
In-Reply-To: <20041012001140.GB17340@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120310.59432.blaisorblade_spam@yahoo.it>
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
Date: Tue, 12 Oct 2004 03:10:59 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andi Kleen <ak@suse.de>, Lars Ellenberg <Lars.Ellenberg@linbit.com>

On Tuesday 12 October 2004 02:11, Andi Kleen wrote:
> >  	   will assume they contain their original values. */
> >
> >  	: "=r" (sum), "=r" (iph), "=r" (ihl)
> >
> > -	: "1" (iph), "2" (ihl)
> > -	: "memory");
> > +	: "1" (iph), "2" (ihl));
> >  	return(sum);
> >  }
> >
> > =======================
>
> That's reverted, right?
>
> > that's all, folks. only a missing memory barrier.
> >
> > WTF :-/
>
> This was fixed in mainline some time ago (several months probably more)
> The problem only started with newer gccs that optimize more aggressively.
>
> > original (in include/asm-i386/checksum.h) right away??
> > there may be similar bugs hiding in various areas of uml...
>
> Sounds like a good idea.
Agreed, but I've to check if the include does not have any conflict. And I 
don't have the time until after 2.6.9, because I must address more urgent 
issues. Obviously the one-liner itself is being sent to Andrew Morton.

> > Thanks for now,
> > keep it going...
> >
> > btw,
> > anyone wants to give me a hint how to tune it best?
> > maybe how to up the mtu of the UML "nics"?
>
> Don't go over 4K because the VM doesn't like >order 0 allocations
> very much. But in general bigger is better.

Sadly there is a problem: since we use TAP and emulate whole Ethernet frames, 
the code does not allow to increase the MTU to > 1500 bytes. I think this 
cannot be fixed currently, but if you think this is wrong, please let us now.

Obviously we could add another interface emulation with bigger MTU, but I've 
no ideas about which ones to emulate.
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
