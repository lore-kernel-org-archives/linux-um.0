Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2E0FF8877
	for <linux-um@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ubnPqyEuUH+bb9tWP9+TOUp+n6C5onOR58LCuBDEiw=; b=MapQoK4Zbh4sgmA8cI1jiXdwxg
	VbdHQumdZ8ZPg+ICcvhrl5g/W7R7+opMRSahxIZ04SZYJP7nCEvCPj0qry+cUEuBTJHFvOh2xQuo5
	DRXF3v0cPJk3ylqCXC8xHV6I8Tzhmy+idbCAFDfBfnLAMmtHJG7nOd+QtuTIUHkqMeLCia+bjYXWo
	ZjVESq7IqJQHtZQu+ddOAtjWOzGlfUIzx5hwhYwARmM8uSVGca5dpPaA4Imu6AjohzKqG8kkFRyJv
	bcUbKR8Hdjzm5oj+yWp32UuKxKFLZSTt3KvnTlpjEGRap+Vy8LIw4ZpVBAZqQTyIkeP8PpqnQpWBu
	Ax2eDEAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI27J-00000003S3M-0JnN;
	Wed, 29 Apr 2026 10:26:05 +0000
Received: from out-181.mta1.migadu.com ([95.215.58.181])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI27G-00000003Rym-2wUB
	for linux-um@lists.infradead.org;
	Wed, 29 Apr 2026 10:26:03 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777458333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ubnPqyEuUH+bb9tWP9+TOUp+n6C5onOR58LCuBDEiw=;
	b=syDuJ2ebh9z2sjffREH58o0aT6Ajjew8W5I8ReEUtvp2EQkdghmYv8iT9JcU1iX87oMIbX
	D+xmbMoFNHgWVKDoL6XEe6kPFjJgAeA5FQrv1tK/6uUbSyjmFqItMdxDS/n3eJA5ihtrWC
	pDy1LXDxeyfrSgRVjezaD0bM6Fa+Scc=
From: Usama Arif <usama.arif@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-x25@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
Date: Wed, 29 Apr 2026 03:25:19 -0700
Message-ID: <20260429102520.1617327-1-usama.arif@linux.dev>
In-Reply-To: <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_032602_880378_19E48645 
X-CRM114-Status: GOOD (  14.16  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, 27 Apr 2026 19:13:48 +0200 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> At the time being, x86 and arm64 are missing unsafe_copy_from_user().
> 
> Add it.
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  arch/x86/include/asm/uaccess.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 3a0dd3c2b233..10c458ffa399 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -598,7 +598,7 @@ _label:									\
>   * We want the unsafe accessors to always be inlined and use
>   * the error labels - thus the macro games.
>   */
> -#define unsafe_copy_loop(dst, src, len, type, label)				\
> +#define unsafe_put_loop(dst, src, len, type, label)				\
>  	while (len >= sizeof(type)) {						\
>  		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
>  		dst += sizeof(type);						\
> @@ -611,10 +611,29 @@ do {									\
>  	char __user *__ucu_dst = (_dst);				\
>  	const char *__ucu_src = (_src);					\
>  	size_t __ucu_len = (_len);					\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +} while (0)
> +
> +#define unsafe_get_loop(dst, src, len, type, label)				\
> +	while (len >= sizeof(type)) {						\
> +		unsafe_get_user(*(type __user *)(src),(type *)(dst),label);	\

Hi,

Just wanted to check if src and dst need to be swapped? Same for arm64 patch.

> +		dst += sizeof(type);						\
> +		src += sizeof(type);						\
> +		len -= sizeof(type);						\
> +	}
> +
> +#define unsafe_copy_from_user(_dst,_src,_len,label)			\
> +do {									\
> +	char *__ucu_dst = (_dst);					\
> +	const char __user *__ucu_src = (_src);				\
> +	size_t __ucu_len = (_len);					\
> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>  } while (0)
>  
>  #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> -- 
> 2.49.0
> 
> 

