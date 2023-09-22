Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35B4CD4F45
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q1kc4jGspR4bK/kHvhJGJ7oExQ/piYcLUvNMrhyuSig=; b=c6xooicuM3aX/o
	RmQg8JiQzlFkVY252+4PJK6NsMNRe3w4XmMxRvBGdmEUAbWLghHy2+DU/HtGxrZp8NQIufK6sfjM0
	Cd94Nql3uKMztQ4hsCK42D8z6eAbZEb3PiDAZcRvPnchUqbSsljxMtvOhbDO36k5iX0oA9xcdXRgu
	oNQVi9Ib2Ym37kK/tV/e0bR+ohv8swJIjx6AcK+Smg9t791te/fdY0BNDpeTuFXc89ZwkYEdQ1Nff
	rE8LHMvrQO9eytth4FkFgziu+1Cle2LtpLn0oN0OR8ensAKnJf8v1/eOB4x8+IHgxw+5IHEqUudfW
	OLjlUGtyNxkmCAzvhPUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcof-008dn1-2j;
	Fri, 22 Sep 2023 09:51:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcod-008dlF-0r
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 09:51:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KsMpJmyEyLyvbArGlcrxpRCJCzxAYDRRDI1EN7PjGv8=;
	t=1695376270; x=1696585870; b=LT38gk7SKq4tBThXHfwH2qP/k/cOD05TockcEJ4PAvKaEQ+
	VdtaYjl2cqi/fhrDEuoR8xm/epXW2CjGy6P0P79rTPAqNHw+nP2HwhdrTCtq3srLEerVTVRdSUeAr
	AExxxDP52sJ2EGaS75lolYubEavgEi5R3SncxqRjvwYd3BL423HUBkTzmRjmZQGiPtA0mwA8txvM1
	hNrtLpKy76YYaAaPE4ZDvyWYzmJJ4An5cZetfNgliOMiZRUCPcYSHWarpJV9Vp/quZs3LGIWq+MuU
	rAv/R52sNrB0nfINUYfIacGmqdnre4F/uVsmTg9iClwQ0u1wn7yZjWWYmEydNy6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjcoU-00F8Gd-1V;
	Fri, 22 Sep 2023 11:51:06 +0200
Message-ID: <428dc1a37ab12368e09c555e44b767b8aa042cfd.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 11:51:05 +0200
In-Reply-To: <b8769840-1e33-f9bf-7a55-6ea805a1639a@cambridgegreys.com>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
	 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
	 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
	 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
	 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
	 <40babfb4-ed65-dd0e-23aa-abdfaa9c7149@cambridgegreys.com>
	 <efaa802bcd0369665b3dbc10030c9ca88aa2cb30.camel@sipsolutions.net>
	 <1ce8c412b0d2bdfa176f1f783281e393da94ff6f.camel@sipsolutions.net>
	 <b8769840-1e33-f9bf-7a55-6ea805a1639a@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_025115_301328_9B2D5CFB 
X-CRM114-Status: GOOD (  12.13  )
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

On Fri, 2023-09-22 at 10:19 +0100, Anton Ivanov wrote:
> > 
> > So maybe that works - perhaps with a big comment?
> 
> Ack. Will add this to the patch and run it through its paces.
> 

We can also just get rid of it entirely:

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 68e2eb9cfb47..23dcc914d44e 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -13,8 +13,6 @@
 #include <asm/mm_hooks.h>
 #include <asm/mmu.h>
 
-extern void force_flush_all(void);
-
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 6daffb9d8a8d..a024acd6d85c 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -25,7 +25,6 @@
 #include <linux/threads.h>
 #include <linux/resume_user_mode.h>
 #include <asm/current.h>
-#include <asm/mmu_context.h>
 #include <linux/uaccess.h>
 #include <as-layout.h>
 #include <kern_util.h>
@@ -139,8 +138,6 @@ void new_thread_handler(void)
 /* Called magically, see new_thread_handler above */
 void fork_handler(void)
 {
-	force_flush_all();
-
 	schedule_tail(current->thread.prev_sched);
 
 	/*
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 656fe16c9b63..f3766dbbc4ee 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -30,10 +30,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		from_mm = &current->mm->context;
 
 	block_signals_trace();
-	if (from_mm)
-		to_mm->id.u.pid = copy_context_skas0(stack,
-						     from_mm->id.u.pid);
-	else to_mm->id.u.pid = start_userspace(stack);
+	to_mm->id.u.pid = start_userspace(stack);
 	unblock_signals_trace();
 
 	if (to_mm->id.u.pid < 0) {
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 34ec8e677fb9..ce7fb5a34f0f 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -599,15 +599,3 @@ void flush_tlb_mm(struct mm_struct *mm)
 	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
 }
-
-void force_flush_all(void)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma)
-		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-	mmap_read_unlock(mm);
-}




I think that _might_ be slower for fork() happy workloads, since we
don't init from skas0, but I'm not even sure what's _in_ skas0 at that
point? Does it matter?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
