Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4BCB464A.702@web.de>
References: <4BCB464A.702@web.de>
From: Paolo Giarrusso <p.giarrusso@gmail.com>
Date: Mon, 17 May 2010 16:41:25 +0200
Message-ID: <AANLkTilQfz-PfNf6ZTqguMKBsADghbK4pEBGVzpjSurm@mail.gmail.com>
Subject: Re: [uml-devel] uml: pthreads instead of manual clone()?
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Apr 18, 2010 at 19:50, Jan Kiszka <jan.kiszka@web.de> wrote:
> Hi Jeff,
>
> is there (still) any reason to use explicit clone() instead of pthreads
> to spawn UML kernel threads?
>
> While playing with a patch to finally move os_nsecs to proper
> CLOCK_MONOTONIC, I noticed some subtle side-effect: We need to link
> against librt for clock_gettime, but that indirectly drags in
> libpthread. Now gdb gets unhappy when you try to debug the UML kernel.
> It assumes that pthreads are used, but fails to find their IDs and
> terminates the session. So the obvious approach appears to be converting
> kernel threads to pthreads - if there aren't any know pitfalls.

I think you should better manually copy the clock_gettime syscall stub
or function (hoping it's simple enough). Basically, we don't want
glibc to do anything by his own free will, like doing TLS setup
(pthread could do that), allocating memory from the heap on its own
(we only allow it very early, and we try to make it still safe - see
the malloc replacement stuff we do through linker and
__real_malloc/_whatever_I_dont_recall_malloc). We got a bug once we
called getpid() just to get a ptrace notification, but glibc cached
the getpid() result: we have our own getpid() syscall stub (at some
point I was writing actual UML code, and I wrote some TLS code myself
- not sure whether it's the current implementation or it was
rewritten).

Then, maybe, it can be made to work, even if I really wonder about the
TLS setup stuff - we need to allow the guest userspace programs to do
basically any [gs]et_thread_area() calls. But it's really untrivial
IMHO.
-- 
Paolo Giarrusso
