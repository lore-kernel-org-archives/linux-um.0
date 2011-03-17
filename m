Return-Path: <rostedt@goodmis.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <AANLkTim4hY_HJrukNjVe5RDzBj7r547BcxKRozKcQ_uE@mail.gmail.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	 <1300370936.16880.96.camel@gandalf.stny.rr.com>
	 <AANLkTi=Z_yYkdwzO7TMs7nSMOXR9wn_7BxtKjOKgS5HL@mail.gmail.com>
	 <1300380909.16880.264.camel@gandalf.stny.rr.com>
	 <1300381340.6315.323.camel@edumazet-laptop>
	 <1300385802.16880.348.camel@gandalf.stny.rr.com>
	 <AANLkTim4hY_HJrukNjVe5RDzBj7r547BcxKRozKcQ_uE@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Thu, 17 Mar 2011 14:38:22 -0400
Message-ID: <1300387102.16880.391.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2011-03-17 at 19:25 +0100, Geert Uytterhoeven wrote:

> > Does if (do { } while (x, 0)) work?
> 
> No.

Hehe, that was a rhetorical question ;)

-- Steve



