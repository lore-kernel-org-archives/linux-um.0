Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHNFR-0005er-1P for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 07:03:29 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CHNEH-0003QV-Su for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 07:03:28 -0700
Received: from minna.local (dialin-145-254-064-128.arcor-ip.net
	[145.254.64.128])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 0955F14397
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Oct 2004 16:02:14 +0200 (CEST)
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [uml-devel] SOLVED: uml "ip header error" for large (fragmented)
	udp packets
Message-ID: <f0Yu+H7xh2RnPZZpo0w3knE=lge@web.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<j7l8RdbM+9uLzg0PWMggkBg=lge@web.de>
	<xneXIovOv53ZtptO+AU2uyI=lge@web.de>
	<200410120227.00849.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410120227.00849.blaisorblade_spam@yahoo.it>
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
Date: Tue, 12 Oct 2004 16:00:17 +0200
To: user-mode-linux-devel@lists.sourceforge.net

/ 2004-10-12 02:27:00 +0200
\ BlaisorBlade:
> On Tuesday 12 October 2004 02:03, Lars Ellenberg wrote:
> > / 2004-10-11 19:55:12 +0200
> >
> > \ Lars Ellenberg:
> > > since UML => Host does not work, but
> > > Host => UML does, this suggests that
> > > the bug is somewhere on the sending side.
> > >
> > > I was not able to track it down.
> >
> > just so you know, finally:
> 
> > =======================
> > --- linux-2.6.6/arch/um/include/sysdep-i386/checksum.h.orig	2004-10-12
> > 01:50:49.000000000 +0200 +++
> > linux-2.6.6/arch/um/include/sysdep-i386/checksum.h	2004-10-12
> > 01:50:58.000000000 +0200 @@ -102,8 +102,7 @@
> >  	   are modified, we must also specify them as outputs, or gcc
> >  	   will assume they contain their original values. */
> >
> >  	: "=r" (sum), "=r" (iph), "=r" (ihl)
> >
> > -	: "1" (iph), "2" (ihl)
> > -	: "memory");
> > +	: "1" (iph), "2" (ihl));
> >  	return(sum);
> >  }
> The patch you posted REMOVES a memory barrier - you reversed it. I actually 
> checked the barrier is missing in the source code; but the strange thing is 
> that you modified checksum.h.orig and not checksum.h!

nope.
I just did "diff -u linux-2.6.6/arch/um/include/sysdep-i386/checksum.h{,.orig}"
instead of "diff -u linux-2.6.6/arch/um/include/sysdep-i386/checksum.h{.orig,}"
and did not notice.
Hey, it was in the middle of the night ;-)

thanks,
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
