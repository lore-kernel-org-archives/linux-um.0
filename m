Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izLEd-0005BN-9Q
 for linux-um@lists.infradead.org; Wed, 05 Feb 2020 14:00:56 +0000
Received: by mail-lj1-x241.google.com with SMTP id w1so2413803ljh.5
 for <linux-um@lists.infradead.org>; Wed, 05 Feb 2020 06:00:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
 <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
 <20200205124908.GL14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200205124908.GL14879@hirez.programming.kicks-ass.net>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Wed, 5 Feb 2020 16:00:41 +0200
Message-ID: <CAMoF9u12nko0rBGT_iOgXtapuRitS9jSMzAoo8tTykn2dZGK7g@mail.gmail.com>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Will Deacon <will@kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Wed, Feb 5, 2020 at 2:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 05, 2020 at 02:24:38PM +0200, Octavian Purdila wrote:
> > I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
>
> It might not have been, but presented with this patch, I feel like it
> should've been :-)
>
> > understand your point that a 64 bit architecture that can't handle 64
> > bit atomic operation is broken.
>
> (sadly they actually exist, I shall name no names)
>
> > One way to deal with this in LKL would be to use GCC atomic builtins
> > or if that doesn't work expose them as host operations. This would
> > keep LKL as a meta-arch that can run on multiple physical
> > architectures. I'll give it a try.
>
> What is this LKL you speak of and how does it do the 32bit atomics?
>

LKL is a build of the Linux kernel as a library that can run in many
environments including multiple architectures and OSes [1]

For 32bit atomics LKL also uses the asm-generic implementation. It is
very similar with generic 64bit atomic implementation and it is used
by multiple 32bit arches. I think this was my original reasoning for
this patch and not going with C11 atomics.

> One thing to keep in mind is that the C11 atomics (_Atomic) don't
> trivially map to the LKMM -- although I keep forgetting the exact
> details, there is a paper on it somewhere.  Also, once you're limited to
> a specific arch the issue also becomes much easier than C11 vs LKMM in
> general.

Thanks, I will look it up.

[1] https://github.com/lkl/linux

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

