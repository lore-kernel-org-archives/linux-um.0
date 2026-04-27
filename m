Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133ADFF886D
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=; b=kqnShr2fTaNdxjtO67RZNBepLv
	jcZL1dKG6zLoiCXDQKbyMI6mgvRpc2p6BbNIjLbZulS8zACZQHP9KVZniCYCEdn9SScc8LqPhHH/K
	u/BnyMUwXsf+JK2ssD2wFNqDf2MD6DDiT2ZZevMU6gzQVf95E8dZIT7RHMGg0uWqQ6baWdlU2JyEX
	IrTAZfTkTulARlc2bsvTPdFYHFREPuEmkwLI/QMBM+uRAQbAkS3k1D/eyr5FT0YLdu7g/NbhYVp6l
	DM7DtXNh+SEs8xeqp9gLb32VlhgfIRKb9QU+hNsAKIAj9iAGONcQVaD4rOLDpmQBw5q6r6fUjZ2pj
	WqiK6MWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHQMo-0000000HXr8-0qmV;
	Mon, 27 Apr 2026 18:07:34 +0000
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHQMm-0000000HXpk-17lL
	for linux-um@lists.infradead.org;
	Mon, 27 Apr 2026 18:07:33 +0000
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so6958384f8f.0
        for <linux-um@lists.infradead.org>; Mon, 27 Apr 2026 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777313250; x=1777918050; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
        b=llEKoovWctMT8lQo9hFF/5PKGBo1SnTmEBaxM00QR2Jtg6d6gp9DWsipyKwP+1U3gF
         sXgZJ3dhvfVpagCRYfN6kwVUHpinPZxzJIXomT1mwqWX+T6ASdc0Y/PEz7GtEJ7o+W+X
         9Dld4dOYq4CyLoHA23pMwGdmtuLNCDkqH+pKDY7VhnMUKU7gChr7UPUzLLzZb8o9fMVk
         G7CQ/iwKg7XMJ+MUZJeN8zwV5cY5qAMASHgj6c6mlIjeWRSjAT8ERzep1xU7VfPU7Z0S
         eQ9QRb+zleevxSH7Q6x4wGQKUTryZGjoFgD5t7u82hoHN38VAIyyZPn4r9BqEeGqNqwO
         lkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777313250; x=1777918050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
        b=JCAiDvDp+b9rv7DsF829iqBB9bfm7cnCQb+/vzppWZx1S4mV9xQgz9soN0hrNIL3Nd
         p6gH5CczblBOkggJ3dna4jDdGIUUL2Ht6Mcw95S6Ld52mtOr0p+0VxjJlx2RYHjcWZwy
         KYxxdelkgPNWsVCc6D/2Ey9GpMSOZ6zhbR7JSRPakCdubEdI2ohf1v6gm2AJ3BsB9iWs
         L3GqkS2otKTw8qTqys0b/fVqc5shyUnOK5JyslNwMneZ5A891IoWnHZmeoJBjPJRo/68
         nessW/EK3zonYLDv/3wOw96nJjagtDBQvI0EJyqKM0uwO4IBMd0zbCvqSXVQFt3hv8ju
         Llfw==
X-Forwarded-Encrypted: i=1; AFNElJ/3P4ZANzsy0Fe3yDONJBNNoitSdv8jT6+AQzR0lWqYxHlT8trs8VffmxPisUNbpSGKY7vtcI39oA==@lists.infradead.org
X-Gm-Message-State: AOJu0YywTUBKj2VxUb6maYh1darcbrXWbnSRdKl69k1EVISyZ7OeU8j9
	ezgMMQxu+co0ayms+z7uL0coUM7MbICzVpjayRD5knIxShe2gdW4mNGpPKLMAhdtn9aZFzkJJLh
	c2HHMg1+PHUu6PwkvIA==
X-Received: from wrmd3.prod.google.com ([2002:adf:e883:0:b0:43d:7940:a11b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c7:b0:43d:799c:b2cb with SMTP id ffacd0b85a97d-44636a393e7mr256856f8f.24.1777313249648;
 Mon, 27 Apr 2026 11:07:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:07:28 +0000
In-Reply-To: <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Mime-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Message-ID: <ae-l4FGDPLwBuDXM@google.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
From: Alice Ryhl <aliceryhl@google.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_110732_323858_C3DCC2D3 
X-CRM114-Status: GOOD (  10.17  )
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

On Mon, Apr 27, 2026 at 07:13:46PM +0200, Christophe Leroy (CS GROUP) wrote:
> diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
> index 01de4fbbcc84..710e07cd60ae 100644
> --- a/rust/helpers/uaccess.c
> +++ b/rust/helpers/uaccess.c
> @@ -5,13 +5,13 @@
>  __rust_helper unsigned long
>  rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -	return copy_from_user(to, from, n);
> +	return copy_from_user_partial(to, from, n);
>  }
>  
>  __rust_helper unsigned long
>  rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -	return copy_to_user(to, from, n);
> +	return copy_to_user_partial(to, from, n);
>  }

No Rust code uses the return value for anything other than comparing it
with zero, so you can keep these as copy_[from|to]_user() without
issues.

Thanks, Alice

