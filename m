Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2E8C6FD1F
	for <linux-um@archiver.kernel.org>; Mon, 13 Mar 2023 00:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KL0m20TbZY9N3ZSGIrRwB9ne1xpbYYspHmNHzctxFlM=; b=wCnB2D3DhV1P8a
	LZ+BIY6CKWQJAneCBuhn+HX6g8EUsBea6cjN/zR3FQmC39P24He7CTdYyG+va2CQx9FegOvtJM8/a
	5k5SPPoUVe7qUdTEKCLn0XWAHbE33wRwV3qtkvbbtEHPirG4lR76KvnycSfB3IQKR8R2OP+Cb7bmx
	4OpG/qfFgHK9RJ9BcDusPX58+uH+mxSlcoWJg6oc7trwvYTY9+75LGvjMsVtOcKP1BHvHl0A5pmvv
	a5Hr66vwgJ5+dfjRsAVO+vnYSQOP6f9oxU9wGh8oDx+9x4ORhy+tYMFmN6yN0kE2MuI+syF6U5Gt2
	CGooD4ZsfAOqJGBsbUrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbVr7-003s1P-HG; Mon, 13 Mar 2023 00:16:01 +0000
Received: from [2601:1c2:980:9ec0::df2f]
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbVr5-003s13-Dj; Mon, 13 Mar 2023 00:15:59 +0000
Message-ID: <4ebfb363-6552-d387-9912-47eb4acfd9f8@infradead.org>
Date: Sun, 12 Mar 2023 17:15:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] IMA: allow/fix UML builds
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-integrity@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 Rajiv Andrade <srajiv@linux.vnet.ibm.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230224032703.7789-1-rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230224032703.7789-1-rdunlap@infradead.org>
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

ping?

On 2/23/23 19:27, Randy Dunlap wrote:
> UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
> NO_IOMEM).
> 
> Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):
> 
> ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
> ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
> ld: security/integrity/ima/ima_init.o: in function `ima_init':
> ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
> ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
> ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
> ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'
> 
> Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
> is set, regardless of the UML Kconfig setting.
> This updates TCG_TPM from =m to =y and fixes the linker errors.
> 
> Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rajiv Andrade <srajiv@linux.vnet.ibm.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> ---
>  security/integrity/ima/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -8,7 +8,7 @@ config IMA
>  	select CRYPTO_HMAC
>  	select CRYPTO_SHA1
>  	select CRYPTO_HASH_INFO
> -	select TCG_TPM if HAS_IOMEM && !UML
> +	select TCG_TPM if HAS_IOMEM
>  	select TCG_TIS if TCG_TPM && X86
>  	select TCG_CRB if TCG_TPM && ACPI
>  	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
