Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZnOP-0000m7-QY
 for linux-um@lists.infradead.org; Tue, 03 Nov 2020 03:53:59 +0000
Received: by mail-lj1-x242.google.com with SMTP id x6so17493114ljd.3
 for <linux-um@lists.infradead.org>; Mon, 02 Nov 2020 19:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20201016225713.1971256-1-jannh@google.com>
 <20201016225713.1971256-3-jannh@google.com>
 <20201020191540.GM6219@nvidia.com>
In-Reply-To: <20201020191540.GM6219@nvidia.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 3 Nov 2020 04:53:27 +0100
Message-ID: <CAG48ez0XS+0sLLsVg_=hJo6MB1MgSCWvCL03EQ3Ja08d_us+ew@mail.gmail.com>
Subject: Re: [PATCH resend v3 2/2] exec: Broadly lock nascent mm until
 setup_arg_pages()
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
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, kernel list <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Oct 20, 2020 at 9:15 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Sat, Oct 17, 2020 at 12:57:13AM +0200, Jann Horn wrote:
> > @@ -1545,6 +1532,18 @@ void setup_new_exec(struct linux_binprm * bprm)
> >       me->mm->task_size = TASK_SIZE;
> >       mutex_unlock(&me->signal->exec_update_mutex);
> >       mutex_unlock(&me->signal->cred_guard_mutex);
> > +
> > +     if (!IS_ENABLED(CONFIG_MMU)) {
> > +             /*
> > +              * On MMU, setup_arg_pages() wants to access bprm->vma after
> > +              * this point, so we can't drop the mmap lock yet.
> > +              * On !MMU, we have neither setup_arg_pages() nor bprm->vma,
> > +              * so we should drop the lock here.
> > +              */
> > +             mmap_write_unlock(bprm->mm);
> > +             mmput(bprm->mm);
> > +             bprm->mm = NULL;
> > +     }
>
> The only thing I dislike about this is how tricky the lock lifetime
> is, it all looks correct, but expecting the setup_arg_pages() or
> setup_new_exec() to unlock (depending!) is quite tricky.
>
> It feels like it would be clearer to have an explicit function to do
> this, like 'release_brp_mm()' indicating that current->mm is now the
> only way to get the mm and it must be locked.

That was a good suggestion; I tried to amend my patch as suggested,
and while trying to do that, noticed that under CONFIG_MMU,
binfmt_flat first does setup_new_exec(), then vm_mmap(), and then
later on setup_arg_pages()...

So your suggestion indeed helped make it clear that my patch was
wrong. Guess I'll have to go figure out how to rearrange the pieces in
binfmt_flat to make this work...

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

