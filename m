Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZqQJg-0007AM-1d
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Oct 2015 18:46:52 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZqQJe-0003fM-Ew
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Oct 2015 18:46:52 +0000
Message-ID: <562D236E.7020108@kot-begemot.co.uk>
Date: Sun, 25 Oct 2015 18:46:06 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
In-Reply-To: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>

Hi List, hi Richard,

I am going to sort out the UBD patchset next as that has no dependencies 
on timer and the other stuff which is waiting in the queue behind the 
timers.

That should give UML a significant boost. It is nothing particularly 
revolutionary (qemu has been using some of that for ages).

I should be able to get these out of the door early on this week.

A.

P.S. If there is anything to fix on the timer one, please shout.

A.

On 21/10/15 09:42, Anton Ivanov wrote:
> Background: UML is using an obsolete itimer call for
> all timers and "polls" for kernel space timer firing
> in its userspace portion resulting in a long list
> of bugs and incorrect behaviour(s). It also uses
> ITIMER_VIRTUAL for its timer which results in the
> timer being dependent on it running and the cpu
> load.
>
> This patch fixes this by moving to posix high resolution
> timers firing off CLOCK_MONOTONIC and relaying the timer
> correctly to the UML userspace.
>
> FIXES: crashes when hosts suspends/resumes
>
> FIXES: broken userspace timers - effecive ~40Hz instead
> of what they should be. Note - this modifies skas behavior
> by no longer setting an itimer per clone(). Timer events
> are relayed instead.
>
> FIXES: kernel network packet scheduling disciplines
> FIXES: tcp behaviour especially under load
> FIXES: various timer related corner cases
>
> IMPROVES: overall responsiveness of the userspace
>
> Signed-off-by: Anton Ivanov <aivanov@brocade.com>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>   arch/um/Makefile                        |   2 +-
>   arch/um/include/shared/os.h             |  15 +-
>   arch/um/include/shared/skas/stub-data.h |   5 +-
>   arch/um/include/shared/timer-internal.h |  13 ++
>   arch/um/kernel/process.c                |   6 +-
>   arch/um/kernel/skas/clone.c             |   5 -
>   arch/um/kernel/skas/mmu.c               |   2 +
>   arch/um/kernel/time.c                   |  71 +++++----
>   arch/um/os-Linux/internal.h             |   1 -
>   arch/um/os-Linux/main.c                 |   6 +-
>   arch/um/os-Linux/process.c              |   5 +
>   arch/um/os-Linux/signal.c               |  35 +++--
>   arch/um/os-Linux/skas/process.c         |  44 ++----
>   arch/um/os-Linux/time.c                 | 248 ++++++++++++++++----------------
>   14 files changed, 231 insertions(+), 227 deletions(-)
>   create mode 100644 arch/um/include/shared/timer-internal.h
>   delete mode 100644 arch/um/os-Linux/internal.h
>

[snip]


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

