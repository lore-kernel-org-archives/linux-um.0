Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7ZJP-0000Dc-NY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 04:22:47 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B7ZJO-0006H0-G4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Mar 2004 04:22:46 -0800
Message-ID: <0c2101c414c0$3b2c6ca0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <004901c414a3$f4d28a80$0201a8c0@hawk>
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
Date: Sun, 28 Mar 2004 14:28:47 +0200
To: "Christopher S. Aker" <caker@theshore.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

hello christoph, 
could you please explain (in a simple way), what your patch can be used for?
from my point of understanding, we now can limit the maximum i/o bandwidth a single uml can use?
is that right?
i have difficulties in understanding the meaning of token/bucket/filter.

regards
roland


----- Original Message ----- 
From: "Christopher S. Aker" <caker@theshore.net>
To: "uml-devel" <user-mode-linux-devel@lists.sourceforge.net>
Sent: Sunday, March 28, 2004 11:06 AM
Subject: [uml-devel] [PATCH] I/O-Request Token Bucket Limiter


> Patch is also available here:
> http://www.theshore.net/~caker/patches/
> 
> Apply to a tree already patched with 2.4-um or 2.6-um.
> 
> -Chris
> 
> ---token-limiter-v1.README---
> 
> This patch implements a simple token bucket filter/limiter on requests
> processed through the async io_thread.  It will work with or without COW,
> but not on ubd devices in sync mode.
> 
> * Two new command line arguments for setting at boot-time:
> 
> token_max=60000
>     This sets the maximum tokens in the token-bucket I/O request limiter.
>     Each io_thread request subtracts one token from the bucket.  The bucket
>     is supplied with <token_refill> tokens every second.  When the bucket
>     becomes empty, I/O requests are throttled to the <token_refill> rate.
> 
> token_refill=2000
>     This sets the bucket's refill rate, adding <token_refill> tokens to the
>     bucket every second. This becomes the I/O request rate when the bucket
>     becomes empty.
> 
> * Three new mconsole commands to get status information and change the two 
> variables above:
> 
> (mconsole) help
>     io_status - Return current I/O status and settings
>     io_token_max <num> - sets the bucket size
>     io_token_refill <num> - number of tokens to add each second
> 
> * Example io_status output while:
> 
> idle:
> io_count=1845202 io_rate=0 io_tokens=50000 token_refill=1024 \
> token_max=50000
> 
> bursting:
> io_count=1861594 io_rate=6806 io_tokens=35754 token_refill=1024 \
> token_max=50000
> 
> throttled:
> io_count=1994811 io_rate=1087 io_tokens=-153 token_refill=1024 \
> token_max=50000 
> io_count=2052289 io_rate=1057 io_tokens=-286 token_refill=1024 \
> token_max=50000
> io_count=2067794 io_rate=1015 io_tokens=-132 token_refill=1024 \
> token_max=50000
> 
> Our sample shows io_tokens being negative, but - while waiting for the bucket 
> to be re-supplied, requests will still dribble through no faster than 
> token_refill req/second. Or, perhaps this is due to inaccuracies of nanosleep
> or a bug in my logic.
> 
> * TODO
> Stop using an alarm in the io_thread, and instead use gettimeofday to 
> calculate the token credits due and io_rate.
> 
> 
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
