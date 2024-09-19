Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ECFCE8D7D
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jojr3OO3CAclkbpbwb2al+a2krhVyV17WEh2UPwz4bQ=; b=IIbtXN6zzLIv8LgMoc23bBYr6W
	6UzLXz9Tg7+pxvbGSpWQfcDRvFWbv7IdK4XcVGXzGtEgcr5CSqyhe5A6GRuxgZLLs4C/1tWU+ovgw
	HhqWwLqX8VspCbjLlfB2hBq2gKG71B6iOHTC5Q3KZITnjxI9YsRyOxcbAArv9CyHkdiTIDGm2uNiR
	7N3fvx8lQamp4owBLl7aZEA/isQNwK4K8ssmIxm6DaqsA8wPtHGVvtSXODnj0XKyPFKdEyD9z2wOl
	cuhqGQ4biAnfsi63+oO8/uHHJnV6e/reD/Nw/iHG1Us4J3MbtN+92bywsi/wKwK8po/X49fGNNDvp
	aYib5nhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srG7j-0000000ADjy-3Bhp;
	Thu, 19 Sep 2024 12:19:03 +0000
Received: from out0-216.mail.aliyun.com ([140.205.0.216])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srG7g-0000000ADjT-28Mx
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:19:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726748338; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Jojr3OO3CAclkbpbwb2al+a2krhVyV17WEh2UPwz4bQ=;
	b=VhuG5beH1cqo5llcaNczIdEd+kNjua1eUtGAeKH2QyQqURDPrR0WBdwj3d4ls/nvT8ZXFbje+71L7V8EGE7Kge/8k/YZ7/AGUmPnoCmDNrVhEnM1U35y12ei4tTdtijPrazysGNfDoTbNxdxop13opjrtX3OzQnG7bvWRQLfI70=
Received: from 30.212.181.184(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZNXM9Mj_1726748335)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 20:18:56 +0800
Message-ID: <232569c5-be1f-41f7-890b-98a625573b14@antgroup.com>
Date: Thu, 19 Sep 2024 20:18:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] um: use execveat to create userspace MMs
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240704190506.1438493-1-benjamin@sipsolutions.net>
 <20240704190506.1438493-3-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240704190506.1438493-3-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_051900_913006_820335AC 
X-CRM114-Status: UNSURE (   9.08  )
X-CRM114-Notice: Please train this message.
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

On 2024/7/5 03:05, Benjamin Berg wrote:
[...]
>  static int userspace_tramp(void *stack)
>  {
> -	struct sigaction sa;
> -	void *addr;
> -	int fd;
> +	char *const argv[] = { "uml-userspace", NULL };
> +	int pipe_fds[2];
>  	unsigned long long offset;
> -	unsigned long segv_handler = STUB_CODE +
> -				     (unsigned long) stub_segv_handler -
> -				     (unsigned long) __syscall_stub_start;
> -
> -	ptrace(PTRACE_TRACEME, 0, 0, 0);
> -
> -	signal(SIGTERM, SIG_DFL);
> -	signal(SIGWINCH, SIG_IGN);
> -
> -	fd = phys_mapping(uml_to_phys(__syscall_stub_start), &offset);
> -	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
> -		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
> -	if (addr == MAP_FAILED) {
> -		os_info("mapping mmap stub at 0x%lx failed, errno = %d\n",
> -			STUB_CODE, errno);
> -		exit(1);
> +	struct stub_init_data init_data = {
> +		.stub_start = STUB_START,
> +		.segv_handler = STUB_CODE +
> +				(unsigned long) stub_segv_handler -
> +				(unsigned long) __syscall_stub_start,
> +	};
> +	struct iomem_region *iomem;
> +	int ret;
> +
> +	init_data.stub_code_fd = phys_mapping(uml_to_phys(__syscall_stub_start),
> +					      &offset);
> +	init_data.stub_code_offset = MMAP_OFFSET(offset);
> +
> +	init_data.stub_data_fd = phys_mapping(uml_to_phys(stack), &offset);
> +	init_data.stub_data_offset = MMAP_OFFSET(offset);
> +
> +	/* Set CLOEXEC on all FDs and then unset on all memory related FDs */
> +	close_range(0, ~0U, CLOSE_RANGE_CLOEXEC);

I got a link error on Ubuntu 22.04.4 (glibc-2.35) when STATIC_LINK is enabled:

/usr/bin/ld:
/usr/lib/gcc/x86_64-linux-gnu/11/../../../x86_64-linux-gnu/libc.a(close_range.o):
in function `__close_range':
(.text+0x0): multiple definition of `__close_range';
fs/file.o:/home/test/linux/fs/file.c:741: first defined here

We probably need something like this:

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 00b63bac5eff..31e367e8ab4d 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -61,7 +61,8 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
 	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
 	-Din6addr_loopback=kernel_in6addr_loopback \
-	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
+	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr \
+	-D__close_range=kernel__close_range

 KBUILD_RUSTFLAGS += -Crelocation-model=pie

Regards,
Tiwei

