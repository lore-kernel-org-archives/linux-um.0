Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02184CA0EDC
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/cuxRnTF/+sbokXrks651YRr5s4tLHJAN7bhV7Yv7fM=; b=Q/DPSpeVmM1uiBKt2XCeKYs/uM
	jqPc15HjBgTXal558yEGmOkyIg36ikqElMcIWGIXVW32sBOtAoDfg5WuJSN9wYPAzMTwSo+i0qW4a
	OY0ocQFG/mtrlXE4ksurbtHLPU51FMq5G+3mohnxvLdttkxOPqzI6HE6Qeov7kBz/D19d41tPLflY
	37rBizqXKg1N+9cKztBOzE1QDKe1SfGulcyfP0js7bbrxb3nzoL0smWdVk4Qh/+63rqgn04huR53B
	iQJ4E/PPHfmbB2Lzqvfsf0AgPRcHZjNPtZkkgoaCm6aFJoPS1LHJgQ1LOgBffHluBGSR7KGGV+211
	BQ1K3NIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulrtg-0000000BQ4F-1d78;
	Tue, 12 Aug 2025 16:30:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulolG-0000000AsS8-1jRx
	for linux-um@lists.infradead.org;
	Tue, 12 Aug 2025 13:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755004193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/cuxRnTF/+sbokXrks651YRr5s4tLHJAN7bhV7Yv7fM=;
	b=SjJeihN3NgtWBTcxs8cbe7k77kdZ6wWqlHMPPkOihptM+KVWOfSL6dArb+VDaYGzgcNObM
	EqXDci1fhQl3hj2qmI+rOy15V+8sMkj4r6k+It1/L1eCjtz8BBYhZDwL/WrriYBSZvWq0f
	UBMOHxjFfA0Y1V6ZuCMSQJCJKeRK/Mk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-SArAZdPZOtigwjx2dT9jhA-1; Tue,
 12 Aug 2025 09:09:49 -0400
X-MC-Unique: SArAZdPZOtigwjx2dT9jhA-1
X-Mimecast-MFC-AGG-ID: SArAZdPZOtigwjx2dT9jhA_1755004186
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87D20180036F;
	Tue, 12 Aug 2025 13:09:45 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BEA8195608F;
	Tue, 12 Aug 2025 13:09:36 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: snovitoll@gmail.com,
	ryabinin.a.a@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	chenhuacai@loongson.cn,
	davidgow@google.com,
	glider@google.com,
	dvyukov@google.com,
	alexghiti@rivosinc.com,
	kasan-dev@googlegroups.com,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	agordeev@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/4] mm/kasan: remove kasan_arch_is_ready()
Date: Tue, 12 Aug 2025 21:09:29 +0800
Message-ID: <20250812130933.71593-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_060954_520053_CFE138D0 
X-CRM114-Status: UNSURE (   8.04  )
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

These are made on top of below patchset in which all functional functions
will be skipped if kasan is disabled by checking kasan_enabled(). With
the changes, kasan_arch_is_ready() can be easily cleaned up to simplify
code.

[PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
https://lore.kernel.org/all/20250812124941.69508-1-bhe@redhat.com/T/#u

The 1st three patches are from Sabyrzhan Tasbolatov's patchset. After
clean up the kasan_arch_is_ready() definition in loongarch, power and UM, 
we can simply remove kasan_arch_is_ready() checking in mm/kasan since
all the checking has been covered by kasan_enabled().

[PATCH v6 0/2] kasan: unify kasan_enabled() and remove arch-specific implementations
https://lore.kernel.org/all/20250810125746.1105476-1-snovitoll@gmail.com/T/#u

Test:
======
I have tested the effect of this patchset on loongarch, power and UM.
Will try to find machine to do testing.

Baoquan He (1):
  mm/kasan: remove kasan_arch_is_ready()

Sabyrzhan Tasbolatov (3):
  arch/loongarch: remove kasan_arch_is_ready()
  arch/powerpc: remove kasan_arch_is_ready()
  arch/um: remove kasan_arch_is_ready()

 arch/loongarch/include/asm/kasan.h     |  7 -------
 arch/loongarch/mm/kasan_init.c         | 10 +++-------
 arch/powerpc/include/asm/kasan.h       | 13 -------------
 arch/powerpc/mm/kasan/init_book3s_64.c |  4 ----
 arch/um/include/asm/kasan.h            |  5 ++---
 arch/um/kernel/mem.c                   |  6 +++++-
 mm/kasan/common.c                      |  9 +++------
 mm/kasan/generic.c                     |  9 ---------
 mm/kasan/kasan.h                       |  6 ------
 mm/kasan/shadow.c                      | 18 ------------------
 10 files changed, 13 insertions(+), 74 deletions(-)

-- 
2.41.0


