Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E29C88E56
	for <linux-um@archiver.kernel.org>; Sat, 12 Sep 2026 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZOGMTD5LGSJ43nsYgDh0j1HHamIrGJcLYj3gibAvI+U=; b=RMXRhK0CGFbFLdouUL2dpbtZiM
	ukuOu46n3axMa0Nf/Ec480N/kiCQPMXWRTIrDIg3X518isJj04ON9hOrlW3QY8eD3bwJpV8A88Tr2
	jU8Lg7hBGkVWNPXphB+aCRVYEbU31af4uvAL00jBhLROyGJs8JuKitKHMXEZyqR6gp82h/KwWio6B
	KnAZAxwMIep00gbRz5Z60YXCjBLpHaeGsF2pqOwu69aWJmUBjfcvdTTk3W6IrlqO2uK/HW5OqFDSq
	CYUVaGQu1r+85SFJp99WsA1kVVy2a7Zf9a2TvsxRq51L8tuAR6C8uFT0a9QqejfzBrhHEHCfeWuYb
	/c4H1P2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5WNo-00000001GK3-2EQ2;
	Sat, 12 Sep 2026 22:39:40 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5WNl-00000001GJh-07WT
	for linux-um@lists.infradead.org;
	Sat, 12 Sep 2026 22:39:38 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-93a0bf264a4so55955685a.1
        for <linux-um@lists.infradead.org>; Sat, 12 Sep 2026 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789252775; x=1789857575; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZOGMTD5LGSJ43nsYgDh0j1HHamIrGJcLYj3gibAvI+U=;
        b=f3pPMSfhJXeVqShqigNaaEUjkGEaVXU5y3oOifVj63Da4ZMoN2y9+is/esEQmgEIwM
         NBUeylqijkiF8NwgJwQ+ypvDNRfibM0x3f96OWgE4JX1TCigFawJtb+DCxy64agr1oOU
         /zl0xeSVGlq5In2O+tTLVw1Yu/fTXrvKz+RCIFsNWF7ySFYzp8Qd6UFURUf56cidIBOP
         HnfSJsG0KJZrF6PWnWMK+F+AjDPqhtpdfV0tGyYhn7/lImOnJOiojtSg6jyq0PZx+iDU
         q3X4JEnZfUg32BZEiiNn24Yga085qxqbZo9XkmHTpoA0VDsu61IVDf/AfTmQGESxo2wW
         yyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789252775; x=1789857575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOGMTD5LGSJ43nsYgDh0j1HHamIrGJcLYj3gibAvI+U=;
        b=QWN901nQ6O75kf93A+deLiTR9Cz8TeF7rUtkQRau1ImwDQJbtDWsc4ISz9LLFBp/sl
         KIqf4jzg1IcodmvCf75M92oPYJVf4CEM8yBQrTkRzSaO00GS9+Y5YxcE/qh4QMIWPnml
         gH7Keafcz4pNKKtRx3tTJ7W+Ssd9J/4JW9pLtBcR0fTeYI1UEQ54IrgJyOKMqWQg2oFa
         rbM7x/BG+5S3Nc9E8Q2itmQnuPHBRsxo0owHkEfHrJkEijSGNnLoqNR7lEog+778Lsst
         fG8ibRzBbRsfsnMyMnMA5BM6ddn7OKbEuVnGrdIlByedllq+WBlDVYSMTDmfQuF3LU2Y
         aGiA==
X-Gm-Message-State: AFuF++mVjAstTgGBNXlf+mhTE5DdFergQs1NVkb1hb6w7nAXNpMKJPGX
	sCkisfVrt8FLV2egNag1kCpyUn+eM5tvkOpaTyjmDsvHQ0z3VU9Hbxja
X-Gm-Gg: AYBFou0Ao8/UFXrYMXlgzXVZYJulsKYDoGN4GPDHk2PbKHxQ5V6ZvP5G1OZppiOm2wd
	hB/pMUBvob9Lqg0mfXtDiVk8sDM1rnKjJx77l62lt7erB4n7pD+V/DQVUaHsErFG8nHpbGomHKp
	d0iAMTCKi3H1LoqZPM4wohXikL1Dx6xgtdYgLFq+GDAmB9xogMHBQI9FlV4nEFDn9d9TU6EJfU4
	NwzlR9L/4xZ/aTvT0NJk9Z1izMKR7LlyO9ZqpY/M0mTuUbth3C0L3GmrL0VYToUTsS8sxtjsJ/b
	JrUny9KKPpcF4TuKDPfTBMfgUT9jUMjKui1bsK42LIie3zQI43TYIrDmHyKbLwima0SQibduHf9
	BXJJPdKDAWgfRHcrylkz7FxYsIEo2ONddPrgU+xz92Jyn3euWxtL5hD75DMi/7q59tKQdoNe+B9
	6WPANJeeo1fnaO4z962QmSVQ7OTp5jiP39AjPjXZf5617XORVLzQ+uDCxe6IJJbSyYGug1wNTso
	xVQatsrMjnGGUCjIzcWYTtMuU0T8d/U/EppmyZC6UXg400RbxE/5Za3B5VPiPKRvep3YpGeO8c4
	R6GDdhxOxwSqKdSYWP8=
