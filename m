Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQ4ob-0002va-1u
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 08:28:50 +0000
Received: by mail-ed1-x542.google.com with SMTP id o18so1264772edq.4
 for <linux-um@lists.infradead.org>; Wed, 07 Oct 2020 01:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201006225450.751742-1-jannh@google.com>
 <20201006225450.751742-2-jannh@google.com>
 <115d17aa221b73a479e26ffee52899ddb18b1f53.camel@sipsolutions.net>
In-Reply-To: <115d17aa221b73a479e26ffee52899ddb18b1f53.camel@sipsolutions.net>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Oct 2020 10:28:21 +0200
Message-ID: <CAG48ez2cW0mrSPihrtX6Kus2AYc0hKX8izpzvOMYrnk0eLOAoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, kernel list <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Wed, Oct 7, 2020 at 9:42 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> On Wed, 2020-10-07 at 00:54 +0200, Jann Horn wrote:
> > Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
> > of the old mm (in dup_mmap() and in UML's activate_mm()).
> > A following patch will change the exec path to very broadly lock the
> > nascent mm, but fine-grained locking should still work at the same time for
> > the old mm.
> >
> > In particular, mmap locking calls are hidden behind the copy_from_user()
> > calls and such that are reached through functions like copy_strings() -
> > when a page fault occurs on a userspace memory access, the mmap lock
> > will be taken.
> >
> > To do this in a way that lockdep is happy about, let's turn around the lock
> > ordering in both places that currently nest the locks.
> > Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
> > make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
> > instead.
> >
> > The added locking calls in exec_mmap() are temporary; the following patch
> > will move the locking out of exec_mmap().
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/um/include/asm/mmu_context.h |  3 +--
> >  fs/exec.c                         |  4 ++++
> >  include/linux/mmap_lock.h         | 23 +++++++++++++++++++++--
> >  kernel/fork.c                     |  7 ++-----
> >  4 files changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
> > index 17ddd4edf875..c13bc5150607 100644
> > --- a/arch/um/include/asm/mmu_context.h
> > +++ b/arch/um/include/asm/mmu_context.h
> > @@ -48,9 +48,8 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
> >        * when the new ->mm is used for the first time.
> >        */
> >       __switch_mm(&new->context.id);
> > -     mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
> > +     mmap_assert_write_locked(new);
> >       uml_setup_stubs(new);
> > -     mmap_write_unlock(new);
> >  }
>
> FWIW, this was I believe causing lockdep issues.
>
> I think I had previously determined that this was pointless, since it's
> still nascent and cannot be used yet?

Well.. the thing is that with patch 2/2, I'm not just protecting the
mm while it hasn't been installed yet, but also after it's been
installed, until setup_arg_pages() is done (which still uses a VMA
pointer that we obtained really early in the nascent phase). With the
recent rework Eric Biederman has done to clean up the locking around
execve, operations like process_vm_writev() and (currently only in the
MM tree, not mainline yet) process_madvise() can remotely occur on our
new mm after setup_new_exec(), before we've reached setup_arg_pages().
While AFAIK all those operations *currently* only read the VMA tree,
that would change as soon as someone e.g. changes the list of allowed
operations for process_madvise() to include something like
MADV_MERGEABLE. In that case, we'd get a UAF if the madvise code
merges away our VMA while we still hold and use a dangling pointer to
it.

So in summary, I think the code currently is not (visibly) buggy in
the sense that you can make it do something bad, but it's extremely
fragile and probably only safe by chance. This patchset is partly my
attempt to make this a bit more future-proof before someone comes
along and turns it into an actual memory corruption bug with some
innocuous little change. (Because I've had a situation before where I
thought "oh, this looks really fragile and only works by chance, but
eh, it's not really worth changing that code" and then the next time I
looked, it had turned into a security bug that had already made its
way into kernel releases people were using.)

> But I didn't really know for sure,
> and this patch was never applied:
>
> https://patchwork.ozlabs.org/project/linux-um/patch/20200604133752.397dedea0758.I7a24aaa26794eb3fa432003c1bf55cbb816489e2@changeid/

Eeeh... with all the kernel debugging infrastructure *disabled*,
down_write_nested() is defined as:

# define down_write_nested(sem, subclass) down_write(sem)

and then down_write() is:

void __sched down_write(struct rw_semaphore *sem)
{
  might_sleep();
  rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
  LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
}

and that might_sleep() there is not just used for atomic sleep
debugging, but actually also creates an explicit preemption point
(independent of CONFIG_DEBUG_ATOMIC_SLEEP; here's the version with
atomic sleep debugging *disabled*):

# define might_sleep() do { might_resched(); } while (0)

where might_resched() is:

#ifdef CONFIG_PREEMPT_VOLUNTARY
extern int _cond_resched(void);
# define might_resched() _cond_resched()
#else
# define might_resched() do { } while (0)
#endif

_cond_resched() has a check for preempt_count before triggering the
scheduler, but on PREEMPT_VOLUNTARY without debugging, taking a
spinlock currently won't increment that, I think. And even if
preempt_count was active for PREEMPT_VOLUNTARY (which I think the x86
folks were discussing?), you'd still hit a call into the RCU core,
which probably shouldn't be happening under a spinlock either.

Now, arch/um/ sets ARCH_NO_PREEMPT, so we can't actually be configured
with PREEMPT_VOLUNTARY, so this can't actually happen. But it feels
like we're on pretty thin ice here.

> I guess your patches will also fix the lockdep complaints in UML in this
> area, I hope I'll be able to test it soon.

That would be a nice side effect. :)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

