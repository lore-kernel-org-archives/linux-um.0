Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1YuwWO-0006CL-7U
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 May 2015 05:26:24 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YuwWM-0005fC-G3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 May 2015 05:26:24 +0000
Date: Wed, 20 May 2015 07:26:10 +0200
Message-ID: <bbdd39b2-dcac-41c8-bfb4-73645e73c7b7@email.android.com>
In-Reply-To: <CAFLxGvzGRvbdUxVfo6jjCOy+88QK3ffvULv5MRi4bCG06ur=xg@mail.gmail.com>
From: Thomas Meyer <thomas@m3y3r.de>
MIME-Version: 1.0
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>


Am 20.05.2015 12:12 vorm. schrieb Richard Weinberger <richard.weinberger@gmail.com>:
>
> On Sun, May 17, 2015 at 11:25 AM, Thomas Meyer <thomas@m3y3r.de> wrote: 
> > Switch the UML clocksource from interval timers to posix interval timers 
> > and move to a monotonic timer. 
> > 
> > This fixes suspend&resume related timer issues and improves network 
> > performance as TCP state machines are now fed with the correct time; 
> > also correct QoS and traffic shaping. 
> > 
> > Signed-off-by: Thomas Meyer <thomas@m3y3r.de> 
>
> What tree is this patch against? 
> It does not clearly apply to Linus' tree. 
>

Hi,

I did tested the patch against 4.1-rc3-something; will update the patch against the latest commit!


> -- 
> Thanks, 
> //richard 
>
> ------------------------------------------------------------------------------ 
> One dashboard for servers and applications across Physical-Virtual-Cloud 
> Widest out-of-the-box monitoring support with 50+ applications 
> Performance metrics, stats and reports that give you Actionable Insights 
> Deep dive visibility with transaction tracing using APM Insight. 
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y 
> _______________________________________________ 
> User-mode-linux-devel mailing list 
> User-mode-linux-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel 
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

