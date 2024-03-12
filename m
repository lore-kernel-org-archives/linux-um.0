Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678F4C54E58
	for <linux-um@archiver.kernel.org>; Tue, 12 Mar 2024 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OoK/XK2/J9dxETVPu2u7VN1315OHGZsWZA9KpKsKYRA=; b=sQ+tqkB4pFETeaApXTHXG7MEU4
	T5/Yw+/IKqvgTX9cuzSgj0G0B7EUwx6LMn03DJTc/SjS+jp7kp4vJCRFoWiKmnbR2Vu+1B4X8HKdX
	FhS9wd2vAnCNAMknEwlGfMRqGVmumYbcUYe4rZ3vWl3fEg5Go6wNgMPt2arjHjF13EjCd057d26tf
	4fXhRwEEX7bifEsWyY5lq7SykQgBJFaKr3CBCZNhFgLeGo8HDzc35PA6dnSddFMyXQHBtlSYZNVbS
	Eujqk6DdSjArIs773CakWYH/ORn9fa8BNRtabpDheqKJqHHq8tGCS3tqh768RC0gxN5RXlvaOHSpQ
	cSNqnb6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3jp-00000006ILo-3AAl;
	Tue, 12 Mar 2024 15:08:21 +0000
Received: from frasgout12.his.huawei.com ([14.137.139.154])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3jk-00000006IHb-2J8l
	for linux-um@lists.infradead.org;
	Tue, 12 Mar 2024 15:08:18 +0000
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TvGj117p9z9xFZm
	for <linux-um@lists.infradead.org>; Tue, 12 Mar 2024 22:48:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2D0A814040D
	for <linux-um@lists.infradead.org>; Tue, 12 Mar 2024 23:07:54 +0800 (CST)
Received: from [10.48.131.93] (unknown [10.48.131.93])
	by APP2 (Coremail) with SMTP id GxC2BwAXUCTDb_BlMeMqBA--.36492S2;
	Tue, 12 Mar 2024 16:07:53 +0100 (CET)
Message-ID: <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
Date: Tue, 12 Mar 2024 16:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
From: Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAXUCTDb_BlMeMqBA--.36492S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryxuF1fWr4kuw17XF1UZFb_yoW8XF4DpF
	W5Ga18trZFg3W2kanrX3sFvr4IkasrJ3W2kr4DA34Fvw1q9FyfArW3GwnxCw1j9ryrGa18
	KrWYyr9Fyw4DJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_080816_929904_37AE77DD 
X-CRM114-Status: GOOD (  16.00  )
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

On 2/23/2024 3:04 PM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> If a segmentation fault is caused by accessing an address in the vmalloc
> area, check that the target page is present.
> 
> Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
> assumes that the fault is caused by a stale mapping and will be fixed by
> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
> a guard page, no mapping is created, and when the faulting instruction is
> restarted, it will cause exactly the same fault again, effectively creating
> an infinite loop.

Ping. Any comment on this fix?

Petr T

> 
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  arch/um/kernel/trap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index 6d8ae86ae978..d5b85f1bfe33 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -206,11 +206,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>  	int err;
>  	int is_write = FAULT_WRITE(fi);
>  	unsigned long address = FAULT_ADDRESS(fi);
> +	pte_t *pte;
>  
>  	if (!is_user && regs)
>  		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>  
>  	if (!is_user && (address >= start_vm) && (address < end_vm)) {
> +		pte = virt_to_pte(&init_mm, address);
> +		if (!pte_present(*pte))
> +			page_fault_oops(regs, address, ip);
>  		flush_tlb_kernel_vm();
>  		goto out;
>  	}


