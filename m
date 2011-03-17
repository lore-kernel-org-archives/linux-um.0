Return-Path: <rostedt@goodmis.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1300387122.6315.407.camel@edumazet-laptop>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	 <1300370936.16880.96.camel@gandalf.stny.rr.com>
	 <AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	 <1300380909.16880.264.camel@gandalf.stny.rr.com>
	 <1300381340.6315.323.camel@edumazet-laptop>
	 <1300385802.16880.348.camel@gandalf.stny.rr.com>
	 <AANLkTim4hY_HJrukNjVe5RDzBj7r547BcxKRozKcQ_uE@mail.gmail.com>
	 <1300387122.6315.407.camel@edumazet-laptop>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Thu, 17 Mar 2011 14:43:37 -0400
Message-ID: <1300387417.16880.399.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, richard -rw- weinberger <richard.weinberger@gmail.com>, laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2011-03-17 at 19:38 +0100, Eric Dumazet wrote:
>  
> 
> My point was that WARN_ON(X) always evaluates X once
> 
> And apparently, WARN_ON_SMP(X) doesnt evaluates X iF !SMP
> 
> This should be documented, or fixed ;)

My new patch has it documented. I even explain when to use the _SMP()
version, which is mainly for !spin_is_locked() as spin_is_locked()
always returns false, and !0 will trigger the warning.

It can also be used to test values that only exist in SMP.

struct foo {
	[...]
#ifdef CONFIG_SMP
	int bar;
#endif
};


	WARN_ON_SMP(zoo->bar);

We don't want that zoo->bar even evaluated for that case.

-- Steve




