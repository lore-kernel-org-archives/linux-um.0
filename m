Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <4DD68EDF.4030301@linux.intel.com>
References: <201105191526.31904.toralf.foerster@gmx.de>
	 <201105192218.18261.toralf.foerster@gmx.de>
	 <20110519204342.GA10792@home.goodmis.org>
	 <201105200937.15322.toralf.foerster@gmx.de>
	 <BANLkTik0oz6ppJvRpufaaiBL1pqcAxNHuA@mail.gmail.com>
	 <4DD68EDF.4030301@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Fri, 20 May 2011 12:04:17 -0400
Message-ID: <1305907458.1465.23.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: Darren Hart <dvhart@linux.intel.com>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 2011-05-20 at 08:55 -0700, Darren Hart wrote:

> I suspect Toralf is hitting the WARN_ON in __unqueue_futex:
> 
> 	if (WARN_ON(!q->lock_ptr || !spin_is_locked(q->lock_ptr)
> 			|| plist_node_empty(&q->list)))
> 
> Toralf, can you instrument that let us know which of conditions is
> triggering the WARN_ON? Something like the following should be adequate
> to get you the line number. I suspect it is plist_node_empty give the
> git bisect results you reported.
> 
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index abd5324..7f31bca 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -782,8 +782,11 @@ static void __unqueue_futex(struct futex_q *q)
>  {
>  	struct futex_hash_bucket *hb;
> 
> -	if (WARN_ON(!q->lock_ptr || !spin_is_locked(q->lock_ptr)
> -			|| plist_node_empty(&q->list)))
> +	if (WARN_ON(!q->lock_ptr))
> +		return;
> +	if (!spin_is_locked(q->lock_ptr))
> +		return;
> +	if (plist_node_empty(&q->list))
>  		return;
> 

Wait! This is where we need the WARN_ON_SMP(), do we have that patch in?

I think UML is UP, and that spin_is_locked() will always return false.

-- Steve


