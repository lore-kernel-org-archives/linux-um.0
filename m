Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMvVt-005ccw-4P
 for linux-um@lists.infradead.org; Thu, 18 Mar 2021 16:28:47 +0000
Message-ID: <2b055a98f6e5e12959f331ed5cc9acb14960da04.camel@sipsolutions.net>
Subject: Re: [RFC v8 00/20] Unifying LKL into UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 18 Mar 2021 17:28:38 +0100
In-Reply-To: <m2v99oa6m7.wl-thehajime@gmail.com>
 (sfid-20210318_151735_819777_85B2C8F0)
References: <cover.1601960644.git.thehajime@gmail.com>
 <cover.1611103406.git.thehajime@gmail.com>
 <d357fbd075319d8b32667323bc545e3e5e8e8a21.camel@sipsolutions.net>
 <m2czvzc2xw.wl-thehajime@gmail.com>
 <bc30898d6ac14c5c6e7eeeb72e41353a298bdf65.camel@sipsolutions.net>
 <CAMoF9u3q_uhvzT0RJj42fAVQpVf-nnwXM9Zh_qXxYAG8YHcOUQ@mail.gmail.com>
 <8c6f4ba994831b55ce7893f7e8e71a614474b907.camel@sipsolutions.net>
 <m2v99oa6m7.wl-thehajime@gmail.com> (sfid-20210318_151735_819777_85B2C8F0)
MIME-Version: 1.0
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: tavi.purdila@gmail.com, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com

Hi,

> I also have an idea for a ThreadX in future, which also implements
> actual context in the application/environment/host side (not in kernel
> side, as others do).  Though this environment may not provide
> mprotect-like features, there is still a value that the application
> can run Linux code (e.g., network stack) for instance.

Heh. Right.

> I agree that LKL (or the library mode) can conceptually offer both
> NOMMU/MMU capabilities.
> 
> I also think that NOMMU library could be the first step and a minimum
> product as MMU implementation may involve a lot of refactoring which
> may need more consideration to the current codebase.
> 
> We tried with MMU mode library, by sharing build system
> (Kconfig/Makefile) and runtime facilities (thread/irq/memory).  But,
> we could only do share irq handling for this first step.
> 
> When we implement the MMU mode library in future, we may come up with
> another abstraction/refactoring into the UML design, which could be a
> good outcome.  But I think it is beyond the minimum given (already)
> big changes with the current patchset.

Well, arguably that depends on how you look at it.

Understandably, you're looking at this from the POV of getting an "MVP"
(minimum viable product) into mainline as soon as possible.

I can understand why you would do that, and this patchset achieves it:
you get an LKL in mainline that's useful, even if it doesn't achieve the
best possible architecture and code sharing.

But look at it from the opposite side, from mainline's view (at least in
my opinion, others may disagree): getting an LKL (whether as an MVP or
not) isn't really that important! Getting the architecture and code
sharing right are likely the *primary* goals for mainline this
integration.

So from my POV it's *more important* to get the shared facilities,
proper abstraction and refactoring right, likely to the point where UML
is actually "small binary using the library" (in some fashion). Even if
that initially means there actually *won't* be NOMMU mode and a library
that's useful for the LKL use cases.

Yes, that's the longer road into mainline, but it also means that each
step along the way is actually useful to mainline, I'm assuming here
that the necessary code refactoring, abstraction, etc. will by itself
provide some value to UML, but given the messy state it's in, I think
that's almost certainly going to be true.

So a sense "getting LKL into UML" is at odds with "get LKL working
quickly". However, doing it this way may ultimately get it into mainline
faster because it's a much easier incremental route. Say you want to get
all this thread stuff out of the way that we discussed - then if you
need to keep UML working but *using* the abstraction you're adding (in
order to work towards the goal of it using the library) then it becomes
fairly obvious that you cannot use the abstraction that you have with
pthreads, mutexes, and semaphores exposed via APIs, but need to build
the API on "thread switching" primitives instead. I would expect similar
things to be true for other places.


Now, are you/we up for that? I don't know. On the one hand, I know
you're persistent and interested in this, but on the other hand it's
somewhat at odds with your goals. I believe for mainline it'd be better
because the code is no worse off each step along the way.

Taking the thread example again, if we have a thread switching
abstraction and an implementation in UML, worst case (e.g. if you lose
interest) is that it's a somewhat pointless abstraction there, but it
doesn't really make the code significantly worse or more complex.

OTOH, having what we have now with pthreads/mutexes/semaphores *does*
make the code significantly more complex and harder to maintain (IMHO)
because it adds all kinds of special cases, and they're somewhat more
difficult to exercise (yes, there are examples, still).


In any case, I don't think I'm the one making the decisions here, so
take this with a grain of salt.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

