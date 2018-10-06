Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g8tLa-0003Np-NI
 for linux-um@lists.infradead.org; Sat, 06 Oct 2018 20:38:48 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3] Optimise TLB flush for kernel mm in UML
Date: Sat, 06 Oct 2018 22:38:18 +0200
Message-ID: <1615399.BP76ARYnqk@blindfold>
In-Reply-To: <20181004172510.27410-1-anton.ivanov@cambridgegreys.com>
References: <20181004172510.27410-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org

Anton,

Am Donnerstag, 4. Oktober 2018, 19:25:10 CEST schrieb anton.ivanov@cambridgegreys.com:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> This patch introduces bulking up memory ranges to be passed to
> mmap/munmap/mprotect instead of doing everything one page at a time.
> 
> This is already being done for the userspace UML portion, this
> adds a simplified version of it for the kernel mm.
> 
> This results in speed up of up to 10%+ in some areas (sequential
> disk read measured with dd, etc).

Nice!
Do you have also data on how much less memory mappings get installed?

> Add further speed-up by removing a mandatory tlb force flush
> for swapless kernel.

It is also not entirely clear to me why swap is a problem here,
can you please elaborate?
 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  arch/um/kernel/tlb.c | 201 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 148 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index 37508b190106..f754d43105fc 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -15,9 +15,15 @@
>  #include <skas.h>
>  #include <kern_util.h>
>  
> +#ifdef CONFIG_SWAP
> +#define FORK_MM_FORCE 1
> +#else
> +#define FORK_MM_FORCE 0
> +#endif
> +

Hmm, can't we detect at runtime whether a swap device is enabled or not?
Depending on CONFIG_SWAP is a huge dependency.

>  struct host_vm_change {
>  	struct host_vm_op {
> -		enum { NONE, MMAP, MUNMAP, MPROTECT } type;
> +		enum { HOST_NONE, HOST_MMAP, HOST_MUNMAP, HOST_MPROTECT } type;
>  		union {
>  			struct {
>  				unsigned long addr;
> @@ -43,14 +49,34 @@ struct host_vm_change {
>  	int force;
>  };
>  
> +struct kernel_vm_change {

Maybe an union would fit better here?

> +	struct {
> +		unsigned long phys;
> +		unsigned long virt;
> +		unsigned long len;
> +		unsigned int active;
> +	} mmap;
> +	struct {
> +		unsigned long addr;
> +		unsigned long len;
> +		unsigned int active;
> +	} munmap;
> +	struct {
> +		unsigned long addr;
> +		unsigned long len;
> +		unsigned int active;
> +	} mprotect;
> +};
> +
>  #define INIT_HVC(mm, force) \
>  	((struct host_vm_change) \
> -	 { .ops		= { { .type = NONE } },	\
> +	 { .ops		= { { .type = HOST_NONE } },	\
>  	   .id		= &mm->context.id, \
>         	   .data	= NULL, \
>  	   .index	= 0, \
>  	   .force	= force })
>  
> +
>  static void report_enomem(void)
>  {
>  	printk(KERN_ERR "UML ran out of memory on the host side! "
> @@ -58,7 +84,7 @@ static void report_enomem(void)
>  			"vm.max_map_count has been reached.\n");
>  }
>  
> -static int do_ops(struct host_vm_change *hvc, int end,
> +static int do_host_ops(struct host_vm_change *hvc, int end,
>  		  int finished)
>  {
>  	struct host_vm_op *op;
> @@ -67,22 +93,22 @@ static int do_ops(struct host_vm_change *hvc, int end,
>  	for (i = 0; i < end && !ret; i++) {
>  		op = &hvc->ops[i];
>  		switch (op->type) {
> -		case MMAP:
> +		case HOST_MMAP:
>  			ret = map(hvc->id, op->u.mmap.addr, op->u.mmap.len,
>  				  op->u.mmap.prot, op->u.mmap.fd,
>  				  op->u.mmap.offset, finished, &hvc->data);
>  			break;
> -		case MUNMAP:
> +		case HOST_MUNMAP:
>  			ret = unmap(hvc->id, op->u.munmap.addr,
>  				    op->u.munmap.len, finished, &hvc->data);
>  			break;
> -		case MPROTECT:
> +		case HOST_MPROTECT:
>  			ret = protect(hvc->id, op->u.mprotect.addr,
>  				      op->u.mprotect.len, op->u.mprotect.prot,
>  				      finished, &hvc->data);
>  			break;
>  		default:
> -			printk(KERN_ERR "Unknown op type %d in do_ops\n",
> +			printk(KERN_ERR "Unknown op type %d in do_host_ops\n",
>  			       op->type);
>  			BUG();
>  			break;
> @@ -95,8 +121,32 @@ static int do_ops(struct host_vm_change *hvc, int end,
>  	return ret;
>  }
>  
> -static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
> -		    unsigned int prot, struct host_vm_change *hvc)
> +static void do_kern_ops(struct kernel_vm_change *kvc)
> +{
> +	int err = 0;
> +
> +	if (kvc->munmap.active) {
> +		err = os_unmap_memory((void *) kvc->munmap.addr,
> +			kvc->munmap.len);
> +		kvc->munmap.active = 0;
> +		if (err < 0)
> +			panic("munmap failed, errno = %d\n", -err);
> +	}
> +	if (kvc->mmap.active) {
> +		map_memory(kvc->mmap.virt,
> +			kvc->mmap.phys, kvc->mmap.len, 1, 1, 1);

mmap can fail, please check for the return code.

> +		kvc->mmap.active = 0;
> +	}
> +	if (kvc->mprotect.active) {
> +		os_protect_memory((void *) kvc->mprotect.addr,
> +			kvc->mprotect.len, 1, 1, 1);

Same.

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

