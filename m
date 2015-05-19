Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1YukXu-0004LC-Jm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 May 2015 16:39:10 +0000
Received: from mail-vn0-f54.google.com ([209.85.216.54])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YukXt-0005Pb-Tr
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 May 2015 16:39:10 +0000
Received: by vnbf62 with SMTP id f62so1526436vnb.7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 19 May 2015 09:39:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555B62A9.9000902@kot-begemot.co.uk>
References: <1431854739.603436.45.camel@m3y3r.de>
	<555B62A9.9000902@kot-begemot.co.uk>
Date: Tue, 19 May 2015 18:39:04 +0200
Message-ID: <CAFLxGvycaHXq52okh+nfihRqAm26uZG=Ax=G6=zfA5DwEJfDWw@mail.gmail.com>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Tue, May 19, 2015 at 6:19 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> Same story.
>
> Overall works quite well, the moment I give it the "dselect upgrade
> test" the userspace hangs.
>
> Kernel continues to work - forwarding, icmp, uml_mconsole are fine.

Do you know where it hangs?
Maybe the kernel does not get any scheduler tick and does not schedule a task..,

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

