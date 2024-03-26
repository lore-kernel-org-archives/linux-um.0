Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E8C54E67
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=81fQKwEJA+hlzgOLJEAJ85+s1sN4nH0Cn4/OgM1cHNo=; b=1VdryNTtyFkkE6bPSp7ovkJL2k
	FgSQ25uHfAQfOHLAYCL31MrhQz7xfJX9MDIIB2AoYArIsi8r6WMvRYmWBlQJRMP2iU8nlWxyT00nc
	C5rpJsJlJ5RfCWYF5hRo0W2CUphq/TGrMYpzndQVXwPmC6kcQBNH2WMbGiQDKNr7CSm+doBOwXsxs
	Ef33GpOwi6KFWkMd41K7wfLgDf0ViOESrZN24xwmdUwC4Bn8A45ztA/E0snaMVSrZzFF+5nPTzvz7
	TTAzosR/2dNyHw3/eR+VtANW5u9PGeewLPH9B/PqvcZXC6NiwTosnOumzzz8HqlkQr1eVg+OfpP2g
	FvSTP88Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8sF-00000005EKV-3A9R;
	Tue, 26 Mar 2024 15:38:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8rh-00000005Dpi-3Igf
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 15:37:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 36E94CE1F8A;
	Tue, 26 Mar 2024 15:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9198AC43394;
	Tue, 26 Mar 2024 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467446;
	bh=Bl+BYidMPD6QYSFEUn9nKPp7BsOGv1w8t/Y35xkpOsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kc4USQE7pWStzRH38MPjUVOniBdEq5uyWMoUbz0gTjBmUbZKyomc3+N1bbVG9vdyk
	 fESewTVbd3oBlMBpODGuKsQ7U0RrznUbpvGESpnHLrYY95vSEWQgt7tVJvhjBJ5E9g
	 3U26IABZk/FvcbeOquNy1outnQxgYWJuJWEBjmsSiX5gN1vhK5A0AJdM+uF62HcZkt
	 JM7Tmgbuh6+MlC7ySVap9O8c3uC1wgzwI2PHxvXCVL2g4cWD4KJDkHSxqCr0Hcrt2+
	 5gjlARL8ooO+2pygBvdaL3daFfodtBbnJhsxwceWyyF1QkNhpCg/CRUxGVwPWvAfgK
	 I+vFRiBXWES0g==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	sfr@canb.auug.org.au,
	kent.overstreet@linux.dev,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-mm@kvack.org,
	linux-um@lists.infradead.org,
	linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
Date: Tue, 26 Mar 2024 08:37:24 -0700
Message-Id: <20240326153724.89126-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326073750.726636-1-surenb@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_083730_420958_C77C6393 
X-CRM114-Status: GOOD (  17.42  )
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

On Tue, 26 Mar 2024 00:37:50 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Patch [1] replaced vmalloc() function with a new definition but it did
> not adjust the forward declaration used in UML architecture. Change it
> to act as before.
> Note that this prevents the vmalloc() allocations in __wrap_malloc()
> from being accounted. If accounting here is critical, we will have
> to remove this forward declaration and include vmalloc.h, however
> that would pull in more dependencies and would require introducing more
> architecture-specific headers, like asm/bug.h, asm/rwonce.h, etc.
> This is likely the reason why this forward declaration was introduced
> in the first place.
> 
> [1] https://lore.kernel.org/all/20240321163705.3067592-31-surenb@google.com/
> 
> Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")
> Reported-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Thank you for this fix, Suren.  I confirmed that this patch fixes the issue I
reported.

Closes: https://lore.kernel.org/all/20240323180506.195396-1-sj@kernel.org/
Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  arch/um/include/shared/um_malloc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/include/shared/um_malloc.h b/arch/um/include/shared/um_malloc.h
> index 13da93284c2c..bf503658f08e 100644
> --- a/arch/um/include/shared/um_malloc.h
> +++ b/arch/um/include/shared/um_malloc.h
> @@ -11,7 +11,8 @@
>  extern void *uml_kmalloc(int size, int flags);
>  extern void kfree(const void *ptr);
>  
> -extern void *vmalloc(unsigned long size);
> +extern void *vmalloc_noprof(unsigned long size);
> +#define vmalloc(...)		vmalloc_noprof(__VA_ARGS__)
>  extern void vfree(void *ptr);
>  
>  #endif /* __UM_MALLOC_H__ */
> -- 
> 2.44.0.396.g6e790dbe36-goog

