Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416F9EFD20A
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oV6MOc6IZ/eQSfEt7lDYf3QV1I2fYi7uzloZcjfdDk8=; b=Uhb2B6pKgxOHBy1pfTCFi6kNDC
	M8prntKiEj408WaF9UmpepqAokz7APwfAiUwtzzQcaab5LLTwKMfli2sytfe0M7KPaNfN05PWnglS
	pyVX+5dP0CkEOImOH9IhrCSeQ0pf1qLESbwNUjagrjOgBtUDoW9wLsTHQFH7JEEb5F/FqIam/aoVb
	LsbEI27ZHN7sRWdTqsZp5vesv//tQppEb+zkPILxo3zP7nxH4HXe3HauNqGqRt9Wl4x8OwDut7WAf
	szMRH741lcUJMWolrXZHHiSGbMJbpa5m27xsZkF4wf8jYmVTy8SX8v9Hc6BGQsIFsVm2sQN5hrbTr
	nGGjt2Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA5S-00000003WvF-47sm;
	Wed, 25 Feb 2026 08:17:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA5N-00000003Wpb-0aGv
	for linux-um@bombadil.infradead.org;
	Wed, 25 Feb 2026 08:17:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=oV6MOc6IZ/eQSfEt7lDYf3QV1I2fYi7uzloZcjfdDk8=; b=QjpLLwvJ05UIAPduOy9AXLiK8O
	jbVtnBCu8OYOT5IjjYnfUQZ/4dZrccttok8qNmI2V53hCv+STREcdT/XED7ENe/KFf/0MfB0rfybW
	6Y/EQP2oOLP2xDUpvhqfe/8dbgGFKAfpgktryrl59dZp6uZMGboSL0ukRiRGniNY37XR0lK5CqFdK
	WBzj9Be04eTAfqrxG9Ddjyqkso4X2KVVE14jqEz6yCsne+rB4Suirk00Q1PQUVXAPe7zLMsSbxLtS
	P4iL6qDFBG9u7URyGMgSU6DYKclhcrhrWYQ2HTqVFXYQN89QqJOtTinEI6zzBFjiVhIW6OzsVNBKu
	sQc59qZQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA5J-00000000jnt-33hY
	for linux-um@lists.infradead.org;
	Wed, 25 Feb 2026 08:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oV6MOc6IZ/eQSfEt7lDYf3QV1I2fYi7uzloZcjfdDk8=;
	b=d3JfQ+c3+lldzn9ScmBDAWZ9uIa2G+IAwtt/a4lQCyTMxf/lxJjhc65IWui+rUTATS/ZE8
	x4Flh4+DWJhg6SXrVP2r8DWCuNkwdJUw7hj4Cfv3J3Qux8i4DCQE3M038ub7ehXyAHlaDQ
	DknndRLRXCi/gY+RtjuqKmHDk3VwlPA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oV6MOc6IZ/eQSfEt7lDYf3QV1I2fYi7uzloZcjfdDk8=;
	b=d3JfQ+c3+lldzn9ScmBDAWZ9uIa2G+IAwtt/a4lQCyTMxf/lxJjhc65IWui+rUTATS/ZE8
	x4Flh4+DWJhg6SXrVP2r8DWCuNkwdJUw7hj4Cfv3J3Qux8i4DCQE3M038ub7ehXyAHlaDQ
	DknndRLRXCi/gY+RtjuqKmHDk3VwlPA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oV6MOc6IZ/eQSfEt7lDYf3QV1I2fYi7uzloZcjfdDk8=;
	b=d3JfQ+c3+lldzn9ScmBDAWZ9uIa2G+IAwtt/a4lQCyTMxf/lxJjhc65IWui+rUTATS/ZE8
	x4Flh4+DWJhg6SXrVP2r8DWCuNkwdJUw7hj4Cfv3J3Qux8i4DCQE3M038ub7ehXyAHlaDQ
	DknndRLRXCi/gY+RtjuqKmHDk3VwlPA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-d1eK6WOzOV6_MuYcbjoUdg-1; Wed,
 25 Feb 2026 03:17:22 -0500
X-MC-Unique: d1eK6WOzOV6_MuYcbjoUdg-1
X-Mimecast-MFC-AGG-ID: d1eK6WOzOV6_MuYcbjoUdg_1772007439
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33B381955E8C;
	Wed, 25 Feb 2026 08:17:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 657C01800465;
	Wed, 25 Feb 2026 08:17:04 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 15/15] mm/kasan: clean up unneeded ARCH_DEFER_KASAN and kasan_arch_is_ready
Date: Wed, 25 Feb 2026 16:14:12 +0800
Message-ID: <20260225081412.76502-16-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: wY2Szb50BnEnuJnIVHe8jPS7PssV3cRL1u-yH-t-7Bc_1772007439
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_081729_875052_81B6718F 
X-CRM114-Status: UNSURE (   9.60  )
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

Since commit 1e338f4d99e6 ("kasan: introduce ARCH_DEFER_KASAN and unify
static key across modes"), kasan_arch_is_ready() has been dead code.
And up to now, ARCH_DEFER_KASAN is useless too because of code change
for 'kasan=on|off'.

Here clean them up.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/loongarch/Kconfig |  1 -
 arch/powerpc/Kconfig   |  1 -
 arch/um/Kconfig        |  1 -
 lib/Kconfig.kasan      | 12 ------------
 mm/kasan/kasan.h       |  6 ------
 5 files changed, 21 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d211c6572b0a..4b7802d02911 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -9,7 +9,6 @@ config LOONGARCH
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
-	select ARCH_NEEDS_DEFER_KASAN
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ad7a2fe63a2a..b51fbc25bdc9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -122,7 +122,6 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
-	select ARCH_NEEDS_DEFER_KASAN		if PPC_RADIX_MMU
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 098cda44db22..fd0bedd2c696 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,7 +6,6 @@ config UML
 	bool
 	default y
 	select ARCH_DISABLE_KASAN_INLINE if STATIC_LINK
-	select ARCH_NEEDS_DEFER_KASAN if STATIC_LINK
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_FINALIZE_INIT
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index a4bb610a7a6f..f82889a830fa 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -19,18 +19,6 @@ config ARCH_DISABLE_KASAN_INLINE
 	  Disables both inline and stack instrumentation. Selected by
 	  architectures that do not support these instrumentation types.
 
-config ARCH_NEEDS_DEFER_KASAN
-	bool
-
-config ARCH_DEFER_KASAN
-	def_bool y
-	depends on KASAN && ARCH_NEEDS_DEFER_KASAN
-	help
-	  Architectures should select this if they need to defer KASAN
-	  initialization until shadow memory is properly set up. This
-	  enables runtime control via static keys. Otherwise, KASAN uses
-	  compile-time constants for better performance.
-
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fc9169a54766..f08f7f75c285 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -552,12 +552,6 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
-#ifndef kasan_arch_is_ready
-static inline bool kasan_arch_is_ready(void)	{ return true; }
-#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
-#error kasan_arch_is_ready only works in KASAN generic outline mode!
-#endif
-
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_kunit_test_suite_start(void);
-- 
2.52.0


