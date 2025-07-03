Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB29C83F05
	for <linux-um@archiver.kernel.org>; Thu,  3 Jul 2025 21:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jjOLwEZEZwj6P2cZondP2eaYEZTd2Boa5qjSBHDModI=; b=inOH6FPCd7PqEYG5SqdXt12sRx
	kupy7t/Ri/s/uBOUt+Z+/7tmkJ302tlK+3+2oIxxEFEM/4IxEYDJgMSfYiDBzLGZJbet/GbUViO6P
	ApOBSxVhCeGX5dYx4DgwREMmibavdjf9g49p6KWYRP300RDpM7d71BwVAJ0UFNEw/Z0Rr5gIuKf6G
	b316SnZD2LAcVGDuR006iRf9vDZ6u42tKaKmmJ9eUSQZYYo873LBt7XrTTBZh8zs8b2V2kP6OeC07
	aBRB3OPPiDHtHSyPELdXi+PUmJSRTr19HTIoO6L2rWi7BxDr5O7RIkYZ3pDASx8p1qEq2FPg9d1d8
	xndRUAPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXR2L-0000000CXXz-0tYX;
	Thu, 03 Jul 2025 21:00:05 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXMyV-0000000C1VX-1Pez
	for linux-um@lists.infradead.org;
	Thu, 03 Jul 2025 16:39:52 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751560789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjOLwEZEZwj6P2cZondP2eaYEZTd2Boa5qjSBHDModI=;
	b=DJuR/T0GsNfopXDnSPcTyaZ77QMbyWDWudCydZqj1R20l4csZI3pzmc6P8WYaOjMUxKQs/
	2ZSqUQJ/lc/+z7OGomXF/F8zgIkgL55T6x3pOq5PXga8aIfajQC9Xb2q/LtGBALayPZ7gy
	+ZV6B7NjyWGdkQvcaO2nSF//VKsZ5sbnVJEWQJrSEMkcU0M2GqNLAj6bz/8hUVDkNPQMq6
	JR4tHEirmSORHx08aAjw/ia8ykAhe6VGAjvH00Br3HTIx5CoLrsnDr0ithECDHVkCqee1G
	jqlVo8ZdLWw0hWRTd4BbXcXx3jr1h9XUL9JgsAvV5ghOlx1Mc4zciIAO2frPqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751560789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjOLwEZEZwj6P2cZondP2eaYEZTd2Boa5qjSBHDModI=;
	b=VDi6FmiSJTl7dRJH5WanB3BzmI9QfNeyqElOW0KK/ZxJkACgTIdSDNc79HsNI+KjvOpSVZ
	ejAsrSbh+puqqvCg==
To: Nam Cao <namcao@linutronix.de>, Johannes Berg <johannes@sipsolutions.net>
Cc: Marc Zyngier <maz@kernel.org>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] um: virt-pci: Switch to
 msi_create_parent_irq_domain()
In-Reply-To: <20250630070249.oVVkmFZg@linutronix.de>
References: <cover.1751266049.git.namcao@linutronix.de>
 <5f0bd8e877e7bfdfb1a7e99d6b126caf6a7eea48.1751266049.git.namcao@linutronix.de>
 <e64a4c40b0234fc265a74cb60633117dc6911518.camel@sipsolutions.net>
 <20250630070249.oVVkmFZg@linutronix.de>
Date: Thu, 03 Jul 2025 18:39:48 +0200
Message-ID: <87plehtei3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_093951_512800_BF5E62F9 
X-CRM114-Status: GOOD (  10.11  )
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

Johannes,

On Mon, Jun 30 2025 at 09:02, Nam Cao wrote:
> On Mon, Jun 30, 2025 at 08:55:54AM +0200, Johannes Berg wrote:
>> On Mon, 2025-06-30 at 08:51 +0200, Nam Cao wrote:
>> > Move away from the legacy MSI domain setup, switch to use
>> > msi_create_parent_irq_domain().
>> > 
>> 
>> Do you want this to go through the UML tree, or is it a dependency
>> somewhere else? In the latter case, I suppose you can add
>
> Please take it into the UML tree.
>
>> Acked-by: Johannes Berg <johannes@sipsolutions.net>
>> Tested-by: Johannes Berg <johannes@sipsolutions.net>

are you picking this up or want me to queue it?

Thanks,

        tglx

