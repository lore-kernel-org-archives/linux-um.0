Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from nat-hk.nvidia.com ([203.18.50.4])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUx6w-00078K-Ag
 for linux-um@lists.infradead.org; Tue, 20 Oct 2020 19:15:55 +0000
Date: Tue, 20 Oct 2020 16:15:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH resend v3 2/2] exec: Broadly lock nascent mm until
 setup_arg_pages()
Message-ID: <20201020191540.GM6219@nvidia.com>
References: <20201016225713.1971256-1-jannh@google.com>
 <20201016225713.1971256-3-jannh@google.com>
Content-Disposition: inline
In-Reply-To: <20201016225713.1971256-3-jannh@google.com>
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
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, Oct 17, 2020 at 12:57:13AM +0200, Jann Horn wrote:
> @@ -374,17 +366,12 @@ static int bprm_mm_init(struct linux_binprm *bprm)
>  	task_unlock(current->group_leader);
>  
>  	err = __bprm_mm_init(bprm);
> -	if (err)
> -		goto err;
> -
> -	return 0;
> -
> -err:
> -	if (mm) {
> -		bprm->mm = NULL;
> -		mmdrop(mm);
> -	}
> +	if (!err)
> +		return 0;
>  
> +	bprm->mm = NULL;
> +	mmap_write_unlock(mm);
> +	mmdrop(mm);
>  	return err;

nit, but prefer 'success-oriented-flow' eg invert the 'if (!err)' and
put the error unwind in the {}

> @@ -1545,6 +1532,18 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	me->mm->task_size = TASK_SIZE;
>  	mutex_unlock(&me->signal->exec_update_mutex);
>  	mutex_unlock(&me->signal->cred_guard_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_MMU)) {
> +		/*
> +		 * On MMU, setup_arg_pages() wants to access bprm->vma after
> +		 * this point, so we can't drop the mmap lock yet.
> +		 * On !MMU, we have neither setup_arg_pages() nor bprm->vma,
> +		 * so we should drop the lock here.
> +		 */
> +		mmap_write_unlock(bprm->mm);
> +		mmput(bprm->mm);
> +		bprm->mm = NULL;
> +	}

The only thing I dislike about this is how tricky the lock lifetime
is, it all looks correct, but expecting the setup_arg_pages() or
setup_new_exec() to unlock (depending!) is quite tricky.

It feels like it would be clearer to have an explicit function to do
this, like 'release_brp_mm()' indicating that current->mm is now the
only way to get the mm and it must be locked.

Or, more practically, the load_binary functionc can now call
vm_mmap().

Anyhow, it took a bit to study all the parts but I think it looks
right as is.

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

