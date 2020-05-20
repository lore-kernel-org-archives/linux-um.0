Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbMV4-0004n2-86
 for linux-um@lists.infradead.org; Wed, 20 May 2020 11:03:03 +0000
Date: Wed, 20 May 2020 20:02:55 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 20/20] maccess: return -ERANGE when
 copy_from_kernel_nofault_allowed fails
Message-Id: <20200520200255.3db6d27304f0b4c29c52ebcc@kernel.org>
In-Reply-To: <20200519134449.1466624-21-hch@lst.de>
References: <20200519134449.1466624-1-hch@lst.de>
 <20200519134449.1466624-21-hch@lst.de>
Mime-Version: 1.0
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
To: Christoph Hellwig <hch@lst.de>
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org

On Tue, 19 May 2020 15:44:49 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Allow the callers to distinguish a real unmapped address vs a range
> that can't be probed.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hi Christoph,

Can you also update the kerneldoc comment too?
Other than that, this looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  mm/maccess.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/maccess.c b/mm/maccess.c
> index 1e7d77656c596..4010d64189d21 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -25,7 +25,7 @@ bool __weak copy_from_kernel_nofault_allowed(void *dst, const void *unsafe_src,
>  long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
>  {
>  	if (!copy_from_kernel_nofault_allowed(dst, src, size))
> -		return -EFAULT;
> +		return -ERANGE;
>  
>  	pagefault_disable();
>  	copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
> @@ -69,7 +69,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
>  	if (unlikely(count <= 0))
>  		return 0;
>  	if (!copy_from_kernel_nofault_allowed(dst, unsafe_addr, count))
> -		return -EFAULT;
> +		return -ERANGE;
>  
>  	pagefault_disable();
>  	do {
> @@ -107,7 +107,7 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
>  	mm_segment_t old_fs = get_fs();
>  
>  	if (!copy_from_kernel_nofault_allowed(dst, src, size))
> -		return -EFAULT;
> +		return -ERANGE;
>  
>  	set_fs(KERNEL_DS);
>  	pagefault_disable();
> @@ -174,7 +174,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
>  	if (unlikely(count <= 0))
>  		return 0;
>  	if (!copy_from_kernel_nofault_allowed(dst, unsafe_addr, count))
> -		return -EFAULT;
> +		return -ERANGE;
>  
>  	set_fs(KERNEL_DS);
>  	pagefault_disable();
> -- 
> 2.26.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

