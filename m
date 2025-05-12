Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77AEC3ABCB
	for <linux-um@archiver.kernel.org>; Mon, 12 May 2025 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:From:Cc:To:Subject:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=WEajEjroG3KrJXm5xDlUPSI4uEwR8mvzm5iXEs8Yd8g=; b=HdyX/cIjGsVTBvJNUOr7vxFszx
	0dRAAVMOXECNeb4yk79k7wxbpGyy7sl2l4US+sEaSU/ZEhFLAF6oNCMGGEeNKFNPgQ8Qc2WNlk6OE
	o5VIDommf7+WpCzchooIAO8jJ63BlA3xwJjn3zSQxomhK9umvEpMAgkuap3oTMPVNBjoN6lqDkmDv
	r6/G13XHNYRrQK79wto7q1vFIfSDz4paBqVrwh7avSlQRB8dk/di3WnvUaczzGyj9+RWaW8JWdYxs
	Ft6PlbjYnJdHN9W2iNIkbV4zC/SaFRLOw6nSX4HJF/chIuPLu6u1ZhUkShFEefRFMyZHBQqXIsbwn
	DUT26uww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uETwO-00000009goZ-3pUI;
	Mon, 12 May 2025 14:15:36 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uETFH-00000009Z26-0B8A
	for linux-um@lists.infradead.org;
	Mon, 12 May 2025 13:31:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DA3F2A4AAF6;
	Mon, 12 May 2025 13:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3FAC4CEE7;
	Mon, 12 May 2025 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747056661;
	bh=I3w0yqK/Esga4Z5BS0l+X/WliYjn3vuYn8g72dxaGVA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=tY3XETxa1QhmOeo7qbnZUePHMz0RoOO8OEBS0VGOXRI4xtSqM20Vo0N1Wz9pudXNU
	 iDo4Cf4iK9S0uaaz7D8hLj878cA5xFoPoygBao9m5VNcWWmq+Gw64PI06bGxMmQzzC
	 rB0a29lJ5tyuUgOz4enGPJKNH7jajFsN1JP5MDqM=
Subject: Patch "[PATCH 6.12] Revert "um: work around sched_yield not yielding in time-travel mode"" has been added to the 6.12-stable tree
To: benjamin.berg@intel.com,chunkeey@gmail.com,gregkh@linuxfoundation.org,johannes@sipsolutions.net,linux-um@lists.infradead.org,richard@nod.at,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 15:30:58 +0200
In-Reply-To: <20250509095040.33355-1-chunkeey@gmail.com>
Message-ID: <2025051258-silenced-resend-bc87@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_063103_308366_119DCE5B 
X-CRM114-Status: GOOD (  17.79  )
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


This is a note to let you know that I've just added the patch titled

    [PATCH 6.12] Revert "um: work around sched_yield not yielding in time-travel mode"

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-um-work-around-sched_yield-not-yielding-in-time-travel-mode.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From chunkeey@gmail.com  Mon May 12 13:25:04 2025
From: Christian Lamparter <chunkeey@gmail.com>
Date: Fri,  9 May 2025 11:50:39 +0200
Subject: [PATCH 6.12] Revert "um: work around sched_yield not yielding in time-travel mode"
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com, sashal@kernel.org, johannes@sipsolutions.net, richard@nod.at, stable@vger.kernel.org
Message-ID: <20250509095040.33355-1-chunkeey@gmail.com>

From: Christian Lamparter <chunkeey@gmail.com>

This reverts commit da780c4a075ba2deb05ae29f0af4a990578c7901 which is
commit 887c5c12e80c8424bd471122d2e8b6b462e12874 upstream.


Reason being that the patch depends on at least commit 0b8b2668f998
("um: insert scheduler ticks when userspace does not yield") in order to
build. Otherwise it fails with:

| /usr/bin/ld: arch/um/kernel/skas/syscall.o: in function `handle_syscall':
|      linux-6.12.27/arch/um/kernel/skas/syscall.c:43:(.text+0xa2): undefined
| reference to `tt_extra_sched_jiffies'
| collect2: error: ld returned 1 exit status

The author Benjamin Berg commented: "I think it is better to just not
backport commit 0b8b2668f998 ("um: insert scheduler ticks when userspace
does not yield")"

Link: https://lore.kernel.org/linux-um/8ce0b6056a9726e540f61bce77311278654219eb.camel@sipsolutions.net/
Cc: <stable@vger.kernel.org> # 6.12.y
Cc: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/include/linux/time-internal.h |    2 --
 arch/um/kernel/skas/syscall.c         |   11 -----------
 2 files changed, 13 deletions(-)

--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -83,8 +83,6 @@ extern void time_travel_not_configured(v
 #define time_travel_del_event(...) time_travel_not_configured()
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
-extern unsigned long tt_extra_sched_jiffies;
-
 /*
  * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
  * which is intentional since we really shouldn't link it in that case.
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -31,17 +31,6 @@ void handle_syscall(struct uml_pt_regs *
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
-
-	/*
-	 * If no time passes, then sched_yield may not actually yield, causing
-	 * broken spinlock implementations in userspace (ASAN) to hang for long
-	 * periods of time.
-	 */
-	if ((time_travel_mode == TT_MODE_INFCPU ||
-	     time_travel_mode == TT_MODE_EXTERNAL) &&
-	    syscall == __NR_sched_yield)
-		tt_extra_sched_jiffies += 1;
-
 	if (syscall >= 0 && syscall < __NR_syscalls) {
 		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
 


Patches currently in stable-queue which might be from chunkeey@gmail.com are

queue-6.12/revert-um-work-around-sched_yield-not-yielding-in-time-travel-mode.patch

