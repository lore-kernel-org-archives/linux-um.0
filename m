Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ2RA-0008Ky-Ez
 for linux-um@lists.infradead.org; Thu, 14 May 2020 01:13:25 +0000
Date: Thu, 14 May 2020 10:13:18 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 10/18] maccess: unify the probe kernel arch hooks
Message-Id: <20200514101318.1c14647e41b7038b99b91fcd@kernel.org>
In-Reply-To: <20200513160038.2482415-11-hch@lst.de>
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-11-hch@lst.de>
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

Hi Christoph,

On Wed, 13 May 2020 18:00:30 +0200
Christoph Hellwig <hch@lst.de> wrote:

> @@ -36,14 +50,20 @@ long __weak probe_kernel_read(void *dst, const void *src, size_t size)
>   * probe_kernel_read() suitable for use within regions where the caller
>   * already holds mmap_sem, or other locks which nest inside mmap_sem.
>   */
> -long __weak probe_kernel_read_strict(void *dst, const void *src, size_t size)
> -    __attribute__((alias("__probe_kernel_read")));
> +long probe_kernel_read_strict(void *dst, const void *src, size_t size)
> +{
> +	return __probe_kernel_read(dst, src, size, true);
> +}
>  
> -long __probe_kernel_read(void *dst, const void *src, size_t size)
> +static long __probe_kernel_read(void *dst, const void *src, size_t size,
> +		bool strict)
>  {
>  	long ret;
>  	mm_segment_t old_fs = get_fs();
>  
> +	if (!probe_kernel_read_allowed(dst, src, size, strict))
> +		return -EFAULT;

Could you make this return -ERANGE instead of -EFAULT so that
the caller can notice that the address might be user space?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

