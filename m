Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ZsWc7-0008G0-1H
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Oct 2015 13:54:35 +0000
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZsWc6-0000bl-5y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Oct 2015 13:54:35 +0000
Received: by obdgf3 with SMTP id gf3so1019940obd.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 31 Oct 2015 06:54:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5631BB4E.4010301@kot-begemot.co.uk>
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
Date: Sat, 31 Oct 2015 14:54:28 +0100
Message-ID: <CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH v3] um: Switch clocksource to hrtimers
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Oct 29, 2015 at 7:23 AM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> I got the first patchset to build, it works very well on a single core
> host or with CPU pinning of the UML - the performance gain is > 25%.
>
> However, I introduced a race somewhere along the way - it crashes UML
> reliably if you do not pin CPUs.

How does the crash look like?
I see also an issue with that patch, after UML has an uptime of a few minutes
a task which does nanosleep() will never wake up.

[<000000006001a29d>] __switch_to+0x53/0x82
[<00000000602995d2>] __schedule+0x2f4/0x3f7
[<0000000060299751>] schedule+0x7c/0x95
[<000000006029b871>] do_nanosleep+0x8b/0x134
[<0000000060068a41>] hrtimer_nanosleep+0xb2/0x15a
[<0000000060068b90>] SyS_nanosleep+0xa7/0xbf
[<000000006001d492>] handle_syscall+0x6a/0x84
[<00000000600304a8>] userspace+0x3d8/0x463
[<000000006001a180>] fork_handler+0x85/0x87
[<ffffffffffffffff>] 0xffffffffffffffff

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

