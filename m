Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from nat-hk.nvidia.com ([203.18.50.4])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQ8JH-0007Xr-LL
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 12:12:45 +0000
Date: Wed, 7 Oct 2020 09:12:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] exec: Broadly lock nascent mm until
 setup_arg_pages()
Message-ID: <20201007121234.GS4734@nvidia.com>
References: <20201006225450.751742-1-jannh@google.com>
 <20201006225450.751742-3-jannh@google.com>
Content-Disposition: inline
In-Reply-To: <20201006225450.751742-3-jannh@google.com>
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
To: Jann Horn <jannh@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Wed, Oct 07, 2020 at 12:54:50AM +0200, Jann Horn wrote:
> @@ -1545,6 +1532,18 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	me->mm->task_size = TASK_SIZE;
>  	mutex_unlock(&me->signal->exec_update_mutex);
>  	mutex_unlock(&me->signal->cred_guard_mutex);
> +
> +#ifndef CONFIG_MMU
> +	/*
> +	 * On MMU, setup_arg_pages() wants to access bprm->vma after this point,
> +	 * so we can't drop the mmap lock yet.
> +	 * On !MMU, we have neither setup_arg_pages() nor bprm->vma, so we
> +	 * should drop the lock here.
> +	 */
> +	mmap_write_unlock(bprm->mm);
> +	mmput(bprm->mm);
> +	bprm->mm = NULL;
> +#endif
>  }

It looks like this could this be a

  if (!IS_ENABLED(CONFIG_MMU))

This all seems nice, more locking points were removed than added at
least

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

