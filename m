Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHAV2-0003lS-QO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:26:44 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CHAV1-0000PL-Jd for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:26:44 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] SOLVED: uml "ip header error" for large (fragmented)
	udp packets
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<j7l8RdbM+9uLzg0PWMggkBg=lge@web.de>
	<xneXIovOv53ZtptO+AU2uyI=lge@web.de>
In-Reply-To: <xneXIovOv53ZtptO+AU2uyI=lge@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120227.00849.blaisorblade_spam@yahoo.it>
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
Date: Tue, 12 Oct 2004 02:27:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Lars Ellenberg <Lars.Ellenberg@linbit.com>

On Tuesday 12 October 2004 02:03, Lars Ellenberg wrote:
> / 2004-10-11 19:55:12 +0200
>
> \ Lars Ellenberg:
> > since UML => Host does not work, but
> > Host => UML does, this suggests that
> > the bug is somewhere on the sending side.
> >
> > I was not able to track it down.
>
> just so you know, finally:

> =======================
> --- linux-2.6.6/arch/um/include/sysdep-i386/checksum.h.orig	2004-10-12
> 01:50:49.000000000 +0200 +++
> linux-2.6.6/arch/um/include/sysdep-i386/checksum.h	2004-10-12
> 01:50:58.000000000 +0200 @@ -102,8 +102,7 @@
>  	   are modified, we must also specify them as outputs, or gcc
>  	   will assume they contain their original values. */
>
>  	: "=r" (sum), "=r" (iph), "=r" (ihl)
>
> -	: "1" (iph), "2" (ihl)
> -	: "memory");
> +	: "1" (iph), "2" (ihl));
>  	return(sum);
>  }
The patch you posted REMOVES a memory barrier - you reversed it. I actually 
checked the barrier is missing in the source code; but the strange thing is 
that you modified checksum.h.orig and not checksum.h! Are you sure that you 
compiled the corrected header? However, the patch is correct, and I assume 
you posted it the right way. I'm going to send it to Andrew Morton for 2.6.9 
(hoping he wants to accept all these patches - they are rushing for 2.6.9).

> that's all, folks. only a missing memory barrier.
Thanks a lot, folks! Yes, the patch is right.
> WTF :-/
>
> same patch applies to 2.6.8.1 - uml and probably all other umls.
> since that is a one-to-one copy anyways, maybe UML should better use the
> original (in include/asm-i386/checksum.h) right away??
I could do this later - too much checks for the other header code for a 
one-minute patch.
> there may be similar bugs hiding in various areas of uml...
I think there are even worse ones.
> btw,
> anyone wants to give me a hint how to tune it best?
> maybe how to up the mtu of the UML "nics"?
Impossible with the current code - it emulates an ethernet card, so I don't 
think you can do anything for this. However I hope it does not cause too much 
problems. Search for the network howtos: someone explained how to set the 
interface packet scheduler (maybe even Jeff Dike on the main UML site).

Bye
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
