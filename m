Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1YupkT-0003Cu-04
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 May 2015 22:12:29 +0000
Received: from mail-vn0-f44.google.com ([209.85.216.44])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YupkS-00039x-7T
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 May 2015 22:12:28 +0000
Received: by vnbf1 with SMTP id f1so2259830vnb.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 19 May 2015 15:12:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1431854739.603436.45.camel@m3y3r.de>
References: <1431854739.603436.45.camel@m3y3r.de>
Date: Wed, 20 May 2015 00:12:22 +0200
Message-ID: <CAFLxGvzGRvbdUxVfo6jjCOy+88QK3ffvULv5MRi4bCG06ur=xg@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] um: Switch clocksource to hrtimers
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, May 17, 2015 at 11:25 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Switch the UML clocksource from interval timers to posix interval timers
> and move to a monotonic timer.
>
> This fixes suspend&resume related timer issues and improves network
> performance as TCP state machines are now fed with the correct time;
> also correct QoS and traffic shaping.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

What tree is this patch against?
It does not clearly apply to Linus' tree.

-- 
Thanks,
//richard

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