X-Received: by 2002:a05:620a:17a5:b0:93a:12eb:b626 with SMTP id af79cd13be357-93a12ebd99dmr245498185a.4.1789252774908;
        Sat, 12 Sep 2026 15:39:34 -0700 (PDT)
Received: from docker-runner-pve5.tail732951.ts.net (bras-base-toroon4524w-grc-16-76-70-76-130.dsl.bell.ca. [76.70.76.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ebda519bsm537893485a.26.2026.09.12.15.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 15:39:34 -0700 (PDT)
From: Mykyta Bozhenko <caudadragonis@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: ubd: perform the flush the block layer asks for
Date: Sat, 12 Sep 2026 18:39:32 -0400
Message-ID: <20260912223932.2941631-1-caudadragonis@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260912_153937_088240_ADBF42E1 
X-CRM114-Status: GOOD (  21.31  )
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

ubd sets BLK_FEAT_WRITE_CACHE, so the block layer sends it REQ_OP_FLUSH
requests and, as Documentation/block/writeback_cache_control.rst puts it,
the driver "needs to handle them". do_io() does implement that: for
REQ_OP_FLUSH it calls os_sync_file() on the backing file and maps the
result back into the request.

That branch has been unreachable since commit fc6b6a872dcd ("um: ubd:
Submit all data segments atomically"), which replaced the single
per-request do_io() call with a loop over the request's data
descriptors:

	-			do_io((*io_req_buffer)[count]);
	+			for (i = 0; !req->error && i < req->desc_cnt; i++)
	+				do_io(req, &(req->io_desc[i]));

A flush carries no data and ubd_submit_request() sets desc_cnt to 0 for
it, so the loop body never runs. The request is handed back to the block
layer with error 0, i.e. the flush is reported as completed without the
backing file ever being synced. Guest fsync(), fdatasync() and journal
commits return success while the data is only in the host's page cache,
and because no ordering is enforced either, a host crash can leave the
image in a state the guest never allowed. The error path is dead too:
a failing host fdatasync() cannot be reported.

Measured on a UML guest with ext4 on ubda, doing 20 writes of 4 KiB each
followed by fdatasync(), then one fsync() and one directory fsync():

  before: the guest sees 22 successful flushes, /sys/block/ubda/stat
          reports 16 completed flush requests, and the UML process issues
          no fdatasync() on the image at all
  after:  the same workload results in 43 fdatasync() calls on the image

os_pwrite_file() is entered 131 times either way, and e2fsck on the
resulting image is clean in both cases.

Honouring the flush costs what the flush costs. With the image on host
ext4, 400 iterations of write() plus fdatasync() in the guest take 467 ms
before and 2007 ms after (medians of five runs). uretprobes on
os_sync_file() attribute 1.597 s of that difference to time spent inside
the host's fdatasync(), the remaining data path being unchanged
(os_pwrite_file(): 19246 calls in both). A 64 MiB sequential write
followed by a single fsync() goes from 278 ms to 362 ms, due to the
periodic journal commits. With the image on tmpfs there is no measurable
difference.

Users who prefer the previous speed to durability can disable the cache
per device:

  echo "write through" > /sys/block/ubda/queue/write_cache

That is also cheaper than the unfixed driver, 326 ms for the same 400
iterations, because the block layer then completes empty flush requests
without entering the driver at all.

Fixes: fc6b6a872dcd ("um: ubd: Submit all data segments atomically")
Cc: stable@vger.kernel.org
Assisted-by: LLM bpftrace
Signed-off-by: Mykyta Bozhenko <caudadragonis@gmail.com>
---
Not verified, stated explicitly as the process asks: the change was built and
exercised for ARCH=um only, on torvalds/master at cba2348ab and on v6.19; no
other architecture goes through this path. The flush error path, map_error() on
a failing host fdatasync(), is reachable again but I could not isolate it: the
block layer fault injection I used fails the data write too, so the EIO the
guest observes cannot be attributed to the flush alone.

The numbers above come from a single-CPU guest with 10 ms timer granularity,
which is why they are medians of five runs rather than percentages. Host side
counts are from uprobes on os_sync_file() and os_pwrite_file() and from the
sys_enter_fdatasync tracepoint filtered to the UML process; the guest side flush
count is field 11 of /sys/block/ubda/stat.
 arch/um/drivers/ubd_kern.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 20fc333..bb1d990 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1516,6 +1516,18 @@ void *io_thread(void *arg)
 			int i;
 
 			io_count++;
+
+			/*
+			 * A flush request carries no data descriptors, so the
+			 * loop below would never call do_io() for it and the
+			 * flush would be reported as completed without the
+			 * backing file ever being synced.
+			 */
+			if (req_op(req->req) == REQ_OP_FLUSH) {
+				do_io(req, NULL);
+				continue;
+			}
+
 			for (i = 0; !req->error && i < req->desc_cnt; i++)
 				do_io(req, &(req->io_desc[i]));
 
-- 
2.43.0


