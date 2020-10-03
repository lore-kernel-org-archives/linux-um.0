Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
 <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com> <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com>
In-Reply-To: <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com>
From: Michel Lespinasse <walken@google.com>
Date: Sat, 3 Oct 2020 14:30:28 -0700
Message-ID: <CANN689H6fQkSXL8U0M-MoSrw8b8cQFMDaTRKr2v8oacZJ_FhKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
Content-Type: text/plain; charset="UTF-8"
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
List-ID: <linux-um.lists.infradead.org>

On Fri, Oct 2, 2020 at 9:33 AM Jann Horn <jannh@google.com> wrote:
> On Fri, Oct 2, 2020 at 11:18 AM Michel Lespinasse <walken@google.com> wrote:
> > On Thu, Oct 1, 2020 at 6:25 PM Jann Horn <jannh@google.com> wrote:
> > > Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
> > > of the old mm (in dup_mmap() and in UML's activate_mm()).
> > > A following patch will change the exec path to very broadly lock the
> > > nascent mm, but fine-grained locking should still work at the same time for
> > > the new mm.
> > > To do this in a way that lockdep is happy about, let's turn around the lock
> > > ordering in both places that currently nest the locks.
> > > Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
> > > make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
> > > instead.
> > >
> > > The added locking calls in exec_mmap() are temporary; the following patch
> > > will move the locking out of exec_mmap().
> >
> > Thanks for doing this.
> >
> > This is probably a silly question, but I am not sure exactly where we
> > lock the old MM while bprm is creating the new MM ? I am guessing this
> > would be only in setup_arg_pages(), copying the args and environment
> > from the old the the new MM ? If that is correct, then wouldn't it be
> > sufficient to use mmap_write_lock_nested in setup_arg_pages() ? Or, is
> > the issue that we'd prefer to have a killable version of it there ?
>
> We're also implicitly locking the old MM anytime we take page faults
> before exec_mmap(), which basically means the various userspace memory
> accesses in do_execveat_common(). This happens after bprm_mm_init(),
> so we've already set bprm->vma at that point.

Ah yes, I see the issue now. It would be much nicer if copy_strings
could coax copy_from_user into taking a nested lock, but of course
there is no way to do that.

I'm not sure if it'd be reasonable to kmap the source pages like we do
for the destination pages ?

Adding a nascent lock instead of a nested lock, as you propose, seems
to work, but it also looks quite unusual. Not that I have anything
better to propose at this point though...


Unrelated to the above: copy_from_user and copy_to_user should not be
called with mmap_lock held; it may be worth adding these assertions
too (probably in separate patches) ?


> Uuugh, dammit, I see what happened. Sorry about the trouble. Thanks
> for telling me, guess I'll go back to sending patches the way I did it
> before. :/

Yeah, I've hit such issues with gmail before too :/

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.

