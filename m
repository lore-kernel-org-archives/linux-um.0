Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E230EB64D8
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wUySHTlSID3WPEWlXUgfQITtCN/LPUQSbrMgKF5nMeY=; b=hip52aWDvrooub
	4qDdUXdwhux9WDR4sg9Y1zxMST1lTb6QpIAMdR5wMfhQT5eAzHwaOCxsr9CsOeaW/Zc/U+DuGQs+G
	BtK6MLpe24lSpGFDB55R7r3pnhJNsyOEprWB8aBb2SZtcgkGmsHM5omb3FdW5x4ipdS63lQDomMDb
	f9EjtjGFPTZZo746WYhbVhduZJw3sRBOcCmWlmz270zr2mKs+O4vXg+AJ3vnb7C/dw5EeV5GwCPAZ
	w3+cMEamD7vfCSBRa5dkLI2vE8T290ZxQObcJWtE3A10Hol7X/2143A54/Xfc7dSZW0Cy4I7mdhTK
	/XpBxL2k+3u4GxVO8qsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9TYz-00CEeE-0B;
	Wed, 14 Jun 2023 16:41:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9TYv-00CEcj-26;
	Wed, 14 Jun 2023 16:41:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 14A0661C60;
	Wed, 14 Jun 2023 16:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2092EC433C8;
	Wed, 14 Jun 2023 16:41:32 +0000 (UTC)
Date: Wed, 14 Jun 2023 17:41:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 21/34] arm64: Convert various functions to use ptdescs
Message-ID: <ZIntusCSpsSHISYp@arm.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-22-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-22-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_094137_727775_5168667E 
X-CRM114-Status: UNSURE (   7.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, Jun 12, 2023 at 02:04:10PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
