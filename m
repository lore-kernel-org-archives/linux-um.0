Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7ctq-0002AB-BL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 08:12:38 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B7ctp-0006u5-Eb for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 08:12:37 -0800
Message-ID: <0c3e01c414e0$58c21240$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <004901c414a3$f4d28a80$0201a8c0@hawk>
	<0c2101c414c0$3b2c6ca0$2000000a@schlepptopp>
	<002b01c414ca$5f439370$0201a8c0@hawk>
Subject: Re: [uml-devel] [PATCH] I/O-Request Token Bucket Limiter
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Sun, 28 Mar 2004 18:18:45 +0200
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

thanks for explanation!

that`s a great feature :)

is it (generally) possible to have something similar for cpu or other "ressources" like network bandwidth , too?

regards
roland


----- Original Message ----- 
From: "Christopher S. Aker" <caker@theshore.net>
To: "roland" <for_spam@gmx.de>; "uml-devel" <user-mode-linux-devel@lists.sourceforge.net>
Sent: Sunday, March 28, 2004 3:41 PM
Subject: Re: [uml-devel] [PATCH] I/O-Request Token Bucket Limiter


> > hello christoph,
> > could you please explain (in a simple way), what your patch can be used for?
> > from my point of understanding, we now can limit the maximum i/o bandwidth a
> single uml can use?
> > is that right?
> > i have difficulties in understanding the meaning of token/bucket/filter.
> 
> It allows you to place a limit on the amount of disk I/O that makes it to the host
> from each UML.  It is useful in the case where a mis-configured UML is thrashing
> its swapfile, and in turn consuming a lot of I/O on the host and starving the
> other UMLs of precious disk time.
> 
> The useful thing about the TBF is that it allows an initial burstable,
> unrestricted rate until the token bucket is empty.  The variable token_max (the
> size of the bucket) becomes how much "burstable" I/O to provide to the UML before
> it starts limiting the rate.  Each I/O request takes one token from io_tokens, but
> every second token_refill is added to io_tokens (to a maximum of token_max).
> 
> A way to see this is in action is to apply the patch, run the UML, and then on the
> host:
> 
> [root@host ~]# watch "uml_mconsole /path/to/mconsole/socket io_status 2>/dev/null
> "
> 
> And then:
> 
> [user@uml ~] dd if=/dev/zero of=/bigfile bs=1M count=200
> (or some other I/O generating activity)
> 
> and watch the mconsole io_status output...
> 
> -Chris
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
