Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ke9dt-000108-CU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 07:29:01 -0700
Received: from x346.tv-sign.ru ([89.108.83.215] helo=mail.screens.ru)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ke9dq-0003SQ-RS
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 07:29:01 -0700
Date: Fri, 12 Sep 2008 18:32:25 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
Message-ID: <20080912143225.GA108@tv-sign.ru>
References: <48C51439.7000706@linux.vnet.ibm.com>
	<20080909124302.GA139@tv-sign.ru>
	<48C7E3A9.3060602@linux.vnet.ibm.com>
	<20080910162008.GA401@tv-sign.ru>
	<48CA5E4F.2020600@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48CA5E4F.2020600@linux.vnet.ibm.com>
Subject: Re: [uml-devel] [PATCH 1/1] system call notification with self_ptrace
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: sameske@linux.vnet.ibm.com, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, gregkh@suse.de, Heiko Carstens <heicars2@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>, Daniel Lezcano <dlezcano@fr.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>

Hello Pierre,

On 09/12, Pierre Morel wrote:
>
> You are right, the functionality can be implemented with the system call.
> But it means we have the overhead of a system call just to clear two bits,
> the TIF_SYSCALL_TRACE and the PTS_SELF.

Yes.

So you want to optimize the code for the (imho very exotic) functionality.
And again, the overhead of a system call is nothing compared to the signal
delivery. I bet this overhead won't be visible with any benchmark.

> On the other hand we have an overhead of one single "if" inside
> the handle_signal() function.

What if everyone who wants to add the new functionality will add one
single "if + code" to the core kernel just because he wants to add
a very minor optimization for his needs?

And you forgot about the maintaince overhead. You forgot that this extra
"if" uglifies/complicates the code.

This all is imho of course, and I'm not maintainer. But I promise I
will argue against this change forever ;)

> We can do the same with fork and ptrace, yes, but with a very big 
> overhead on each system call and this is why this patch is so usefull: 
> because with this patch you sit inside the thread when analysing it and 
> have a direct access to all data without the need of IPC, ptrace or any 
> task switch.
>
> I will provide a test program and plan to release a tracing tool based 
> on it.

Yes please, this would be very nice. Please do not count me, but I'm
afraid I am not alone who needs to really understand why this patch
is useful.

Oleg.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
