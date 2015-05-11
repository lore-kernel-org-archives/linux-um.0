Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1YrrNp-0001i7-4E
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 17:20:49 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YrrNn-0005E9-IA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 17:20:49 +0000
Message-ID: <5550E4E8.1090300@kot-begemot.co.uk>
Date: Mon, 11 May 2015 18:20:40 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <672e7d23-295e-42eb-a92a-d13faa966927@email.android.com>
In-Reply-To: <672e7d23-295e-42eb-a92a-d13faa966927@email.android.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v6] um: Add a high resolution timer subsystem
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 11/05/15 18:00, Thomas Meyer wrote:
> Hi,
>
> maybe there is a bug in how the timers are created for all user space processes.
> In the latest patch I use os__timer_remain for the initial interval.
> The idea was to launch all timers at the same time. But I now think this can never work using relative times, especially when os__timer_remain returns 0, then the new timer is never launched.

That is not a bad idea, just requires a more complex check in setting up 
interval so it is reset to default when a zero value or value > HZ is 
passed.


>
> That may explain the hangs you see.
>   You could try to replace os__timer_remain with the current HZ value in nanoseconds.

I am going to adjust time.c instead as above.

A.

>
> Kind regards
> Thomad
>
> A
[snip]

A.

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

