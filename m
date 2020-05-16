Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZnj9-00009X-7q
 for linux-um@lists.infradead.org; Sat, 16 May 2020 03:43:08 +0000
Date: Sat, 16 May 2020 12:42:59 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 14/18] maccess: allow architectures to provide kernel
 probing directly
Message-Id: <20200516124259.5b68a4e1d4670efa1397a1e0@kernel.org>
In-Reply-To: <20200513160038.2482415-15-hch@lst.de>
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-15-hch@lst.de>
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

On Wed, 13 May 2020 18:00:34 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Provide alternative versions of probe_kernel_read, probe_kernel_write
> and strncpy_from_kernel_unsafe that don't need set_fs magic, but instead
> use arch hooks that are modelled after unsafe_{get,put}_user to access
> kernel memory in an exception safe way.

This patch seems to introduce new implementation of probe_kernel_read/write()
and strncpy_from_kernel_unsafe(), but also drops copy_from/to_kernel_nofault()
and strncpy_from_kernel_nofault() if HAVE_ARCH_PROBE_KERNEL is defined.
In the result, this cause a link error with BPF and kprobe events.

BTW, what is the difference of *_unsafe() and *_nofault()?
(maybe we make those to *_nofault() finally?)

Thank you,

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/maccess.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/mm/maccess.c b/mm/maccess.c
> index 9773e2253b495..e9efe2f98e34a 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -12,6 +12,81 @@ bool __weak probe_kernel_read_allowed(void *dst, const void *unsafe_src,
>  	return true;
>  }
>  
> +#ifdef HAVE_ARCH_PROBE_KERNEL
> +
> +#define probe_kernel_read_loop(dst, src, len, type, err_label)		\
> +	while (len >= sizeof(type)) {					\
> +		arch_kernel_read(dst, src, type, err_label);		\
> +		dst += sizeof(type);					\
> +		src += sizeof(type);					\
> +		len -= sizeof(type);					\
> +	}
> +
> +long probe_kernel_read(void *dst, const void *src, size_t size)
> +{
> +	if (!probe_kernel_read_allowed(dst, src, size))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +	probe_kernel_read_loop(dst, src, size, u64, Efault);
> +	probe_kernel_read_loop(dst, src, size, u32, Efault);
> +	probe_kernel_read_loop(dst, src, size, u16, Efault);
> +	probe_kernel_read_loop(dst, src, size, u8, Efault);
> +	pagefault_enable();
> +	return 0;
> +Efault:
> +	pagefault_enable();
> +	return -EFAULT;
> +}
> +EXPORT_SYMBOL_GPL(probe_kernel_read);
> +
> +#define probe_kernel_write_loop(dst, src, len, type, err_label)		\
> +	while (len >= sizeof(type)) {					\
> +		arch_kernel_write(dst, src, type, err_label);		\
> +		dst += sizeof(type);					\
> +		src += sizeof(type);					\
> +		len -= sizeof(type);					\
> +	}
> +
> +long probe_kernel_write(void *dst, const void *src, size_t size)
> +{
> +	pagefault_disable();
> +	probe_kernel_write_loop(dst, src, size, u64, Efault);
> +	probe_kernel_write_loop(dst, src, size, u32, Efault);
> +	probe_kernel_write_loop(dst, src, size, u16, Efault);
> +	probe_kernel_write_loop(dst, src, size, u8, Efault);
> +	pagefault_enable();
> +	return 0;
> +Efault:
> +	pagefault_enable();
> +	return -EFAULT;
> +}
> +
> +long strncpy_from_kernel_unsafe(char *dst, const void *unsafe_addr, long count)
> +{
> +	const void *src = unsafe_addr;
> +
> +	if (unlikely(count <= 0))
> +		return 0;
> +	if (!probe_kernel_read_allowed(dst, unsafe_addr, count))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +	do {
> +		arch_kernel_read(dst, src, u8, Efault);
> +		dst++;
> +		src++;
> +	} while (dst[-1] && src - unsafe_addr < count);
> +	pagefault_enable();
> +
> +	dst[-1] = '\0';
> +	return src - unsafe_addr;
> +Efault:
> +	pagefault_enable();
> +	dst[-1] = '\0';
> +	return -EFAULT;
> +}
> +#else /* HAVE_ARCH_PROBE_KERNEL */
>  /**
>   * probe_kernel_read(): safely attempt to read from kernel-space
>   * @dst: pointer to the buffer that shall take the data
> @@ -114,6 +189,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
>  
>  	return ret ? -EFAULT : src - unsafe_addr;
>  }
> +#endif /* HAVE_ARCH_PROBE_KERNEL */
>  
>  /**
>   * probe_user_read(): safely attempt to read from a user-space location
> -- 
> 2.26.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

