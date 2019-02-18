Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 18 Feb 2019 14:58:20 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
Message-ID: <20190218145820.GA16091@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <20190214103715.GI32494@hirez.programming.kicks-ass.net>
 <20190215184056.GC15084@fuggles.cambridge.arm.com>
 <a45d8b68-5623-d6fe-8080-072994f7625e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a45d8b68-5623-d6fe-8080-072994f7625e@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Fri, Feb 15, 2019 at 01:58:34PM -0500, Waiman Long wrote:
> On 02/15/2019 01:40 PM, Will Deacon wrote:
> > On Thu, Feb 14, 2019 at 11:37:15AM +0100, Peter Zijlstra wrote:
> >> On Wed, Feb 13, 2019 at 05:00:14PM -0500, Waiman Long wrote:
> >>> v4:
> >>>  - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.
> >>>
> >>> v3:
> >>>  - Optimize __down_read_trylock() for the uncontended case as suggested
> >>>    by Linus.
> >>>
> >>> v2:
> >>>  - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
> >>>  - Update performance test data in patch 1.
> >>>
> >>> The goal of this patchset is to remove the architecture specific files
> >>> for rwsem-xadd to make it easer to add enhancements in the later rwsem
> >>> patches. It also removes the legacy rwsem-spinlock.c file and make all
> >>> the architectures use one single implementation of rwsem - rwsem-xadd.c.
> >>>
> >>> Waiman Long (3):
> >>>   locking/rwsem: Remove arch specific rwsem files
> >>>   locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
> >>>     archs
> >>>   locking/rwsem: Optimize down_read_trylock()
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>
> >> with the caveat that I'm happy to exchange patch 3 back to my earlier
> >> suggestion in case Will expesses concerns wrt the ARM64 performance of
> >> Linus' suggestion.
> > Right, the current proposal doesn't work well for us, unfortunately. Which
> > was your earlier suggestion?
> >
> > Will
> 
> In my posting yesterday, I showed that most of the trylocks done were
> actually uncontended. Assuming that pattern hold for the most of the
> workloads, it will not that bad after all.

That's fair enough; if you're going to sit in a tight trylock() loop like the
benchmark does, then you're much better off just calling lock() if you care
at all about scalability.

Will

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

