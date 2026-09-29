Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F6ECA5FA5
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 23:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d2OlJ3pOFLYukF5tQBlnlNk14VTvFLw29xsc+/lj80E=; b=CRs+KZmK3yIbyJdkkicEZrkxMF
	CoH1Ju6/r3X8tX+YtLpWj5cSyugKOhc08JqJIjk7BWkNck+2F2KMClQQBYLlB0yT72hrXL4xyqePZ
	dunwi/8wLCvwLCHxQgb0fp8hVuzBs7C5krz3IdG/g0e7Goe3AzKFoRFqscgSfr1UHQBWQ5B7nlATP
	JFxsDH1jSA2YEFYOS/C1ldhTo+SSPy+I0iQMPCSbAxbl9CYCadlHVU2mTWC2f4LblQFIYCDSsosfx
	nt3nvqUGyOvnjc6AZbcuhdyMn8bfRrmUzN1I/4NxGkvsO5C4Ayu4aZeVpvTRC1jT9a8AsOUZK6J/+
	lga6J54g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBhhH-00000004mvx-0kAT;
	Tue, 29 Sep 2026 23:57:19 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBhhE-00000004mv8-0vpT
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 23:57:18 +0000
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so2081979a12.0
        for <linux-um@lists.infradead.org>; Tue, 29 Sep 2026 16:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790726235; x=1791331035; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d2OlJ3pOFLYukF5tQBlnlNk14VTvFLw29xsc+/lj80E=;
        b=nRL2f+FxVpurmmpGPAnE609ZyxYKuvOpLjM3Dk9XxnVu84aVATMMZIBtyQuE1Jg3DU
         kGY3OtWiHzCiRJQrJulYNAQUlv3ksyJ1EXkmZZ5pXv0mwMieHqUnNhsVLIH1xSWwM4Kr
         lpvcWCLFjtstPjsm+dYSqDJJWUrVimly/6t1lOMBTqaEDLDJkPt4BCadcYk7VeiAtpMg
         l5fENDMiF0zkWA084XZa8YeYmEWExDBu6x8dlEfZdPWdBkRhg3m7gZDFWyxdbaFtXNSa
         ZC70A1+/3W69eaRkg0CwhQLoNU/QFL1An1Rvnl9v/N8ZVKw0agoywrGeiZrdNhOE+MER
         p5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790726235; x=1791331035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2OlJ3pOFLYukF5tQBlnlNk14VTvFLw29xsc+/lj80E=;
        b=OufpDoRZp4jQ21G+FyIa27kwnyXpwYGTs9tlzHkBpXRa7IEzq1ldctkHGhOVgk3N80
         x1S/Te6oUsCaUxwbw5m+hgt9htqA8UcAMksr+xX4DSgUOwzEz7xBiQOuEGPwb5AaZFXu
         cREmbQxATRFazdji+QND8nM0VICZu/q7zl88ys9i1/2B6lzjIcwuYLvGhueZd4NzAQqT
         BTamEh7JKvKBtEayDu3OPkrMTynWv4+56MJZZ4hKzHnshxvP2GvBHoAa1NDetagAJ1Np
         0o7VdcNKG01ClxZ3cgK7GqQ6cPUbk70ZHfWuyMgwIxoYaPqPpxZLAK1qQUnEQoLEOMrQ
         CK2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwOlx8YWe9xTP0Fzl6RpNb1CtEK5jQvzaoZR01q6n3sBzkWKswndbJ/C/DGdi9DpwWnhJ15p15STA==@lists.infradead.org
X-Gm-Message-State: AFq9FYK0o+bBQDpJMc0Grzz990QHucQgKLt8gKQRgrwucwLC8FRyGR8q
	kQ+yVdAmb3qpnriE25TT7svFqt8iw6YJtFf3YvDN22waCp4TfY8uG8D6
