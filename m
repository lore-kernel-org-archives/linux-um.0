Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568D6C5DF81
	for <linux-um@archiver.kernel.org>; Tue, 25 Aug 2026 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nhHoz17uhzvTdXS0vYq6oOhZqGXYkYOkqCoUJ92OGtQ=; b=NG+EI61xmHpxdxT2cm10+MnlbD
	7c6kbgraoRCvS4WbeZCiauIM2FyP7IDdmsbdn2ABcz/ulR/2DcRIW/HG00VnEVBPQol5FAMYpdKni
	uQztI17ryLSzhkRvWl2l/uR7zyFc3ampE8ZpT3Oj+P1FKL8TOaTPw0Hiq21wba3jFGDK05BSjR38S
	dYS+VDwNal2ZAF6PBtXwfO7ZvMYJj9VjrspAczkuBoHbGZzA1wuNCBtKnNfYg4JuLZ+uUBAwWMIl+
	2GkZlKmFK3uNtFoNiCXzDjT0mDB9C+6U88ShYkv+0Hwxe2gwMSDlJq2sDkflVbIRJ8W/USMh05VWC
	nLPddybQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wygSE-000000002AU-0hnz;
	Tue, 25 Aug 2026 01:59:58 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wygSA-0000000029r-1YYc
	for linux-um@lists.infradead.org;
	Tue, 25 Aug 2026 01:59:56 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c96c92c0980so2503588a12.3
        for <linux-um@lists.infradead.org>; Mon, 24 Aug 2026 18:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787623193; x=1788227993; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nhHoz17uhzvTdXS0vYq6oOhZqGXYkYOkqCoUJ92OGtQ=;
        b=Tlc4nsjWvMYamsRmckMmKTZX+l2RPUTxxAlKP6lk/fN/lxeqi6ZSViXskIBvGiYi/T
         VR62ez2o/3j/khzp4Mw6uiaWvO+6mPFiQoBNwn9QWbsFvAdL4DYRPnM4lFqa+ndG0igM
         9b9ShmEBGYmvHkn/2J+9cZfF3VixVpyZBt2nEPDChpKg38dQC9q4BKcOkmSyuR73aUO+
         s+4T41hvmYaApmK5PkFpifTWVAIajYzXes44cOxcbFjvkh7xdV27bPJqzyo3BpBCl1k2
         HkAts3Eb1kSz+dUMue3t0XD4l8KJj1gwCK9Qi1TYSx/MCXyzPDE2a+jv0cjDdnPu5kCZ
         0liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787623193; x=1788227993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nhHoz17uhzvTdXS0vYq6oOhZqGXYkYOkqCoUJ92OGtQ=;
        b=lBSQycKZqIxNr0QDn/OfrcQDxhILhooBF54lRfS4w67ruBq7kVPbuZFNC5Xxgy43WN
         vCCE8uDZdH+6s51ioV3Xaro0FphPr9f/N1N/4WChH/w+FI/1YfqDJ7oR79hPM3iTTCa5
         XzENqu0sXr3EdYGIq+Q/iApeLGTOTA6TRR6ywbw/4I9kzdOPAAohAf6ZwaqS7I7wRGLG
         IN0gjbcGM0c4AuCZIINJQCw/SxsMTLRCpKnWi3AkH2bbKR9G/N7jtS+CvkuB8i0g1M3n
         t00lGfNRWIbdTG794Vxk45mscAyKuQwV7avOoy3DOCp6Ymgc/C7mNWoCTx0F9XD6EAF/
         vniw==
X-Forwarded-Encrypted: i=1; AHgh+Rpqbizk9g8pt56jEf8LP71z7THQ02lygk8s+GJzZnrKmL/NyAMzJioNiDg3OvYS+mvqAO5WBL2KnQ==@lists.infradead.org
X-Gm-Message-State: AFuF++m0gBqIaRBy2XiRhg7z3jN6zTswYCr8j8QfzTpXrj36HmjKfZ8Z
	LUSuykEG6OeTu/hBsnIUu+dKpX579STQjzp28LXrmB3Oj++DOND+CD67
X-Gm-Gg: AR+sD1238sASB6RCe4zYQjYL4knVK+E0tEN1mfratO1uUUsU6Ff+tqxosO2VMLq1Oax
	Z7FBeinA7n8HKQ1UUnddJEgPpglEg0kcbzOE+PXvEgAZe8Z31kygZpGdZbYzz0nTsTjjdOvAw7B
	ydW6ppqBm9wGxHRJl4SKUEo3cHhW11U0nkp55Ok4vyaa6kePiDckF3dv4Qi+UT3OTfL0X6kHC7D
	aUAHYNgD4E+vmCVvaV0pkoUyIzip5/uJ9yu2+wjcGfVQ0XRaf5RpIbIba+7kNtDR96OtNB09M1M
	fgBTiPHjGFfbZ2OPeMdq2QDitq4d8XKXqv8QxNWiLt25Uwng+hX6Q1nFulW3b1TYa1N5tydabEy
	nTKbPL5ffgafwR99CfDQyn3F8fjaphMwZWfVNiSz8NXYskV62NPlbg03TpRN8JXx8TFN5LnaMFo
	DyuYy771ad0ZIyDEbDJH550xBYjMpwywY8waVpEZ2vsOmrYaxdKegeEsfHvYzC6tFtUgmDDG9VN
	K+K3q+x+MCB5z7ivmI7kFuufQba2YkJaKuQd0Fx5+e6hNGaJz58iODnE8iklDnklSSQRciPJj97
X-Received: by 2002:a17:90b:590b:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-396464ce7c7mr6288216a91.10.1787623193305;
        Mon, 24 Aug 2026 18:59:53 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b17eeasm1704829a91.3.2026.08.24.18.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 18:59:52 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 7A77515C677A; Tue, 25 Aug 2026 10:59:50 +0900 (JST)
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
Subject: [PATCH v2 0/2] support kselftest on nommu platform
Date: Tue, 25 Aug 2026 10:59:43 +0900
Message-ID: <20260825015945.141739-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_185954_437590_30EC0EFA 
X-CRM114-Status: GOOD (  15.24  )
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

We add an ability to execute kselftest on nommu platforms.

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

So, for the first step, nommu targets only support low-level API of
kselftests (kselftest.h), and implement tests in a new target,
TARGETS=mm/nommu.  Other targets are currently not even able to build
due to toolchain issues but will be addressed once the initial
introduction which mainly focuses on nommu test will be settled.

The patch was initially combined with other patches but is decoupled to
only focus on test framework and testcases.

- rfc:
https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/

Hajime Tazaki (2):
  selftests: run tests on nommu architecture
  selftests/mm: add nommu mmap and mremap behavior tests

 Documentation/dev-tools/kselftest.rst         |  14 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/kselftest/runner.sh   |   9 +-
 tools/testing/selftests/kselftest_harness.h   |   4 +
 tools/testing/selftests/lib.mk                |   8 +
 tools/testing/selftests/mm/nommu/Makefile     |   7 +
 .../selftests/mm/nommu/nommu_mmap_test.c      | 265 +++++++++++++
 .../selftests/mm/nommu/nommu_mremap_test.c    | 353 ++++++++++++++++++
 8 files changed, 659 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/mm/nommu/Makefile
 create mode 100644 tools/testing/selftests/mm/nommu/nommu_mmap_test.c
 create mode 100644 tools/testing/selftests/mm/nommu/nommu_mremap_test.c


base-commit: 55b50d965aee5f66cefe4dde3907a0e272f96b91
-- 
2.43.0


