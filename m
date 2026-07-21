Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C505C4451C
	for <linux-um@archiver.kernel.org>; Tue, 21 Jul 2026 10:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FVSPNF8iPQvd7BJeZBryjfU6dS+i3clcKGkjmvJwcc4=; b=IYUn9gX/6vGTPUmVyIVEwnqL+s
	GttEwD8N0mUubWyMbPFd/8yLoTU5sbvL8HnzDzcDub72zoTktaWK1PTusHEiQHOy5HVrwdbJE1W+c
	57mn5uik+ZXzTTNnxcS1LFK9TXmay8fJY01pMBX5YaVStsgvoQqqcUKGWZh5SneshUW4o4WBXJwVE
	X4i7/Uq3rCcJrnAdtxPZMZV6ayJopM4pyh+nwXxfVXbA1ghXpbMSbXiqRMJTixFiIq+iMiFc558Lm
	lww4n2sSS+mHsKdEs/p2DXDxnS0B0GTUU1uj92z87YfsWNZStAQ/uR1qF7nIYjc70m+chu864hRj8
	GXA3ZymA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm7IQ-0000000932f-2JqF;
	Tue, 21 Jul 2026 10:01:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm7IO-0000000931v-12Rr
	for linux-um@bombadil.infradead.org;
	Tue, 21 Jul 2026 10:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FVSPNF8iPQvd7BJeZBryjfU6dS+i3clcKGkjmvJwcc4=; b=fhoV1i8TcpCv58bZipNICNjNdS
	niSyxXf08LxuDOlCAkbEdj0cRfish7YFTQXqS5xnsxoR8TDYy0/VRtzsh7BXoL55S/6OkruDY49JJ
	XPiuYansvISZNfEmD7dGGAJUk3Snz1y2XXBLgky0qZC5iSbT/66HcJ1D9Jvpu3PpPxvU5n95bCnlw
	67/nFIpUwTkQD/KOjHxLj2o9h6MdFFGRpqT59b59D3AaGvkUtJsmHHEdfLwK64q+SAPmAoHuRqYiE
	eqJbnCmO3LotzbOGnsiIyCYF4MDb15FYpD1cTfvWMOYpvQDBhqOPKFCvEZM0wxxyteXK72XsDKLKU
	jEq59dUw==;
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wm7IK-0000000HQ7w-1aph
	for linux-um@lists.infradead.org;
	Tue, 21 Jul 2026 10:01:50 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wm6xr-00375K-Gk; Tue, 21 Jul 2026 09:40:39 +0000
Received: from [192.168.21.56]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wm6tF-00000000c69-3pZr;
	Tue, 21 Jul 2026 10:40:38 +0100
Message-ID: <abb41c3f-1fb7-45dd-bd54-bbd340e45885@cambridgegreys.com>
Date: Tue, 21 Jul 2026 10:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] um: fix futex implementation
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260721084356.290579-2-johannes@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20260721084356.290579-2-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_110148_558931_69A66E5F 
X-CRM114-Status: GOOD (  23.37  )
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



