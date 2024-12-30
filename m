Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E57E77188
	for <linux-um@archiver.kernel.org>; Mon, 30 Dec 2024 04:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLPKLeCfQ1ijGlwaEdWBBWtId0IsiPV7Gw+/VyTOg0k=; b=wAzEbElyzivQT2X7Gnogg6alNA
	5gR/x+5O8VDyMw7/c0X9wOmMhfeijgNxs50aElkCyTYiSpsT1Nukv8M/K328FN2FEdN9BB4Pk2IYf
	NSH+qvCMW8XZQ6TvWa8pWfkngJsQNUGu/7TD82x6ADYGUjOPqxuCfnRHGh5WMkdLfjVwn0D2MBPgO
	vQ7EzkT7ufhiqoU5MLbjKCv8mUAHch0N0s1jdB1d18NiqtaZFnSZsx/9fv2eQO4voQWnFKXC4Wstr
	Ko7ZnO7fDUyMJHQYKnRzYiRyJG9AOOKx2ku2FbLQIKDYgy5Biv74MvYQwPu4G9/owUZr6ySwWG5J1
	BqplIDYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tS7ps-00000004Xsx-3q9X;
	Mon, 30 Dec 2024 04:57:00 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tS7oj-00000004Xj7-0jOX;
	Mon, 30 Dec 2024 04:55:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EB418A40336;
	Mon, 30 Dec 2024 04:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0FAC4CED0;
	Mon, 30 Dec 2024 04:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735534547;
	bh=AJswIJAQd5FETiIh0u+rfDfZfqamfQp06InUDAPDuXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rhe3QlxDLrSSLi3sUiu8VVb+GHWge7MOiJcFxtA8oK28fW9HmGNW19VjrwSTcCGgb
	 r2YmGYGxTSfcYGqg8CrarFXVALRtvCpH5QUm8X8Dcox5YzUhoHoyUwOYqQ6lnY9L2Q
	 H2PY79bq6wwE7WdNlWq8aScHu3jsSCDF3yqMjhok=
Date: Sun, 29 Dec 2024 20:55:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Mike Rapoport <rppt@kernel.org>, kevin.brodsky@arm.com,
 peterz@infradead.org, agordeev@linux.ibm.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Message-Id: <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
In-Reply-To: <9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
	<b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
	<Z2_EPmOTUHhcBegW@kernel.org>
	<9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241229_205549_666019_9B155C65 
X-CRM114-Status: GOOD (  12.55  )
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

On Mon, 30 Dec 2024 11:12:00 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> > For now struct ptdesc overlaps struct page, but the goal is to have them
> > separate and always operate on struct ptdesc when working with page tables.
> 
> OK, so tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are somewhat
> intermediate products of the project.
> 
> Hi Andrew, can you help remove [PATCH v3 15/17], [PATCH v3 16/17] and
> [PATCH v3 17/17] from the mm-unstable branch?
> 
> For [PATCH v3 17/17], I can send it separately later, or Kevin Brodsky
> can help do this in his patch series. ;)

I think it would be best if you were to send a v4 series.  Please
ensure that the changelogs are appropriately updated to reflect these
(and any other) changes.


