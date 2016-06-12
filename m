Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@gmail.com>) id 1bCCTn-0002mg-PS
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 20:59:35 +0000
Received: from mail-vk0-f48.google.com ([209.85.213.48])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bCCTn-0006FM-2I
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 20:59:35 +0000
Received: by mail-vk0-f48.google.com with SMTP id t129so28910568vka.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 Jun 2016 13:59:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvw1jahqtNPkyBiMq_P4no+uersN4fGMcFqexikyLwm83w@mail.gmail.com>
References: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
	<6AAB4FAC-99C2-4B3C-88CA-C210193E74EF@m3y3r.de>
	<CAOMGZ=H-fi-Wqmc36ts5LULSe=QD9Q-ys7GKryFWRZw_iO-J=A@mail.gmail.com>
	<CAFLxGvw1jahqtNPkyBiMq_P4no+uersN4fGMcFqexikyLwm83w@mail.gmail.com>
From: Vegard Nossum <vegard.nossum@gmail.com>
Date: Sun, 12 Jun 2016 22:59:28 +0200
Message-ID: <CAOMGZ=Ha+Wwb4wbsa+yNC9HL1ZT4BYMZdGdVbGDVPb2t9AuY-w@mail.gmail.com>
Subject: Re: [uml-devel] current_thread_info() returns invalid pointer in
 early UML boot code
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Thomas Meyer <thomas@m3y3r.de>

On 12 June 2016 at 22:11, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>> I wonder why setup_env_path() ends up calling the kernel's snprintf(),
>> I thought that it would be using the glibc snprintf() at this point?
>
> That early you cannot use current() nor any other core kernel stuff
> since the kernel has not started so far.
> So, the current thread info struct points to garbage.

Yes, I know. I think setup_env_path() should call the libc snprintf
rather than the kernel one, can you explain how to do that properly?

Thanks,


Vegard

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

