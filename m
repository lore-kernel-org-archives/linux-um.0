Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0218DE7719E
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFKS9He99X0lK3xnnbI99ZyULyVP6qmX2/a79HHV3Mw=; b=Zp9fZyqzKQ9ef/IXcs44iWVDG/
	VAKROXnvIG72PujKctfL6ThqwM24oI9YEAi0tVVn0XAsg7SkIq7j0JoM++pusqHL0dX/gDgIzFS5w
	H0NOPZjfZy0wTcvZVTYOAbTnr+uyzaniPNDGekpCFUHgxcQmxOD5jRI8um0rgnoR9ddshnxdwLCR+
	DtWslxlThNeN8xEEj1+RfgLT7IkFl3bhtPH5k5qUXsl0ajo4lOqGC3/W8EKwURvTJauIB5MEbbEx6
	woIo1FamzIEs5kl3aQuB4LfvnMyWbUw+VDB89xCc6JstVC1p0y1/n+dHK49oNU1BdHhKwm6oIapG2
	3skapkLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWLZB-0000000GtFn-3Bk3;
	Fri, 10 Jan 2025 20:25:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwn-0000000GbhQ-1eoX
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 18:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HFKS9He99X0lK3xnnbI99ZyULyVP6qmX2/a79HHV3Mw=; b=m81/k4+RSCYLefk/bmCSJBzI6S
	7XrmatHV2EycH5dD8ZTH5Kt1omwPgqOQXtmc297k82Gdmk3RuDeVXpbthIxlQMBMGhMIIvnQHc8Ic
	WJyt/22adqMcKC/rvazJk0pQKoPtbH93yaBWF4NTqoWXhTUqBMwLs8zEkWbKKMorKqOU2ga0CS/EW
	3WlLuKXL5FEZ40lMZd9WwWbmUUo9/XUX1G1zEy3KNPAdMCPaj82RgQOA3q02YD+de1oCddfhTlqBm
	ghIBkDBo/CHcnC1RE0k8vbqZWq1yTGvZkzNQv6ARw9dpiGT97CGU4HHC5tf4DDmQ2rNqQcRCKFmSJ
	yFvOTGtg==;
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWJwk-0000000EBNe-1Fkg
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 18:41:28 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-436723bf7ffso19279215e9.3
        for <linux-um@lists.infradead.org>; Fri, 10 Jan 2025 10:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534484; x=1737139284; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFKS9He99X0lK3xnnbI99ZyULyVP6qmX2/a79HHV3Mw=;
        b=acJKGZDtuBUMClBPkewJWxO/JWk1nf0iRcmUR7veI5O7dBxSqJPSMijRjunF1BHvqI
         iDhC72IrCN0wfFvHGgTJFPBJdQII6ceA/EbX0KgiD+u1678ivnEgU3plQdJcO1lceyq4
         9vu3uwx8v13itzWD1Nf3D+JtAt80A5zJTnuIuTZBvwFmeXq1ylhiJnxpTZtPiC9NrtcL
         J0l07yAClMJPDKKqmUA0+ANE3+jm3gfSliMpd1ZC5JTcdKFtw8UuF+04eZK+ApUr4vnz
         duJnD6CCegwvJf4yjfW7S2X5PJ3nF22NiyrJ6DQWSg9CtAgntD6PxzTRy5V1HCYhRA7Q
         BQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534484; x=1737139284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFKS9He99X0lK3xnnbI99ZyULyVP6qmX2/a79HHV3Mw=;
        b=pgtju7kg7zj8r6PLiMfI7+C/AQDQS20qEI17IIHQhCPd70gkBUpmTNNR/Mg5rldSZM
         tvSqnhNrObSr76HwXZJo1kRkJAGxuZ6ob061BtlrZ7hrXvR1wzNkzzrk3IZ0Lyf9h1sA
         jeLuv+n2dZxdiJInYljV/Ccp5m9+uGhWwh4Zrl2FvKsJpZqIhRPAOMyoNX6sPoC8pIVw
         /ahFTjZLFCtUBe4ZPmq4fIJk9L4zvm0/uvCWX6uwAVnLfSQrdvbYGiFDu69QnYAHSY6l
         awOLpdAT7EfObtCowCOx4mQELySDNiNjaUsg+D52raKlysVUi8eJ3gRgDK+Y0mSX2wLV
         NDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Gpu/9vflHd+v/Z8Av8nOrDGitOQCHcuQFqVi4ldtiwj5LNMSvQG52uibHx/Sl8+QDVljLNAxKQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywfu+QwUH0HfV5tARI9EeaajUC4iXoDySQQUqelSv14JWyb7gFW
	b6LQGL0S/T3SzKxd6lDgD7rQwl7JfiUAWOs5rWS7nWXjEdhYa5MX1sFaqZb7nmVmc6JQ/dPSk1b
	iUdX188YqXg==
