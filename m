Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A82FC4345F
	for <linux-um@archiver.kernel.org>; Mon, 15 Apr 2024 02:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rHGLU3hUN/k+Q4N4vZFwYW057AsuOMF6JOX5D/tfY1w=; b=Ix5oKEq28cKiUZDoMNWmGa1Kyv
	+JK6jSrkOMKWON8Q+srXCiC4cIydbmvnXBlQ1aVkDeBDiflqoj/Sr03FqujCvOzmrr9R2Fn+26RBa
	Au+fzlAL1g/dSpkfhvM+l4dcFgNnTFOIuZHjMP92rq3jefa103hs3FNj9WKGzopGoztArq5jpPy/6
	uwNUHQ0Opod23frrx6GBUm+O+s3vWVnDdvzXruthm7rlnWqRYRpJ87G4zubz3Yts615BeDsHZQ/2p
	yobpLCuRTqLb55bE6SpGEHmGEIWrK+Y+2hJ0LJWj3nGR4KVJjuv4GYNPdifzOwL0p10TGE13RDzco
	+yfr7Gpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwBvo-00000006lsX-1Dii;
	Mon, 15 Apr 2024 02:18:52 +0000
Received: from out0-206.mail.aliyun.com ([140.205.0.206])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwBvk-00000006lrf-1tmq
	for linux-um@lists.infradead.org;
	Mon, 15 Apr 2024 02:18:50 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XABLjhE_1713147512;
Received: from 30.230.91.4(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XABLjhE_1713147512)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 10:18:39 +0800
Message-ID: <54e7d96b-20b7-4f9b-af20-f602438b78fc@antgroup.com>
Date: Mon, 15 Apr 2024 10:18:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: tlb: Remove unused flush_tlb_mm_range function
To: Ivan Orlov <ivan.orlov0322@gmail.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240414211934.393303-1-ivan.orlov0322@gmail.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240414211934.393303-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240414_191848_670342_814F8003 
X-CRM114-Status: GOOD (  12.15  )
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

On 4/15/24 5:19 AM, Ivan Orlov wrote:
> GCC 11.4.0 produces the following warning when compiling the kernel for
> UML architecture (with UML defconfig):
> 
> arch/um/kernel/tlb.c:579:6: warning: no previous prototype for ‘flush_tlb_mm_range’ [-Wmissing-prototypes]
>   579 | void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,)
> 
> This function is not used anywhere. It is not exported with
> `EXPORT_SYMBOL` either, and therefore it is not usable for dynamically
> loaded modules. Remove this function.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  arch/um/kernel/tlb.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index 7d050ab0f78a..70b5e47e9761 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -576,12 +576,6 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  }
>  EXPORT_SYMBOL(flush_tlb_range);
>  
> -void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> -			unsigned long end)
> -{
> -	fix_range(mm, start, end, 0);
> -}
> -
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;

Thanks for the patch. I also posted a fix for this earlier (but not merged yet):

https://lore.kernel.org/linux-um/20240306101925.1088870-4-tiwei.btw@antgroup.com/

Regards,
Tiwei

