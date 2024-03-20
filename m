Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFD3C6FD1F
	for <linux-um@archiver.kernel.org>; Wed, 20 Mar 2024 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Mi8dm1qszCQPDlXk/8jOIKYd8qLa+0PMH37O+I5XlQ=; b=OQnGfjvOhn2Ql3zF1tz/XVO1KQ
	k2JW3xOI8OOc7ndVj0N+MeJdtkMUy/hH6yQ31PYxsU+JANlKw195fMrr0VMWu/vMpxYCnUlNhXPY5
	2T/DyVkXVr4BTBGqQxVlOEtvixWvohfyElpvUf7Hc0N374ZYPlAbHeWbXmswSst5k+ygYJpxCpPZx
	tsVsEgOhDD4qsLDXRZKp5Wsndlu6DLWUE9vM7W412z3/7y7XwjDFIp/Uonp+NcsnUfldhjysFDTFW
	BuZmdJ0vXcKh7y10id38rCEJg9GMOB9wvfcLM436o3Gn5odJEqCyqJiPVIM5fuBAP00Ma2N3nddJe
	F7f1PCjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmwTd-0000000HLrQ-0UYl;
	Wed, 20 Mar 2024 13:59:33 +0000
Received: from frasgout12.his.huawei.com ([14.137.139.154])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmwTZ-0000000HLpw-1afr
	for linux-um@lists.infradead.org;
	Wed, 20 Mar 2024 13:59:31 +0000
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4V08nl63Cfz9v7bq
	for <linux-um@lists.infradead.org>; Wed, 20 Mar 2024 21:39:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A6DB714064D
	for <linux-um@lists.infradead.org>; Wed, 20 Mar 2024 21:59:10 +0800 (CST)
Received: from [10.221.99.91] (unknown [10.221.99.91])
	by APP1 (Coremail) with SMTP id LxC2BwCHehOm6_plBBWtBA--.47981S2;
	Wed, 20 Mar 2024 14:59:10 +0100 (CET)
Message-ID: <6a62f534-463f-45c4-a5ea-2c1021cf45d4@huaweicloud.com>
Date: Wed, 20 Mar 2024 14:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
To: Richard Weinberger <richard@nod.at>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, petr <petr@tesarici.cz>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
 <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
 <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
 <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHehOm6_plBBWtBA--.47981S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1xZr13KFy8tFW3XF17Awb_yoW8Ar43pr
	ZxGa1DJrs2qw1Sya1j93y2y3W8KayfJr13Jrn8t3s5Zr1q93WxtrW3Kw4kGa4qvr4xuFyY
	krW7GF9Fva4Yy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_065929_839759_46C361E5 
X-CRM114-Status: GOOD (  11.15  )
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

On 3/19/2024 11:18 PM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
>> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
>> <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
>> CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "petr" <petr@tesarici.cz>
>> Gesendet: Montag, 18. März 2024 14:09:07
>> Betreff: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in the vmalloc area
> 
>> On 3/12/2024 4:07 PM, Petr Tesarik wrote:
>>> On 2/23/2024 3:04 PM, Petr Tesarik wrote:
>>>> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>>>
>>>> If a segmentation fault is caused by accessing an address in the vmalloc
>>>> area, check that the target page is present.
>>>>
>>>> Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
>>>> assumes that the fault is caused by a stale mapping and will be fixed by
>>>> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
>>>> a guard page, no mapping is created, and when the faulting instruction is
>>>> restarted, it will cause exactly the same fault again, effectively creating
>>>> an infinite loop.
>>>
>>> Ping. Any comment on this fix?
>>
>> I don't think I have seen a reply from you. If you did comment, then
>> your email has not reached me.
>>
>> Please, can you confirm you have seen my patch?
> 
> Yes. I'm just way behind my maintainer schedule. :-/

Understood. Thank you for your reply.

By the way, are you looking for more people to help with the amount of work?

Petr T


