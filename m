Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A721CE8D58
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 07:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WaWmR/2gbJuAnFjeJ7UqO4YR7c/p0mLjhuVApW14H/8=; b=1DkRZBEBovYFVMZ8df5hcM25gE
	NsnvPl3KJr2r7lJYhPBn3I4XBDydz/KWKscv+hPMEpUxe//I6wGwXQlnRDCCf4Cqch1cMvJfhnPus
	ojAes6QR91X/1FgDc/i4dCHDMu+9WsFisLaNE/1uClGlzaOVNQdWujjHPD/M6XntnmIPloc/o81jB
	U+VusSRp0U+S5SufNfYhmp4M7X6Z1Bir2E2eQqyZiNAKo3BvVx8EkVY5EcQVguvHo4Gb7K0P35bh1
	cGBUz/8Cap5+qRV339Y0/qFPw7/NemEuQcgEZI6IlcKpvyYAHV/7+t0vpVt04iNymRN6JcdnNNyWh
	+QpEDEFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srBuR-00000009hQo-20RO;
	Thu, 19 Sep 2024 07:49:03 +0000
Received: from out0-197.mail.aliyun.com ([140.205.0.197])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srBtQ-00000009h3a-2sZn
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 07:48:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726732074; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WaWmR/2gbJuAnFjeJ7UqO4YR7c/p0mLjhuVApW14H/8=;
	b=yPO3T/WV6zvchZ4WA0ZyOQIG0COPqQ2NngdAexaqEeyq3kz5+LIz5mwbKVAUUfMMcyds8MbzpLY33xQ/DLcGxivzbtLvGLRpN/iznTPnhCKGs0VUPF64FvWDvIBQMUto9eaq9/8d+5cItMaFvaQRKTlns325+yZKcqGdm+qgSf4=
Received: from 30.230.84.113(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZNEik1g_1726732064)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 15:47:49 +0800
Message-ID: <75b42537-e895-4c3a-85b5-3c9beab3e149@antgroup.com>
Date: Thu, 19 Sep 2024 15:47:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Remove 3-level page table support on i386
To: Benjamin Berg <benjamin@sipsolutions.net>,
 Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240918061702.614837-1-tiwei.btw@antgroup.com>
 <0a73298f1c0ed189046360ea867e6da32276381c.camel@sipsolutions.net>
 <627bd11a7fe69fed02719c2ecf5370b59328e80d.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <627bd11a7fe69fed02719c2ecf5370b59328e80d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_004801_233597_973AEF22 
X-CRM114-Status: GOOD (  10.90  )
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

On 2024/9/19 15:22, Benjamin Berg wrote:
> On Thu, 2024-09-19 at 08:54 +0200, Johannes Berg wrote:
>> On Wed, 2024-09-18 at 14:17 +0800, Tiwei Bie wrote:
>>> The highmem support has been removed by commit a98a6d864d3b ("um:
>>> Remove broken highmem support"). The 2-level page table is
>>> sufficient
>>> on UML/i386 now. Remove the 3-level page table support on UML/i386
>>> which is still marked as experimental.
>>>
>>
>> No real objection, but with the 4-level page table work on 64-bit
>> pending as well (which likely conflicts), I wonder if we should just
>> remove 3-level *entirely*?

Fine with me in either way. Keeping only one page table implementation
on UML/x86_64 may require smaller maintenance effort.

> 
> Fine with me. There is only the tiny advantage of saving a few pages of
> memory for each process. I just erred on the side of keeping it in case
> anyone is cares to the option …
> 
> I'll resubmit the patchset without 3-level support then, possibly on
> top of this patch.

Thanks! :)

Regards,
Tiwei

> On the assumption that no one actually cares about
> 3-level page tables on x86_64.
> 
> Benjamin


