Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FFCC3ABBC
	for <linux-um@archiver.kernel.org>; Fri,  9 May 2025 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3TNF/WTwb6fH59tCvVgLWV5Zr9bwM2Z/zWAmtxnfJ/g=; b=Mu25Ia7up0wUIOX5uTlGmp8Q5G
	dtCDS5T15FWyM6mK2+YMzAQAI822NGCWMmzxRxgX0ABCmyopGtUIjJqpzEIBdpblA4vdVn2505hcb
	oM231geusT/kJeY7iDcYjJThgozQfCV5StIuWx4FcIVZTiM+eDFSO8xeBSoxyhWRIZNeP+LDlNfoO
	86XaFFioGe9GF1k59yIcBmn8fqe9Mwoi4eo1zmelyzf4uw0urSmr3n/vcuEq0vMA3dfu2Xg2svbzn
	PqMcQYTAO4E3dzwh8VPX90/x2fTNkupH3eWq1uRNZoybTXmlMuB6aZRNCgEg9Toleg7id1UVsZGIc
	9VcHzijw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDL81-00000003JFJ-1zjT;
	Fri, 09 May 2025 10:38:53 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDKNQ-00000003AOc-1Dy6
	for linux-um@lists.infradead.org;
	Fri, 09 May 2025 09:50:45 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1058723f8f.3
        for <linux-um@lists.infradead.org>; Fri, 09 May 2025 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746784242; x=1747389042; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TNF/WTwb6fH59tCvVgLWV5Zr9bwM2Z/zWAmtxnfJ/g=;
        b=dmMaIuc5FYVD+uWUVGMAZ87gfvaRTIeynCZhY0oGahU0inYn3/+JR5hFMwxTFew+Ch
         qPB8leCH7ObWxPcnCIt0km6BAjUmOwmhyfMdleQCQMqP8mjXe3i8hco7wbm4HHYpgDLj
         k9xvzRpUH3WV27GUWft0V1JDCtcgmv/F1jywiDxY1KfEzpaI9T84DBft7ZjKFm9UU1Xa
         Zqam65bnZvNAMH3KL9fzzlmTUxm34MYvDuVErXXaVXN9NgUwvYdLbNysrxcyaHv2MA1R
         8p/45ccH6zSB8AKryCuLieWdX8WmjO61xJLIxT1JJkFz9R8GwiZ5MgI6OGDsOdMjlDgq
         FZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746784242; x=1747389042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TNF/WTwb6fH59tCvVgLWV5Zr9bwM2Z/zWAmtxnfJ/g=;
        b=SyBCGin09lkzj5r9gOYNTXRlHFNRUUZqsXGMn5cb+fjjaheShzsbQrAM2ln5P/HkSz
         44hyVBbx5db/Z/rI/ozbTJpUxxwCI7QUkUK8pbFuT0Cus57pIvydW0hMgLfSlil9W28v
         arjlMNsEo6HpKDsFVZpmb2eQ6obzbZNkFtmTkK5M8RuQ0qHAP7oiJvmVaPCyzCKvSbiO
         AWKQXKoPkqlWMc2snsTWXjY1jGl6ts0tlkmjHqRmZmdwHaWaVh95l7+FrI+b0HKr/Abm
         PQho/ql0GKkJodJpIAe9ii9CR/xVmdX8rwZpyicGdiCudTojBSKALeGWaXBObra8AQh0
         c1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU07cGCc6iNymbBcSavYuv2XEC+4gMJF8N9Oi7BGkDComc8SXsNkXwpRjzSzsMgEfxIg884YCdj4A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzKxWA1siwG7KyPHa39aMKPtaCsHysM3MDKjl3/9tORSWDZaj7u
	izk9ipLS6s4mI2MbLiSQuAbUyMKH/jY3Q/6gFU0ixhpyDtibJWAeLm1qAQ==
