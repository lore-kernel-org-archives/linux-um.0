Return-Path: <peterz@infradead.org>
Date: Fri, 9 Oct 2020 13:42:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009114216.GM2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009091218.GF4967@dhcp22.suse.cz>
 <20201009094245.GG2628@hirez.programming.kicks-ass.net>
 <20201009101044.GH4967@dhcp22.suse.cz>
 <20201009101431.GJ2628@hirez.programming.kicks-ass.net>
 <20201009103730.GJ4967@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009103730.GJ4967@dhcp22.suse.cz>
To: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbecker@suse.de>, LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

On Fri, Oct 09, 2020 at 12:37:30PM +0200, Michal Hocko wrote:
> On Fri 09-10-20 12:14:31, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2020 at 12:10:44PM +0200, Michal Hocko wrote:
> > > On Fri 09-10-20 11:42:45, Peter Zijlstra wrote:
> > > > On Fri, Oct 09, 2020 at 11:12:18AM +0200, Michal Hocko wrote:
> > > > > Is there any additional feedback? Should I split up the patch and repost
> > > > > for inclusion?
> > > > 
> > > > Maybe remove PREEMPT_NONE after that?  Since that's then equivalent to
> > > > building with VOLUNTARY and booting with preempt=none.
> > > 
> > > So do you mean that I should post an additional patch which does this on
> > > top? With a justification that there is one option less to chose from?
> > 
> > Exactly!
> 
> It seems we have to get rid of CONFIG_NO_PREEMPT first
> $ git grep ARCH_NO_PREEMPT
> arch/Kconfig:config ARCH_NO_PREEMPT
> arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> arch/um/Kconfig:        select ARCH_NO_PREEMPT
> kernel/Kconfig.preempt: depends on !ARCH_NO_PREEMPT
> kernel/Kconfig.preempt: depends on !ARCH_NO_PREEMPT
> lib/Kconfig.debug:      select PREEMPT_COUNT if !ARCH_NO_PREEMPT
> lib/Kconfig.debug:      depends on !ARCH_NO_PREEMPT
> 
> Is there anybody working on that. Is this even possible? I can see it
> has been added by 87a4c375995e ("kconfig: include kernel/Kconfig.preempt
> from init/Kconfig") but this looks more like a mechanical change and it
> has defined ARCH_NO_PREEMPT all arches which haven't included
> Kconfig.preempt. But is there any reason why those cannot support
> preemption for some reason? Cc respective maintainer (the email thread
> starts http://lkml.kernel.org/r/20201007120401.11200-1-mhocko@kernel.org

I suspect we can drop ARCH_NO_PREEMPT from VOLUNTARY, IIRC there's no
arch dependency there. PREEMPT itself obviously needs arch help.

