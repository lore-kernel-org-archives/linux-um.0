Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Zup05-0004BY-PP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Nov 2015 21:56:49 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zup04-0003IW-Dg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Nov 2015 21:56:49 +0000
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <563D2217.1070002@nod.at>
Date: Fri, 6 Nov 2015 22:56:39 +0100
MIME-Version: 1.0
In-Reply-To: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
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
Subject: Re: [uml-devel] [PATCH v4] um: Switch clocksource to hrtimers
To: Anton Ivanov <aivanov@brocade.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Thomas Meyer <thomas@m3y3r.de>

Am 02.11.2015 um 17:16 schrieb Anton Ivanov:
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
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> Signed-off-by: Anton Ivanov <aivanov@brocade.com>

Applied!

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

