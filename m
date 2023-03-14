Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C36C7618B
	for <linux-um@archiver.kernel.org>; Tue, 14 Mar 2023 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+hl4K0qqlqF8vR3YTU3kahTNEr8fA3lT0kMAWC5bdcQ=; b=zQ/fgWjaXCoQng
	1XK++N7xeu2t4ftuJIom9AiG7v2CgN1TbUrYANNXJ+Th1B3HOQYz58wJZfbtgMRKn0hQWA3dUQLjB
	XNQluznzd2x13HaOebe96cWRbd6FV12nFmBuNAnc8YWrL7iD8Mjm0NDKyE906ErjdNbsrs4GqqAlo
	zJdYGpJCh7BjELUhw5cw94M2Q08svyYMWFiGO46G0BScgWvVStFZ3wbsPLnqLQ2t4+Gh8waJ+2PVp
	8j7R+UDP3X8qIseXAYGzU7xZMmgtyl8x1R9WWYbQEdfe2XksiobEE83Lt/FZ9X/9uC7G3yoCYRD0v
	C+Z1flfQlK/C57ouPhWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcC7O-00BZup-1y;
	Tue, 14 Mar 2023 21:23:38 +0000
Received: from [2601:1c2:980:9ec0::df2f]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pcC7L-00BZu0-0e;
	Tue, 14 Mar 2023 21:23:35 +0000
Message-ID: <abf12edb-e541-adfc-1e5a-d06d9e1191aa@infradead.org>
Date: Tue, 14 Mar 2023 14:23:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] IMA: allow/fix UML builds
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-integrity@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 Rajiv Andrade <srajiv@linux.vnet.ibm.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230224032703.7789-1-rdunlap@infradead.org>
 <ab1e29c1620ac492b9194b4c7a465b20cd39076a.camel@linux.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ab1e29c1620ac492b9194b4c7a465b20cd39076a.camel@linux.ibm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 3/14/23 11:28, Mimi Zohar wrote:
> On Thu, 2023-02-23 at 19:27 -0800, Randy Dunlap wrote:
>> UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
>> NO_IOMEM).
>>
>> Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):
>>
>> ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
>> ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
>> ld: security/integrity/ima/ima_init.o: in function `ima_init':
>> ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
>> ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
>> ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
>> ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'
>>
>> Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
>> is set, regardless of the UML Kconfig setting.
>> This updates TCG_TPM from =m to =y and fixes the linker errors.
>>
>> Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Indicating this resolves a commit which was upstreamed in linux-3.4,
> while the fix for that commit 0bbadafdc49d ("um: allow disabling
> NO_IOMEM") was upstreamed only in linux-5.14, leaves out an important
> detail.
> 
> Is the proper way of indicating this disconnect by adding to the fixes
> line the kernel?
> Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies") # v5.14+

Yes, that is acceptable AFAIK. Also
Cc: stable@vger.kernel.org

or AUTOSEL would probably take care of this as it is.

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