X-Google-Smtp-Source: AGHT+IHb2tLJeEj/nhEIcvCueP11HP0tzz903p60s9RvGJF27LFwQlQKr5YD0ey6aPDR1IvAD0AJ740K8RZlJQ==
X-Received: from wmbbh20.prod.google.com ([2002:a05:600c:3d14:b0:434:fd4d:ffad])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3c85:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-436e2679a7cmr125832515e9.5.1736534484149;
 Fri, 10 Jan 2025 10:41:24 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:43 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-17-8419288bc805@google.com>
Subject: [PATCH RFC v2 17/29] mm: asi: Map vmalloc/vmap data as nonsensitive
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_184126_391254_55A04DAB 
X-CRM114-Status: GOOD (  20.12  )
X-Mailman-Approved-At: Fri, 10 Jan 2025 12:24:52 -0800
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

We add new VM flags for sensitive and global-nonsensitive, parallel to
the corresponding GFP flags.

__get_vm_area_node and friends will default to creating
global-nonsensitive VM areas, and vmap then calls asi_map as necessary.

__vmalloc_node_range has additional logic to check and set defaults for
the sensitivity of the underlying page allocation. It does this via an
initial __set_asi_flags call - note that it then calls
__get_vm_area_node which also calls __set_asi_flags. This second call
is a NOP.

By default, we mark the underlying page allocation as sensitive, even
if the VM area is global-nonsensitive. This is just an optimization to
avoid unnecessary asi_map etc, since presumably most code has no reason
to access vmalloc'd data through the direct map.

There are some details of the GFP-flag/VM-flag interaction that are not
really obvious, for example: what should happen when callers of
__vmalloc explicitly set GFP sensitivity flags? (That function has no VM
flags argument). For the moment let's just not block on that and focus
on adding the infrastructure, though.

At the moment, the high-level vmalloc APIs doesn't actually provide a
way to configure sensitivity, this commit just adds the infrastructure.
We'll have to decide how to expose this to allocation sites as we
implement more denylist logic. vmap does already allow configuring vm
flags.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/vmalloc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8d260f2174fe664b54dcda054cb9759ae282bf03..00745edf0b2c5f4c769a46bdcf0872223de5299d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3210,6 +3210,7 @@ struct vm_struct *remove_vm_area(const void *addr)
 {
 	struct vmap_area *va;
 	struct vm_struct *vm;
+	unsigned long vm_addr;
 
 	might_sleep();
 
@@ -3221,6 +3222,7 @@ struct vm_struct *remove_vm_area(const void *addr)
 	if (!va || !va->vm)
 		return NULL;
 	vm = va->vm;
+	vm_addr = (unsigned long) READ_ONCE(vm->addr);
 
 	debug_check_no_locks_freed(vm->addr, get_vm_area_size(vm));
 	debug_check_no_obj_freed(vm->addr, get_vm_area_size(vm));
@@ -3352,6 +3354,7 @@ void vfree(const void *addr)
 				addr);
 		return;
 	}
+	asi_unmap(ASI_GLOBAL_NONSENSITIVE, vm->addr, get_vm_area_size(vm));
 
 	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
 		vm_reset_perms(vm);
@@ -3397,6 +3400,7 @@ void vunmap(const void *addr)
 				addr);
 		return;
 	}
+	asi_unmap(ASI_GLOBAL_NONSENSITIVE, vm->addr, get_vm_area_size(vm));
 	kfree(vm);
 }
 EXPORT_SYMBOL(vunmap);
@@ -3445,16 +3449,21 @@ void *vmap(struct page **pages, unsigned int count,
 
 	addr = (unsigned long)area->addr;
 	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
-				pages, PAGE_SHIFT) < 0) {
-		vunmap(area->addr);
-		return NULL;
-	}
+				pages, PAGE_SHIFT) < 0)
+		goto err;
+
+	if (asi_map(ASI_GLOBAL_NONSENSITIVE, area->addr,
+		    get_vm_area_size(area)))
+		goto err; /* The necessary asi_unmap() is in vunmap. */
 
 	if (flags & VM_MAP_PUT_PAGES) {
 		area->pages = pages;
 		area->nr_pages = count;
 	}
 	return area->addr;
+err:
+	vunmap(area->addr);
+	return NULL;
 }
 EXPORT_SYMBOL(vmap);
 
@@ -3711,6 +3720,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
+	if (asi_map(ASI_GLOBAL_NONSENSITIVE, area->addr,
+		    get_vm_area_size(area)))
+		goto fail; /* The necessary asi_unmap() is in vfree. */
+
 	return area->addr;
 
 fail:

-- 
2.47.1.613.gc27f4b7a9f-goog


