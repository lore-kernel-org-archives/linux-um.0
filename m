Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D3CCA1005
	for <linux-um@archiver.kernel.org>; Tue,  2 Sep 2025 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=voGobjfJ+JDIyxPuu8fGQb2u9QP7Z513vboXRHjWrpI=; b=VRJLWyt3OBmIUWfq4p0WKAyBwh
	3l6TE2vmA/Ug9BX1x+Y2KnGhqhID3VTUggPblMbVnTJOgirFBEAlp4g63/IDHAHCZae83kpuzsngP
	snVTsNrRmTZBS/heOuR/15fEFVvWytVG9HKPcPt45ZwcVycNzDhQ0IjS+ryBQMNg2Foux5L2gU/4K
	r+AfDiwjvA4Zt1Qm6vXaKpOvhS2KmPuG340y0Z3s4NBW5pCgOUJx9aIEuo1x3HR2SRGvxM5P1Yj8E
	PlzXLyYzeVaqqGrtKLK1PXfcXWz1RHnztHb5HEwKUOJfZkOxa8GikISFv9DbTXFr0KG3dhIa3zYhK
	PrWXyHNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utRDq-0000000062d-3tcQ;
	Tue, 02 Sep 2025 13:38:54 +0000
Received: from smtp-out3.simply.com ([94.231.106.210])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utPRd-0000000Gynk-1BrA;
	Tue, 02 Sep 2025 11:45:03 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cGP6x6Rpwz1FZPJ;
	Tue,  2 Sep 2025 13:44:57 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cGP6w5mgsz1FXjD;
	Tue,  2 Sep 2025 13:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756813497;
	bh=voGobjfJ+JDIyxPuu8fGQb2u9QP7Z513vboXRHjWrpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jXmzEnXapdgWj3k2C76LGG7k/5mt1kwvMqAYSfMFYlJ0dMOQ80Oj2YE0pnZAtNJ4t
	 tXQk/LzaZA57Nv160y42KGcSc12HLtx5zDkXLTwO001yujBIUCUp0jXWbSqOup1wEK
	 caelEQWo/j1aiLxV7BPWjSbstlue7ClkuM93YSG2cSzlCJSLWryT6cSw2EEQcr+aVF
	 FTt0lGn6fnMuHg7U0U6sd3U2Ku9tEiPKwlVMzDHUsOHxPUryMAOV1qAvelOgjen0aR
	 RoDQinmHdiIG1eCVLztKOXDNMYphrSPAPE4G8u5ceaF4FDq1DzCH6UTTJUx5w29cc0
	 vZYTj+Lq2QLjQ==
Message-ID: <92bace9a-b5c4-4ea1-a1f7-4742c15a64a0@gaisler.com>
Date: Tue, 2 Sep 2025 13:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arch: copy_thread: pass clone_flags as u64
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
 <f2371539-cd4e-4d70-9576-4bb1c677104c@gaisler.com>
 <11a4d0a953e3a9405177d67f287c69379a2b2f8f.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <11a4d0a953e3a9405177d67f287c69379a2b2f8f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_044501_607328_19799C7E 
X-CRM114-Status: UNSURE (   5.95  )
X-CRM114-Notice: Please train this message.
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

On 2025-09-02 09:15, John Paul Adrian Glaubitz wrote:
>> Thanks for this and for the whole series! Needed foundation for a
>> sparc32 clone3 implementation as well.
> 
> Can you implement clone3 for sparc64 as well?

(heavily pairing down the to list)

We'll take a look at that as well.

Cheers,
Andreas


