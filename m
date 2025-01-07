Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FD2E77198
	for <linux-um@archiver.kernel.org>; Tue,  7 Jan 2025 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5knQv7ge1Bw29A3+VSYl2cWOfYHZyvbmpFvhnZtIFXc=; b=ALwpNJcdQTHBR4jQUss943uWYg
	trykFQAFH0I0hZf+vUh4vcXeMHbO8+CtagEnngnfPwC6/iMfRvpgymyLTqMsqTzzbUZ2SgtunYGaW
	hJwgKx2BSrGMMq1lyQS43dtaE/OgEP5dGqzny5o3gE/uZMfwDHaub9Vft8o0y8M6gxGLAic/nLrwS
	8Rr+kVUOmvB2IZuUVDn17qLgRlDdFiZx/8rBqlsX4SQQvs/vQiHo3NsGewW8F/bBbAfskva75Vz5g
	WorqBzTN+gdFSkUBD8bsGAmUbH3WvcZff04rqHFx5gv2Yt6CXo66UHsmse+QUBkBh1IJ15Byvkel/
	Ne+Y4jjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5qA-000000046ut-2GzU;
	Tue, 07 Jan 2025 09:25:34 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5h1-000000044uo-0itq;
	Tue, 07 Jan 2025 09:16:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEFBD143D;
	Tue,  7 Jan 2025 01:16:32 -0800 (PST)
Received: from [10.57.93.53] (unknown [10.57.93.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 194C03F66E;
	Tue,  7 Jan 2025 01:15:56 -0800 (PST)
Message-ID: <98c59677-b0a2-4c87-b828-0503505529da@arm.com>
Date: Tue, 7 Jan 2025 10:15:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Account page tables at all levels
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, loongarch@lists.linux.dev, x86@kernel.org
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
 <ae8aa8d7-4121-4939-9890-c54e0aee7896@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ae8aa8d7-4121-4939-9890-c54e0aee7896@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_011607_262521_B14091EC 
X-CRM114-Status: UNSURE (   5.01  )
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

On 06/01/2025 09:38, Qi Zheng wrote:
> For this series:
>
> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thank you for the review, appreciated!

- Kevin


