Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E44BE77188
	for <linux-um@archiver.kernel.org>; Tue, 31 Dec 2024 00:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jynuZ6RqW0K2fp3acwqYJBGI67T695Su3/atzM2yXCw=; b=JR8daPfEBcnRgyRse5JUJvJf3K
	WQFoVv7Xw0o8OwSLcTxC9y/JBNTzWFhEHNgZxvOxeu6+ZEWWqlnSLT6xvnOEq92y7B57hiQ3sjPj/
	y9EZY4QcJRTPc3UMMR+O1sVSVFHAlkIGep6RWFs5pak3GxNu9Gou6pWvHNEZJmu9ZOAQh9+wsFek0
	WPySn2wG4zMjdd3Q9P5Y6QQoIRkrBjuKgEuV4b0nRT19zgibGciy4jOdRzUpN9awcu/0KM11sim9c
	uhdkMc/fclLVAmqBLpJnIqnlewqs8OT1hhKfH8/7IYqRJdeh/yVPzlyuUsyeWRkXps2gL+8VWa5n8
	obcM3M2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSQ4m-00000006C7t-1tZj;
	Tue, 31 Dec 2024 00:25:36 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSQ3X-00000006Bp4-2hSZ;
	Tue, 31 Dec 2024 00:24:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 222ECA40FC4;
	Tue, 31 Dec 2024 00:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97495C4CED0;
	Tue, 31 Dec 2024 00:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735604657;
	bh=2Z/3V1q46cErKadoV3y8VtC0UOopLVjvmzLFmpjI5ZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1svhMQUmdhMgcQjt88gUZcpq5ze2FpENDmeroTm5j525bnUbXasg93NeBqNAKuwX
	 4zTZ6tN5Yr2qdY61qOZxnyRQ1159nEMzAQ1YQfsHm2DW8ARwWXBuvfim5detOnI3XI
	 EB0PhrLFTgZnLoKq75DG+Xuc3x8ekQPiOw33OnkY=
Date: Mon, 30 Dec 2024 16:24:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
 palmer@dabbelt.com, tglx@linutronix.de, david@redhat.com, jannh@google.com,
 hughd@google.com, yuzhao@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v4 00/15] move pagetable_*_dtor() to
 __tlb_remove_table()
Message-Id: <20241230162416.da83460318c4726f65fb4e3b@linux-foundation.org>
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_162419_739464_6AF82D5D 
X-CRM114-Status: UNSURE (   7.78  )
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

On Mon, 30 Dec 2024 17:07:35 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Changes in v4:
>  - remove [PATCH v3 15/17] and [PATCH v3 16/17] (Mike Rapoport)
>    (the tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are intermediate
>     products of the project: https://kernelnewbies.org/MatthewWilcox/Memdescs,
>     so keep them)
>  - collect Acked-by

Thanks, I've updated mm.git to v5.