X-Gm-Gg: AYBFou2g21zmfzF/n4NBF8HyPvedk2nFoFkPtXhdyN7PbCDAUqkVgotA4k7EKidomsZ
	sp+Ugu8WAldyewRhBYdom/+ZaXlT4ROdtlYplD5SCjfUBIBIbRe6EcAUhds5l7tZMauQI6/6zjy
	pB2a4GCvlok/vczRtmnfk7446/jz/UHDUUBz+GYUEG+hmyRY8FyNqtEnx7PAm6kHIdlegL4DYSq
	tydLxons0thJ7Z/Avc+/1iW5JvMm78gNbM/XTsb3CFelGoHYReNe3UzXIh61WHj0xVtdwVXkiGz
	Ak/SkDZZ1/FvEB153Yk0lrn+jgY5knNKaI7oVQHn8SYPqS7e+atOnT3i5OS6lwEYnKFYSpDCXkf
	nqrWSqndjZ3gMHnYCHVec2x+qTqTlhstq8o8QOqMf4ECR3skUn3ch8VfkaHvutfTNB2yib67u/Y
	VG8P/2G6isFXxnbyt1BI0DuqLDirQki7H8YBdLz02kk/w7j2mpLSGmzFESRfkGNrjxE4ptyRPvu
	IqUXeUnznHNmWuF2IWEakGl1mCWLc1IMFtG36Pd6RrrTxZcvP9Mk7kK0sFSOPUCqC6R/q/a0FEY
	li28sO2FVFE0199AWhxLsdw0hxEiGs7BSE9EdE53cUvNHv34l9VTFJxlTmez
X-Received: by 2002:a17:90b:1b03:b0:3a4:b50a:1113 with SMTP id 98e67ed59e1d1-3a4bfe8a0e8mr825389a91.37.1790726235201;
        Tue, 29 Sep 2026 16:57:15 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca78102csm242607a91.4.2026.09.29.16.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:57:14 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2360016DC6A0; Wed, 30 Sep 2026 08:57:13 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	david@kernel.org,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	ljs@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: geert@linux-m68k.org,
	daniel@thingy.jp,
	Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH v4 0/2] support kselftest on nommu platform
Date: Wed, 30 Sep 2026 08:57:09 +0900
Message-ID: <20260929235711.2287931-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_165716_265859_0A1E0044 
X-CRM114-Status: GOOD (  13.00  )
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

This patchset adds an ability to execute kselftest on nommu platforms.

Currently there are several issues if we wish to run kselftests on nommu
targets:

- it cannot compile/build test binaries because the current files mainly
  assume to build with glibc,
- some of the tests are not able to run on nommu targets as there are no
  fork(2) syscall.

The first issue can be avoided if we can build static PIE binaries (if
targets support it), but in our case (build on ubuntu/glibc and run on
alpine/musl-libc), it fails to invoke due to lack of the GNU ifunc
mechanism.  Thus, we need to cross-compile with musl toolchain, which
needs to be solved the first issue.

The second issue is the lack of fork(2) syscall on those platforms.
Especially the test harness helper (kselftest_harness.h) uses the
syscall, which cannot be simply with vfork(2).  `timeout` command used
in `runner.sh` never works for nommu platform as it uses fork(2).

nommu component in the mm subsystem has several known issues and having
test cases should help this situation, thus this patchset is very first
step toward enriching test environment which has not been well tested
for a while.  The test cases is implemented based on the document
(Documentation/admin-guide/mm/nommu-mmap.rst).

Initial shape for this patches is implemented as an opt-in TARGET, not
built/invoked automatically if users don't specify this nommu target.

- v3:
https://lore.kernel.org/linux-mm/20260926010819.604346-1-thehajime@gmail.com/
- v2:
https://lore.kernel.org/linux-mm/20260825015945.141739-1-thehajime@gmail.com/
- rfc:
https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/

Hajime Tazaki (2):
  selftests: run tests on nommu architecture
  selftests/nommu: add nommu mmap and mremap behavior tests

 Documentation/dev-tools/kselftest.rst         |  14 +
 tools/testing/selftests/kselftest/runner.sh   |   6 +-
 tools/testing/selftests/nommu/Makefile        |   8 +
 tools/testing/selftests/nommu/local.mk        |   7 +
 .../testing/selftests/nommu/nommu_mmap_test.c | 261 +++++++++++++
 .../selftests/nommu/nommu_mremap_test.c       | 366 ++++++++++++++++++
 6 files changed, 661 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/nommu/Makefile
 create mode 100644 tools/testing/selftests/nommu/local.mk
 create mode 100644 tools/testing/selftests/nommu/nommu_mmap_test.c
 create mode 100644 tools/testing/selftests/nommu/nommu_mremap_test.c


base-commit: e8d0f6a1b2a447d02845984fa6288787543cb03c
-- 
2.43.0


