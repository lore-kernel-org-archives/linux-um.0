Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1755448AbZCTIUp@vger.kernel.org>
Subject: Re: [patch] fix uml slowness caused by ptrace preemption bug on
 host
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu>
References: <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Mar 2009 09:19:29 +0100
Message-Id: <1237537169.24626.29.camel@twins>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: roland@redhat.com, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, mingo@elte.hu, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2009-03-19 at 23:23 +0100, Miklos Szeredi wrote:
> From: Miklos Szeredi <mszeredi@suse.cz>
> 
> This patch fixes bug #12208.
> 
> This turned out to be not a scheduler regression, but an already
> existing problem in ptrace being triggered by subtle scheduler
> changes.
> 
> The problem is this:
> 
>  - task A is ptracing task B
>  - task B stops on a trace event
>  - task A is woken up and preempts task B
>  - task A calls ptrace on task B, which does ptrace_check_attach()
>  - this calls wait_task_inactive(), which sees that task B is still on the runq
>  - task A goes to sleep for a jiffy
>  - ...
> 
> Since UML does lots of the above sequences, those jiffies quickly add
> up to make it slow as hell.
> 
> This patch solves this by not scheduling on preempt_enable() after
> ptrace_stop() has woken up the tracer.

Nice,.. however did you find this?

Ingo is looking at changing wait_task_inactive() to not be quite so
stupid. I'll let him respond with more details when he's done poking at
the code :-)


