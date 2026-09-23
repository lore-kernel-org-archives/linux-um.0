Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD61AC98307
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKKXd8n2HOhU5Q0gLVPMEbhCsXKgHbRUMQtENSwBdyw=; b=3Jg7SdVwwbmG+uH3tH/JHPujyS
	ZwnCchlJGoQjIW4uW5TeWOViQsIHTx1NfaSraq5YVnTboMXdskKa5Qb6iTGrzieqDBayQMtQs/DoE
	IIG6jUuVeFuoGANi2X9SgKjq0K8EjmcOPKVkohgNDY+zY9HD4kwgGhyJ+teQQiN4kw7OIjuMJSxI8
	dOzApI3U6lYDgP8n4z4YlKb2vEqJF3JYLs1taffy1STfheRIZyJmzaW9VEm+Z8nA7w2Qx8S2VUmDh
	utzc2HClNhpN0DhUPucOB7/Ph30w07DAzU0t2kcsAX2vuJ8yo/MQFJ0P+ZiAydc5diJkh9PLg7fhh
	n4RlisCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9IkH-00000007cJH-1HWg;
	Wed, 23 Sep 2026 08:54:29 +0000
Received: from out-193.mta1.migadu.com ([95.215.58.193] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9IkE-00000007cHY-2Aut
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 08:54:27 +0000
X-Envelope-To: linux-um@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=mKKXd8n2HOhU5Q0gLVPMEbhCsXKgHbRUMQtENSwBdyw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790153664; v=1; x=1790758464;
 b=V2qKL0I0MCZJ8Mfd0PGbrJUAsEMCVf58mZhteUM9t3UnnQ4L73TT5bKp+DtoyIWLaPLcOx5U
 OQaUyvuRBdF4JRlCaF658YF5JPI1dnFBtn+vrZaBCMeG6PSLZpNrczO7xDbZE0DhmBMJfByqZNc
 ZjoCI/GqNQE8wNB/GYZz9mcY=
X-Envelope-To: linux-um@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id c56b50517945abbe;
	Wed, 23 Sep 2026 08:54:20 +0000
X-Mizu-Trace-ID: c56b50517945abbe
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 06/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc64
Date: Wed, 23 Sep 2026 16:54:14 +0800
Message-ID: <20260923085414.17309-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-6-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-6-fe1ad1f1e303@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_015426_696778_04AF9754 
X-CRM114-Status: UNSURE (   6.47  )
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


On Tue, Sep 22, 2026 at 04:35:37PM +0100, Lorenzo Stoakes (ARM) wrote:
>Commit 4a0100f7546f ("sparc64: use RCU page table freeing") enabled
>CONFIG_MMU_GATHER_RCU_TABLE_FREE for SMP sparc64 architectures, expressly
>for GUP-fast page table walkers.
>
>Naturally, UP systems do not have to worry about concurrent GUP fast
>operations.
>
>However, CONFIG_PREEMPT_RCU is also available even on a UP system, so a
>future pure-RCU page table walker requires MMU_GATHER_RCU_TABLE_FREE to be
>enabled on UP, even if concurrent GUP fast is not possible there.
>
>To enable future pure-RCU page table walkers, enable
>MMU_GATHER_RCU_TABLE_FREE unconditionally.
>
>With this change, it is no longer necessary to have !CONFIG_SMP
>pgtable_free_tlb(), so also remove this now dead code.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Also ran page-table teardown stress on qemu-system-sparc64 (sun4u, UP).
That ran cleanly too ;) Feel free to add:

Tested-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Lance Yang <lance.yang@linux.dev>

