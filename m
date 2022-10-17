Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3D6C4332F
	for <linux-um@archiver.kernel.org>; Mon, 17 Oct 2022 11:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VDpjARKeKmoPeSO4QyqOXpMI1/wwpkuM5pZPxN+iuZE=; b=wbUEiWz5ZwK5kd
	2rD/D0shDoK2qUpQdNbZujQmPZxOiFQEZttp5iP/up5AjmzgjQgOmPGDG2hb//M+6m43vyOz/Qo0F
	aq520QkhF7A75msCVViS58o1HXf4AhkXZKmSwklVR5qpVwtW54pWGyWK5iSH0vFu303AUW4ks/dDe
	esyHVGcG0fkpseevrX5JeE80IAbb97n0bKHnYadUbwEfgTWJ06TKEVDm3OB1LHF1U/vNSXvCNlKVt
	E5qnTAMPxuxXx/YXapUd1AFwxXKGu3IKvFnPWALHnkzq8TIC8YnHcn1H2u9R1mRhF93hUgMlE9UAp
	66qFbdATBZKvzPed9oBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okOew-00BBns-VJ; Mon, 17 Oct 2022 11:51:54 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okOeu-00BBcx-0Z
	for linux-um@lists.infradead.org; Mon, 17 Oct 2022 11:51:53 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1okOen-001pkk-6e; Mon, 17 Oct 2022 11:51:45 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1okOej-00EdTV-P6; Mon, 17 Oct 2022 12:51:44 +0100
Message-ID: <5c0ae9de-a569-814c-8dc5-a54f352e089d@cambridgegreys.com>
Date: Mon, 17 Oct 2022 12:51:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] um: protect VMA iteration
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Matthew Wilcox <willy@infradead.org>,
 Johannes Berg <johannes.berg@intel.com>
References: <20221017110630.c6c786d46e74.I7b85b7dd326d2d078dabdd4ae40c35dc4ee1f3bc@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20221017110630.c6c786d46e74.I7b85b7dd326d2d078dabdd4ae40c35dc4ee1f3bc@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_045152_086905_0E676133 
X-CRM114-Status: GOOD (  17.03  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 17/10/2022 10:06, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Looks like this is needed now, otherwise we get RCU
> splats from lockdep. But I don't know anything about
> this code ...

I went through it several times a couple of years ago looking if there is a way to optimize some of the flushes.

A lock there will not hurt. I do not think that it would do anything as that bit should be single-threaded (and most invocations are under locks too), but it will not hurt.

So if it is needed to make lockdep shut up - let it be.

> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/tlb.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index ad449173a1a1..3cc6b753e579 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -587,8 +587,10 @@ void flush_tlb_mm(struct mm_struct *mm)
>   	struct vm_area_struct *vma;
>   	VMA_ITERATOR(vmi, mm, 0);
>   
> +	rcu_read_lock();
>   	for_each_vma(vmi, vma)
>   		fix_range(mm, vma->vm_start, vma->vm_end, 0);
> +	rcu_read_unlock();
>   }
>   
>   void force_flush_all(void)
> @@ -597,6 +599,8 @@ void force_flush_all(void)
>   	struct vm_area_struct *vma;
>   	VMA_ITERATOR(vmi, mm, 0);
>   
> +	rcu_read_lock();
>   	for_each_vma(vmi, vma)
>   		fix_range(mm, vma->vm_start, vma->vm_end, 1);
> +	rcu_read_unlock();
>   }

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
