Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHAND-0002bB-Pk for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:18:39 -0700
Received: from cantor.suse.de ([195.135.220.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CHANC-0000Bw-Ix
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:18:39 -0700
From: Andi Kleen <ak@suse.de>
Subject: Re: [uml-devel] SOLVED: uml "ip header error" for large (fragmented)
	udp packets
Message-ID: <20041012001140.GB17340@wotan.suse.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<vm4cST3zEEx6OdPLK17ocyg=lge@web.de>
	<20041006203539.GC22794@wotan.suse.de>
	<200410072041.51890.blaisorblade_spam@yahoo.it>
	<RO4HJxErhAMlOpdbW1UCZm8=lge@web.de>
	<j7l8RdbM+9uLzg0PWMggkBg=lge@web.de>
	<xneXIovOv53ZtptO+AU2uyI=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xneXIovOv53ZtptO+AU2uyI=lge@web.de>
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
Date: Tue, 12 Oct 2004 02:11:40 +0200
To: Lars Ellenberg <Lars.Ellenberg@linbit.com>, user-mode-linux-devel@lists.sourceforge.net

>  	   will assume they contain their original values. */
>  	: "=r" (sum), "=r" (iph), "=r" (ihl)
> -	: "1" (iph), "2" (ihl)
> -	: "memory");
> +	: "1" (iph), "2" (ihl));
>  	return(sum);
>  }
>  
> =======================

That's reverted, right? 
> 
> that's all, folks. only a missing memory barrier.
> 
> WTF :-/

This was fixed in mainline some time ago (several months probably more) 
The problem only started with newer gccs that optimize more aggressively.

> original (in include/asm-i386/checksum.h) right away??
> there may be similar bugs hiding in various areas of uml...

Sounds like a good idea. 

> 
> Thanks for now,
> keep it going...
> 
> btw,
> anyone wants to give me a hint how to tune it best?
> maybe how to up the mtu of the UML "nics"?

Don't go over 4K because the VM doesn't like >order 0 allocations
very much. But in general bigger is better.

-Andi


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
