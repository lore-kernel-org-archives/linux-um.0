Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTfC2-0001yP-8u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 04:06:30 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BTfC1-0006BX-Fn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 04:06:29 -0700
Message-ID: <13d701c444a4$d50fe310$2000000a@schlepptopp>
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
Date: Fri, 28 May 2004 13:13:40 +0200
To: "Christopher S. Aker" <caker@theshore.net>
Cc: uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

hi!
i would like to report, that it your patch seems to work fine with 2.6.6 !
uml now has an "io bandwidth limiter" - no uml "customer" should be able to 
hog the io subsystem anymore :)

now, we have an "iostat" for each uml, too:

while true; do uml_mconsole umid io_status; sleep 1; done
:)

thanks christopher!

one question:
which values need to be set, to have "unlimited" i/o , i.e. to switch off token
limitation entirely ?

roland

ps:
the token limiter seems to have a little bug:
set token_refill=1 
do a "dd if=/dev/zero of=test.dat bs=1024k count=whatever"
then "sync".
for me, io isn`t limited here - io_tokens just becomes negative - nothing more.
ok - io_refill=1 is no "real world" value anyway - so not really important to be fixed - but interesting :)



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
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
