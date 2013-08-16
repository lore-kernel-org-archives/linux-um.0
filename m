Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <520E55A2.9080900@nod.at>
Date: Fri, 16 Aug 2013 18:38:58 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1376668606-32354-1-git-send-email-richard@nod.at> <20130816161229.GI2505@htj.dyndns.org> <520E500B.5000408@nod.at> <20130816162844.GJ2505@htj.dyndns.org>
In-Reply-To: <20130816162844.GJ2505@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] print_worker_info: Handle pointer with more care
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 16.08.2013 18:28, schrieb Tejun Heo:
> On Fri, Aug 16, 2013 at 06:15:07PM +0200, Richard Weinberger wrote:
>> On UML I hit the case that pwq is NULL.
>> Then we oops at &pwq->wq...
> 
> Hmmm?  I'm confused.  &pwq->wq is pwq's pointer + wq's offset in pwq.
> It doesn't involve dereferencing pwq->wq.  Maybe uml isn't
> implementing probe_kernel_thread()?  Now that I think about it, I'm
> not sure how it could.
> 
> cc'ing uml people.  Hey, guys, workqueue uses proble_kernel_read() to
> print out workqueue related information during oops because those
> events are completely asynchronous and workqueue states may not be
> consistently accessible.  It seems like uml doesn't implement
> probe_kernel_read() and tries direct derference of incorrect pointers
> leading to its own oops.  Maybe uml should check whether the memory is
> mapped from probe_kernel_read()?

You are already talking to UML people. ;)
Anyway, I'll investigate into that.
What I see so far is that pwq is NULL after probe_kernel_read().

Thanks,
//richard
