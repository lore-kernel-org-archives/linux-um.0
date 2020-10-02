Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOHCX-0004j8-GV
 for linux-um@lists.infradead.org; Fri, 02 Oct 2020 09:18:06 +0000
Received: by mail-yb1-xb41.google.com with SMTP id j76so695855ybg.3
 for <linux-um@lists.infradead.org>; Fri, 02 Oct 2020 02:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
In-Reply-To: <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
From: Michel Lespinasse <walken@google.com>
Date: Fri, 2 Oct 2020 02:17:49 -0700
Message-ID: <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
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
To: Jann Horn <jannh@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Oct 1, 2020 at 6:25 PM Jann Horn <jannh@google.com> wrote:
> Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
> of the old mm (in dup_mmap() and in UML's activate_mm()).
> A following patch will change the exec path to very broadly lock the
> nascent mm, but fine-grained locking should still work at the same time for
> the new mm.
> To do this in a way that lockdep is happy about, let's turn around the lock
> ordering in both places that currently nest the locks.
> Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
> make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
> instead.
>
> The added locking calls in exec_mmap() are temporary; the following patch
> will move the locking out of exec_mmap().

Thanks for doing this.

This is probably a silly question, but I am not sure exactly where we
lock the old MM while bprm is creating the new MM ? I am guessing this
would be only in setup_arg_pages(), copying the args and environment
from the old the the new MM ? If that is correct, then wouldn't it be
sufficient to use mmap_write_lock_nested in setup_arg_pages() ? Or, is
the issue that we'd prefer to have a killable version of it there ?

Also FYI I was going to play with these patches a bit to help answer
these questions on my own, but wasn't able to easily apply them as
they came lightly mangled (whitespace issues) when I saved them.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

