Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 7 Oct 2022 14:17:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v4 2/6] treewide: use prandom_u32_max() when possible
Message-ID: <Y0CXYjV8qMpJxxBa@magnolia>
References: <20221007180107.216067-1-Jason@zx2c4.com>
 <20221007180107.216067-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221007180107.216067-3-Jason@zx2c4.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, Andreas Noever <andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Jan Kara <jack@suse.cz>

On Fri, Oct 07, 2022 at 12:01:03PM -0600, Jason A. Donenfeld wrote:
> Rather than incurring a division or requesting too many random bytes for
> the given range, use the prandom_u32_max() function, which only takes
> the minimum required bytes from the RNG and avoids divisions.
> =

> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: KP Singh <kpsingh@kernel.org>
> Reviewed-by: Christoph B=F6hmwalder <christoph.boehmwalder@linbit.com> # =
for drbd
> Reviewed-by: Jan Kara <jack@suse.cz> # for ext2, ext4, and sbitmap
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---

<snip, skip to the xfs part>

> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index e2bdf089c0a3..6261599bb389 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -1520,7 +1520,7 @@ xfs_alloc_ag_vextent_lastblock(
>  =

>  #ifdef DEBUG
>  	/* Randomly don't execute the first algorithm. */
> -	if (prandom_u32() & 1)
> +	if (prandom_u32_max(2))

I wonder if these usecases (picking 0 or 1 randomly) ought to have a
trivial wrapper to make it more obvious that we want boolean semantics:

static inline bool prandom_bool(void)
{
	return prandom_u32_max(2);
}

	if (prandom_bool())
		use_crazy_algorithm(...);

But this translation change looks correct to me, so for the XFS parts:
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D


>  		return 0;
>  #endif
>  =

> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index 6cdfd64bc56b..7838b31126e2 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -636,7 +636,7 @@ xfs_ialloc_ag_alloc(
>  	/* randomly do sparse inode allocations */
>  	if (xfs_has_sparseinodes(tp->t_mountp) &&
>  	    igeo->ialloc_min_blks < igeo->ialloc_blks)
> -		do_sparse =3D prandom_u32() & 1;
> +		do_sparse =3D prandom_u32_max(2);
>  #endif
>  =

>  	/*
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 4b71a96190a8..66ee9b4b7925 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -509,7 +509,7 @@ static inline int node_random(const nodemask_t *maskp)
>  	w =3D nodes_weight(*maskp);
>  	if (w)
>  		bit =3D bitmap_ord_to_pos(maskp->bits,
> -			get_random_int() % w, MAX_NUMNODES);
> +			prandom_u32_max(w), MAX_NUMNODES);
>  	return bit;
>  #else
>  	return 0;
> diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
> index e6a31c927b06..a72a2c16066e 100644
> --- a/lib/cmdline_kunit.c
> +++ b/lib/cmdline_kunit.c
> @@ -76,7 +76,7 @@ static void cmdline_test_lead_int(struct kunit *test)
>  		int rc =3D cmdline_test_values[i];
>  		int offset;
>  =

> -		sprintf(in, "%u%s", prandom_u32_max(256), str);
> +		sprintf(in, "%u%s", get_random_int() % 256, str);
>  		/* Only first '-' after the number will advance the pointer */
>  		offset =3D strlen(in) - strlen(str) + !!(rc =3D=3D 2);
>  		cmdline_do_one_test(test, in, rc, offset);
> @@ -94,7 +94,7 @@ static void cmdline_test_tail_int(struct kunit *test)
>  		int rc =3D strcmp(str, "") ? (strcmp(str, "-") ? 0 : 1) : 1;
>  		int offset;
>  =

> -		sprintf(in, "%s%u", str, prandom_u32_max(256));
> +		sprintf(in, "%s%u", str, get_random_int() % 256);
>  		/*
>  		 * Only first and leading '-' not followed by integer
>  		 * will advance the pointer.
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 5f0e71ab292c..a0b2dbfcfa23 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -694,7 +694,7 @@ static void kobject_release(struct kref *kref)
>  {
>  	struct kobject *kobj =3D container_of(kref, struct kobject, kref);
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> -	unsigned long delay =3D HZ + HZ * (get_random_int() & 0x3);
> +	unsigned long delay =3D HZ + HZ * prandom_u32_max(4);
>  	pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
>  		 kobject_name(kobj), kobj, __func__, kobj->parent, delay);
>  	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
> index 6faf9c9a6215..4d241bdc88aa 100644
> --- a/lib/reed_solomon/test_rslib.c
> +++ b/lib/reed_solomon/test_rslib.c
> @@ -199,7 +199,7 @@ static int get_rcw_we(struct rs_control *rs, struct w=
space *ws,
>  =

>  		derrlocs[i] =3D errloc;
>  =

> -		if (ewsc && (prandom_u32() & 1)) {
> +		if (ewsc && prandom_u32_max(2)) {
>  			/* Erasure with the symbol intact */
>  			errlocs[errloc] =3D 2;
>  		} else {
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index c4f04edf3ee9..ef0661504561 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -21,7 +21,7 @@ static int init_alloc_hint(struct sbitmap *sb, gfp_t fl=
ags)
>  		int i;
>  =

>  		for_each_possible_cpu(i)
> -			*per_cpu_ptr(sb->alloc_hint, i) =3D prandom_u32() % depth;
> +			*per_cpu_ptr(sb->alloc_hint, i) =3D prandom_u32_max(depth);
>  	}
>  	return 0;
>  }
> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
> index 0927f44cd478..41a0321f641a 100644
> --- a/lib/test_hexdump.c
> +++ b/lib/test_hexdump.c
> @@ -208,7 +208,7 @@ static void __init test_hexdump_overflow(size_t bufle=
n, size_t len,
>  static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
>  {
>  	unsigned int i =3D 0;
> -	int rs =3D (prandom_u32_max(2) + 1) * 16;
> +	int rs =3D prandom_u32_max(2) + 1 * 16;
>  =

>  	do {
>  		int gs =3D 1 << i;
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index 4f2f2d1bac56..56ffaa8dd3f6 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -151,9 +151,7 @@ static int random_size_alloc_test(void)
>  	int i;
>  =

>  	for (i =3D 0; i < test_loop_count; i++) {
> -		n =3D prandom_u32();
> -		n =3D (n % 100) + 1;
> -
> +		n =3D prandom_u32_max(n % 100) + 1;
>  		p =3D vmalloc(n * PAGE_SIZE);
>  =

>  		if (!p)
> @@ -293,16 +291,12 @@ pcpu_alloc_test(void)
>  		return -1;
>  =

>  	for (i =3D 0; i < 35000; i++) {
> -		unsigned int r;
> -
> -		r =3D prandom_u32();
> -		size =3D (r % (PAGE_SIZE / 4)) + 1;
> +		size =3D prandom_u32_max(PAGE_SIZE / 4) + 1;
>  =

>  		/*
>  		 * Maximum PAGE_SIZE
>  		 */
> -		r =3D prandom_u32();
> -		align =3D 1 << ((r % 11) + 1);
> +		align =3D 1 << (prandom_u32_max(11) + 1);
>  =

>  		pcpu[i] =3D __alloc_percpu(size, align);
>  		if (!pcpu[i])
> @@ -393,14 +387,11 @@ static struct test_driver {
>  =

>  static void shuffle_array(int *arr, int n)
>  {
> -	unsigned int rnd;
>  	int i, j;
>  =

>  	for (i =3D n - 1; i > 0; i--)  {
> -		rnd =3D prandom_u32();
> -
>  		/* Cut the range. */
> -		j =3D rnd % i;
> +		j =3D prandom_u32_max(i);
>  =

>  		/* Swap indexes. */
>  		swap(arr[i], arr[j]);
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index a13ee452429e..5ca4f953034c 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -2469,11 +2469,11 @@ static void mod_cur_headers(struct pktgen_dev *pk=
t_dev)
>  	}
>  =

>  	if ((pkt_dev->flags & F_VID_RND) && (pkt_dev->vlan_id !=3D 0xffff)) {
> -		pkt_dev->vlan_id =3D prandom_u32() & (4096 - 1);
> +		pkt_dev->vlan_id =3D prandom_u32_max(4096);
>  	}
>  =

>  	if ((pkt_dev->flags & F_SVID_RND) && (pkt_dev->svlan_id !=3D 0xffff)) {
> -		pkt_dev->svlan_id =3D prandom_u32() & (4096 - 1);
> +		pkt_dev->svlan_id =3D prandom_u32_max(4096);
>  	}
>  =

>  	if (pkt_dev->udp_src_min < pkt_dev->udp_src_max) {
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index b9d995b5ce24..9dc070f2018e 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -794,7 +794,7 @@ int __inet_hash_connect(struct inet_timewait_death_ro=
w *death_row,
>  	 * on low contention the randomness is maximal and on high contention
>  	 * it may be inexistent.
>  	 */
> -	i =3D max_t(int, i, (prandom_u32() & 7) * 2);
> +	i =3D max_t(int, i, prandom_u32_max(8) * 2);
>  	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + =
2);
>  =

>  	/* Head lock still held and bh's disabled */
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index c3c693b51c94..f075a9fb5ccc 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -677,7 +677,7 @@ static void cache_limit_defers(void)
>  =

>  	/* Consider removing either the first or the last */
>  	if (cache_defer_cnt > DFR_MAX) {
> -		if (prandom_u32() & 1)
> +		if (prandom_u32_max(2))
>  			discard =3D list_entry(cache_defer_list.next,
>  					     struct cache_deferred_req, recent);
>  		else
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index e976007f4fd0..c2caee703d2c 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -1619,7 +1619,7 @@ static int xs_get_random_port(void)
>  	if (max < min)
>  		return -EADDRINUSE;
>  	range =3D max - min + 1;
> -	rand =3D (unsigned short) prandom_u32() % range;
> +	rand =3D (unsigned short) prandom_u32_max(range);
>  	return rand + min;
>  }
>  =

> -- =

> 2.37.3
> =


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

