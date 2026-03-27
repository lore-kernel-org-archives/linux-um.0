Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A5C10BA439
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DoxlJLpzOFREqNzYvxXK+7Wyu48MgzL3nY3gxnlOqXc=; b=HnoSWlV2kOzaDsIAzKEQVjeLC1
	Rh0TRASENaDkqYR9LjY12G2EPk7FGswK6tZ35fC7LEPUGSnPswN8q3CpPXBfw1n5cKx4oNLJV2eNL
	hVq92Z1ew0uIbShhfZasbEZQyWYokfNbPafLDz7GqsRUN5dH21eh2c4/5V09nWMqYYDpVHzuhcI0/
	Yb180/ValtsGnVaoiI5sqAQgaYVA+kQX2yV6z2D8GxQOHjopWRxwOt0qxoUpDeQ3lEH9ede7hPHKy
	e1jr2txTQpR2H4PZh1Sb+K40P9YXmaqweu2j9Ayc1Wfnk6L7GU50bwdNvhie8P98gaaDby+HHh7dK
	uw1CCLoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w62XW-00000006y26-0Vyf;
	Fri, 27 Mar 2026 08:27:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w62XT-00000006y1Q-3Qwf;
	Fri, 27 Mar 2026 08:27:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DE7C6132B;
	Fri, 27 Mar 2026 08:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE27CC2BC87;
	Fri, 27 Mar 2026 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774600050;
	bh=rkUuEott97cRG5EOSGam/2vURy0iz3AdOFQvnDvFuRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R1FdErCmpRUfW0Lp5ZacGDOniuT0AwJlAxVfVuljmrw2wCU7cAUPkqPI98IpTty16
	 NBIRt4fVUPiLgcyTUvdyX/EfQJaP/Fn+rUGOf8JpxGhClHrnG7f8KRPoQz2OYh1WaJ
	 H5o9DZM6WUru2OjwRibUTWgPS0u+3sPFUJBa/UzXV6LBqi+UjomHjJiBFcJiETq+MT
	 87z1mRd67LAk1ZwXpjMe9nbD7JZY1/qttMJlLYp/x5WS7qVfoyPw2boeixrn5xIQMI
	 FsKHOJV0ipEd+DPBQwi0B3HVifAvbXhgvRqUcdTuwlnZX1A9XjKSccTw9hYhAHIm+3
	 pgbO2wr7F/yFQ==
Message-ID: <c9bec45c-3312-46a7-a7bc-a7dba95bcda7@kernel.org>
Date: Fri, 27 Mar 2026 09:27:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] mm/vma: convert vm_flags_t to vma_flags_t in vma
 code
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
References: <cover.1774034900.git.ljs@kernel.org>
 <20260326225031.87e04d2c652923bc10aef0ee@linux-foundation.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260326225031.87e04d2c652923bc10aef0ee@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/27/26 06:50, Andrew Morton wrote:
> On Fri, 20 Mar 2026 19:38:17 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
> 
>> This series converts a lot of the existing use of the legacy vm_flags_t
>> data type to the new vma_flags_t type which replaces it.
> 
> Series has nine unreviewed patches.

I think I only skipped those that were tools/testing only, because I'm lazy.
In case a tag is missing in a non-test patch, let me know please.

> Again, I plan to upstream this as-is - lots of Lorenzopatches remain
> unreviewed and I'm OK with that.

Ack, thanks!

