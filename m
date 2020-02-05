Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 5 Feb 2020 18:13:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Message-ID: <20200205171306.GP14879@hirez.programming.kicks-ass.net>
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
 <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
 <20200205124908.GL14879@hirez.programming.kicks-ass.net>
 <CAMoF9u12nko0rBGT_iOgXtapuRitS9jSMzAoo8tTykn2dZGK7g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMoF9u12nko0rBGT_iOgXtapuRitS9jSMzAoo8tTykn2dZGK7g@mail.gmail.com>
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
To: Octavian Purdila <tavi.purdila@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Will Deacon <will@kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Wed, Feb 05, 2020 at 04:00:41PM +0200, Octavian Purdila wrote:
> On Wed, Feb 5, 2020 at 2:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Feb 05, 2020 at 02:24:38PM +0200, Octavian Purdila wrote:
> > > I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
> >
> > It might not have been, but presented with this patch, I feel like it
> > should've been :-)
> >
> > > understand your point that a 64 bit architecture that can't handle 64
> > > bit atomic operation is broken.
> >
> > (sadly they actually exist, I shall name no names)
> >
> > > One way to deal with this in LKL would be to use GCC atomic builtins
> > > or if that doesn't work expose them as host operations. This would
> > > keep LKL as a meta-arch that can run on multiple physical
> > > architectures. I'll give it a try.
> >
> > What is this LKL you speak of and how does it do the 32bit atomics?
> >
> 
> LKL is a build of the Linux kernel as a library that can run in many
> environments including multiple architectures and OSes [1]

Thanks, I'll put it on the to-read list.

> For 32bit atomics LKL also uses the asm-generic implementation. It is
> very similar with generic 64bit atomic implementation and it is used
> by multiple 32bit arches. I think this was my original reasoning for
> this patch and not going with C11 atomics.

Uh no, asm-generic/atomic.h is radically different from lib/atomic64.c.

asm-generic/atomic.h builds all required atomic operations from
cmpxchg() (loops), while lib/atomic64.c builds 64bit atomics by using a
hashed set of spinlocks.

The asm-generic stuff gives you real atomic ops, albeit sub-optimal,
lib/atomic64.c gives you a turd.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

