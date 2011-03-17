Return-Path: <rostedt@goodmis.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <AANLkTik6oHOOk+1paSmCs=0c03_J10wGBFrRMQw-Jo86@mail.gmail.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	 <1300370936.16880.96.camel@gandalf.stny.rr.com>
	 <AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	 <1300380909.16880.264.camel@gandalf.stny.rr.com>
	 <1300381340.6315.323.camel@edumazet-laptop>
	 <AANLkTik6oHOOk+1paSmCs=0c03_J10wGBFrRMQw-Jo86@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Thu, 17 Mar 2011 14:22:01 -0400
Message-ID: <1300386121.16880.359.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2011-03-17 at 18:43 +0100, Geert Uytterhoeven wrote:

> I don't know. It's not clear to me if "WARN_ON_SMP(x)" should always return "x",
> or only on SMP?
> 
> E.g.
> 
>     if (WARN_ON_SMP(x)) {
>        // Should we get here if "x" is true?
>        // Or only if CONFIG_SMP and "x" are both true?
>     }
> 

The "Or only if CONFIG_SMP and "x" are both true.

I'll update the change to add a comment about that.

-- Steve