On 21/07/2026 09:43, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The futex operations are both now wrong, neither have proper
> atomic semantics, which are needed for SMP. Even if we don't
> have SMP across threads of a process yet, multiple processes
> can use futexes to synchronize.
> 
> Also remove the documentation that's duplicated (and wrong,
> as this implementation never returns -EAGAIN).
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: fix oldval read
> ---
>   arch/um/kernel/skas/uaccess.c | 134 +++++++++++++---------------------
>   1 file changed, 51 insertions(+), 83 deletions(-)
> 
> diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
> index caef1deef795..f48f0e7c2497 100644
> --- a/arch/um/kernel/skas/uaccess.c
> +++ b/arch/um/kernel/skas/uaccess.c
> @@ -231,116 +231,90 @@ long strnlen_user(const char __user *str, long len)
>   }
>   EXPORT_SYMBOL(strnlen_user);
>   
> -/**
> - * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
> - *			  argument and comparison of the previous
> - *			  futex value with another constant.
> - *
> - * @op:		operation to execute
> - * @oparg:	argument to operation
> - * @oval:	old value at uaddr
> - * @uaddr:	pointer to user space address
> - *
> - * Return:
> - * 0 - On success
> - * -EFAULT - User access resulted in a page fault
> - * -EAGAIN - Atomic operation was unable to complete due to contention
> - * -ENOSYS - Operation not supported
> - */
> -
>   int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
>   {
> -	int oldval, ret;
> -	struct page *page;
>   	unsigned long addr = (unsigned long) uaddr;
> +	u32 *p, oldval, newval;
> +	struct page *page;
>   	pte_t *pte;
>   
> -	ret = -EFAULT;
>   	if (!access_ok(uaddr, sizeof(*uaddr)))
>   		return -EFAULT;
> +
> +	switch (op) {
> +	case FUTEX_OP_SET:
> +	case FUTEX_OP_ADD:
> +	case FUTEX_OP_OR:
> +	case FUTEX_OP_ANDN:
> +	case FUTEX_OP_XOR:
> +		break;
> +	default:
> +		return -ENOSYS;
> +	}
> +
>   	preempt_disable();
>   	pte = maybe_map(addr, 1);
> -	if (pte == NULL)
> -		goto out_inuser;
> +	if (pte == NULL) {
> +		preempt_enable();
> +		return -EFAULT;
> +	}
>   
>   	page = pte_page(*pte);
>   #ifdef CONFIG_64BIT
>   	pagefault_disable();
> -	addr = (unsigned long) page_address(page) +
> -			(((unsigned long) addr) & ~PAGE_MASK);
> +	p = page_address(page) + (addr & ~PAGE_MASK);
>   #else
> -	addr = (unsigned long) kmap_atomic(page) +
> -		((unsigned long) addr & ~PAGE_MASK);
> +	p = kmap_atomic(page) + (addr & ~PAGE_MASK);
>   #endif
> -	uaddr = (u32 *) addr;
> -	oldval = *uaddr;
>   
> -	ret = 0;
> +	do {
> +		oldval = READ_ONCE(*p);
> +
> +		switch (op) {
> +		case FUTEX_OP_SET:
> +			newval = oparg;
> +			break;
> +		case FUTEX_OP_ADD:
> +			newval = oldval + oparg;
> +			break;
> +		case FUTEX_OP_OR:
> +			newval = oldval | oparg;
> +			break;
> +		case FUTEX_OP_ANDN:
> +			newval = oldval & ~oparg;
> +			break;
> +		case FUTEX_OP_XOR:
> +			newval = oldval ^ oparg;
> +			break;
> +		}
> +	} while (!try_cmpxchg(p, &oldval, newval));
> +
> +	*oval = oldval;
>   
> -	switch (op) {
> -	case FUTEX_OP_SET:
> -		*uaddr = oparg;
> -		break;
> -	case FUTEX_OP_ADD:
> -		*uaddr += oparg;
> -		break;
> -	case FUTEX_OP_OR:
> -		*uaddr |= oparg;
> -		break;
> -	case FUTEX_OP_ANDN:
> -		*uaddr &= ~oparg;
> -		break;
> -	case FUTEX_OP_XOR:
> -		*uaddr ^= oparg;
> -		break;
> -	default:
> -		ret = -ENOSYS;
> -	}
>   #ifdef CONFIG_64BIT
>   	pagefault_enable();
>   #else
>   	kunmap_atomic((void *)addr);
>   #endif
> -
> -out_inuser:
>   	preempt_enable();
> -
> -	if (ret == 0)
> -		*oval = oldval;
> -
> -	return ret;
> +	return 0;
>   }
> -EXPORT_SYMBOL(arch_futex_atomic_op_inuser);
> -
> -/**
> - * futex_atomic_cmpxchg_inatomic() - Compare and exchange the content of the
> - *				uaddr with newval if the current value is
> - *				oldval.
> - * @uval:	pointer to store content of @uaddr
> - * @uaddr:	pointer to user space address
> - * @oldval:	old value
> - * @newval:	new value to store to @uaddr
> - *
> - * Return:
> - * 0 - On success
> - * -EFAULT - User access resulted in a page fault
> - * -EAGAIN - Atomic operation was unable to complete due to contention
> - */
>   
>   int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> -			      u32 oldval, u32 newval)
> +				  u32 oldval, u32 newval)
>   {
>   	struct page *page;
>   	pte_t *pte;
> -	int ret = -EFAULT;
>   
>   	if (!access_ok(uaddr, sizeof(*uaddr)))
>   		return -EFAULT;
>   
>   	preempt_disable();
>   	pte = maybe_map((unsigned long) uaddr, 1);
> -	if (pte == NULL)
> -		goto out_inatomic;
> +	if (pte == NULL) {
> +		preempt_enable();
> +		return -EFAULT;
> +	}
>   
>   	page = pte_page(*pte);
>   #ifdef CONFIG_64BIT
> @@ -350,19 +324,13 @@ int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>   	uaddr = kmap_atomic(page) + ((unsigned long) uaddr & ~PAGE_MASK);
>   #endif
>   
> -	*uval = *uaddr;
> -
> -	ret = cmpxchg(uaddr, oldval, newval);
> +	*uval = cmpxchg(uaddr, oldval, newval);
>   
>   #ifdef CONFIG_64BIT
>   	pagefault_enable();
>   #else
>   	kunmap_atomic(uaddr);
>   #endif
> -	ret = 0;
> -
> -out_inatomic:
>   	preempt_enable();
> -	return ret;
> +	return 0;
>   }
> -EXPORT_SYMBOL(futex_atomic_cmpxchg_inatomic);

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661



