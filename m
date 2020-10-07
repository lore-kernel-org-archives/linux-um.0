Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQ46F-0005Au-4A
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 07:43:00 +0000
Message-ID: <115d17aa221b73a479e26ffee52899ddb18b1f53.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] mmap locking API: Order lock of nascent mm
 outside lock of live mm
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 09:42:42 +0200
In-Reply-To: <20201006225450.751742-2-jannh@google.com>
References: <20201006225450.751742-1-jannh@google.com>
 <20201006225450.751742-2-jannh@google.com>
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
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W . Biederman  <ebiederm@xmission.com>, Jason Gunthorpe <jgg@nvidia.com>, John Hubbard" <jhubbard@nvidia.com>, Michel Lespinasse <walken@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Wed, 2020-10-07 at 00:54 +0200, Jann Horn wrote:
> Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
> of the old mm (in dup_mmap() and in UML's activate_mm()).
> A following patch will change the exec path to very broadly lock the
> nascent mm, but fine-grained locking should still work at the same time for
> the old mm.
> 
> In particular, mmap locking calls are hidden behind the copy_from_user()
> calls and such that are reached through functions like copy_strings() -
> when a page fault occurs on a userspace memory access, the mmap lock
> will be taken.
> 
> To do this in a way that lockdep is happy about, let's turn around the lock
> ordering in both places that currently nest the locks.
> Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
> make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
> instead.
> 
> The added locking calls in exec_mmap() are temporary; the following patch
> will move the locking out of exec_mmap().
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/um/include/asm/mmu_context.h |  3 +--
>  fs/exec.c                         |  4 ++++
>  include/linux/mmap_lock.h         | 23 +++++++++++++++++++++--
>  kernel/fork.c                     |  7 ++-----
>  4 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
> index 17ddd4edf875..c13bc5150607 100644
> --- a/arch/um/include/asm/mmu_context.h
> +++ b/arch/um/include/asm/mmu_context.h
> @@ -48,9 +48,8 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
>  	 * when the new ->mm is used for the first time.
>  	 */
>  	__switch_mm(&new->context.id);
> -	mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
> +	mmap_assert_write_locked(new);
>  	uml_setup_stubs(new);
> -	mmap_write_unlock(new);
>  }

FWIW, this was I believe causing lockdep issues.

I think I had previously determined that this was pointless, since it's
still nascent and cannot be used yet? But I didn't really know for sure,
and this patch was never applied:

https://patchwork.ozlabs.org/project/linux-um/patch/20200604133752.397dedea0758.I7a24aaa26794eb3fa432003c1bf55cbb816489e2@changeid/

I guess your patches will also fix the lockdep complaints in UML in this
area, I hope I'll be able to test it soon.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