X-Gm-Gg: ASbGncuRfe+IKT573pf3Q4mukVLzihVoiW5zc1s7MaBSPEKFzTq+7K5Tka2aB9j+6fX
	482FceW8WGYJzIgGJIMKSkBqhmSbmndeQbsKGiYQmpi8Gmmg3spNZva/CNX1eVaZDRin3ZUN+jN
	hjOi+GdJYlYErC5RSNXUpHGg2LFTuCYYztCdZ9dlC6At9XDvyYB+/xCTussfXN6S8Gv3vmQfhLX
	8/ZspFSVYyS3hiSRULj1F7vQb/jlQx9YfMsLhY8yvoXtWqw+wXlTJlYPqtnOr8YwVgshYZjgt3y
	JicSH0TCyaTcXh86BNqYqEAlI4t+YcJiDSVBwZ6uEif38xbg4pRDeZ7WdRo+lv5/9ZoBj5IWRMS
	YSMxBmxWuN391XHJP+oT/xNZvRb1LYyoYY//0jSvv95G5
X-Google-Smtp-Source: AGHT+IGMXb7WjOlHsAN4McILuPOq3l/6AWG6K2Gldt3FlkNGZYP2N4+a8wqcjJih8Qzz9h7iz5UpcA==
X-Received: by 2002:a05:6000:2512:b0:3a0:809f:1c95 with SMTP id ffacd0b85a97d-3a1f64f1443mr2138130f8f.53.1746784241837;
        Fri, 09 May 2025 02:50:41 -0700 (PDT)
Received: from shift.daheim (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7e26sm66058155e9.37.2025.05.09.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:50:41 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.98.2)
	(envelope-from <chuck@shift.daheim>)
	id 1uDKNM-000000008gK-2htd;
	Fri, 09 May 2025 11:50:40 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com,
	sashal@kernel.org,
	johannes@sipsolutions.net,
	richard@nod.at,
	stable@vger.kernel.org
Subject: [PATCH 6.12] Revert "um: work around sched_yield not yielding in time-travel mode"
Date: Fri,  9 May 2025 11:50:39 +0200
Message-ID: <20250509095040.33355-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_025044_329691_7663A58F 
X-CRM114-Status: GOOD (  16.77  )
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

This reverts commit 887c5c12e80c ("um: work around sched_yield not yielding in time-travel mode")
added with v6.12.25.

Reason being that the patch depends on at least
commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does not yield")
in order to build. Otherwise it fails with:

| /usr/bin/ld: arch/um/kernel/skas/syscall.o: in function `handle_syscall':
|      linux-6.12.27/arch/um/kernel/skas/syscall.c:43:(.text+0xa2): undefined
| reference to `tt_extra_sched_jiffies'
| collect2: error: ld returned 1 exit status

The author Benjamin Berg commented: "I think it is better to just not backport
commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does not yield")
"

Link: https://lore.kernel.org/linux-um/8ce0b6056a9726e540f61bce77311278654219eb.camel@sipsolutions.net/
Cc: <stable@vger.kernel.org> # 6.12.y
Cc: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

---

Just in case, this throws someone else for a space-time loop:

What's interessting/very strange strange about this time-travel stuff:
|commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does not yield")

 $ git describe 0b8b2668f998
=> v6.12-rc2-43-g0b8b2668f998
(from what I know this is 43 patches on top of v6.12-rc2 as per the man page:
"The command finds the most recent tag that is reachable from a commit. [...]
it suffixes the tag name with the number of additional commits on top of the tagged
object and the abbreviated object name of the most recent commit."

But it was merged as part of: uml-for-linus-6.13-rc1 :
https://lore.kernel.org/lkml/1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at/
---
 arch/um/include/linux/time-internal.h |  2 --
 arch/um/kernel/skas/syscall.c         | 11 -----------
 2 files changed, 13 deletions(-)

diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 138908b999d7..b22226634ff6 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -83,8 +83,6 @@ extern void time_travel_not_configured(void);
 #define time_travel_del_event(...) time_travel_not_configured()
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
-extern unsigned long tt_extra_sched_jiffies;
-
 /*
  * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
  * which is intentional since we really shouldn't link it in that case.
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index a5beaea2967e..b09e85279d2b 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -31,17 +31,6 @@ void handle_syscall(struct uml_pt_regs *r)
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
 
-- 
2.49.0


