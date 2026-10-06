Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99452CA5FF0
	for <linux-um@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QI6VWWfK9pDI+BJghbGgcQFx9nHMTF0rsPh7AoTup44=; b=PnuyzJ+3Q9N2MTiiuXzmNFkrpC
	zkbp4eV6oVRG9QtASY11CaMRznEW/pY33/sRIQOEuNIKzoIJlblAdi8M0QWduxlZwu4Bmsp/r3vQ5
	xmy2kr89GBj/Zi/JaTp7MAJDQ+n1bpLLa/dEyZHN638dzIt3DycvTQt2eJkbdUYbigiRjOH6T8oFG
	M0RbWwZqMpvz8m+bG0+Uonkkn1+qiZsobQ8GrQgL5ERNM9KLF9xggRrK0vCzGm2PElAt3Xwy4maHs
	JkFQk1l+MSKe+cUrKKFB8AqA67ybM5Ks078LVCaygWLvXsFXdJYITRWklNkf8yCUd7S3taQNt4Cle
	EnSyrOgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE0yk-00000000KJz-1OMS;
	Tue, 06 Oct 2026 08:56:54 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE0yh-00000000KJ6-0T6X
	for linux-um@lists.infradead.org;
	Tue, 06 Oct 2026 08:56:52 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so179145a91.0
        for <linux-um@lists.infradead.org>; Tue, 06 Oct 2026 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791277010; x=1791881810; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QI6VWWfK9pDI+BJghbGgcQFx9nHMTF0rsPh7AoTup44=;
        b=baKY43WTIk7fF3yFsByP5zR69MkOgpOx6MvoBBOMneUnEdQyoQaoF7/8Wp6xyatIJz
         SAJqFVOqOuP+VsIOgs55mme4BCcDuOrC0e41PpibeBhd3C9oE8loD6ccq9KUpzNtt4Ro
         MBSwsiaJH6uqhJXwPX5bajYhJPEuuusPCGPJFEzrJ7jJvj47upa849pH9/LE735Z7o3V
         dWFAA/pbPq27XnPlEe2VQ64BSWM8nIc99QISRNlhFyR4/g5rp5W3XgyvTcvfZlPlRePd
         jlC0RStFVB2SD9y8jpSiNFwF74h6mBQg/v96o4etufoWVXCqo6VUjUjfD3GR+f3IYukY
         C2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791277010; x=1791881810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QI6VWWfK9pDI+BJghbGgcQFx9nHMTF0rsPh7AoTup44=;
        b=m3VJI+A5/23e8XWL4tJSmDsRDxe6dVdI/JSR6+FUoLObzRtMjuJ1tqWA2AfANagCjc
         gBrDQvlzRyhkedRTZmaihTQL/jBzo0+WcO58B/4Mx4RQ2Q/kehaV+xIWMReUCG9k8HXq
         yuqjl+9oL2BYE/8mwzavIfseJRiXNO5N+vocJmqBghkSWIF20xpOSsa9Ltw+yHZXQvVI
         Sr6J5xkqyCQGm1T3EXECXL7s9WhDZdtVVcmOEJmzCyqXHHbnwParOslGq78randEnqaz
         lR/16lJBP50Vzaj2EPwDqd4OrRs4rLGi4bPuMs7tvtT/Fu5f1DkhvtOOZbC7WT0r1zfT
         xtPA==
X-Forwarded-Encrypted: i=1; AKwUvBxFwYVWPaU6PTml9bdVNVI1sDRVU+ds5G9VsyVE+QiLn2enHdXA8GZlRIxucLrNwIFw5fU6skwcJQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKTLlahXJCzdqtyg+68R+zfw70133qzYxvG11JsuS04V6HULB7H
	bO9SVM3DDhNTm2r2OxSpxGMgqGGCg7LmmO8DFNzhU6wP2E0KyC6Ctn4d
X-Gm-Gg: AYBFou19U6mlP/naR0UCYgd1+pKc/fzpGl9FXRoYfQ3rPuTYjrZwEj2JQaglKLrqeqe
	l3zg3BxSW4PSorMFttP68KV6zvSVouzWBscANw/S6ASITCp/d8YUKmLt9bKsl9jAZKppOKx3K6g
	Q5yAiF5ACjctUfHbCk0Yo8w+Da0YBS5x5DSTH/swXN8myaOXjlgBf6jIPG5WFu44n1jD1qO2iNN
	KUX6uxpAB2+xlNGpzdjjKsQlrIqWL7zBxzFZaTpejxbNvKE/fWxV7nDHAepyEjPt47UtEgLaN8Y
	536xLWorT4F/vWqnMbF3ojmbabc94VsAE8CmBSKyVL/dxjolddB6L4LBaCDJKMoWcCa6mp6UJRx
	ZJL+Ah10LlP40OfM512G5Sbns/+/EweCU7o1gRB0wONVf/m5xSr0B2/mLGIRiJWMRWapYwxxznq
	WTsjR3e1j9ACkZZqfRP+FS1tYLga+YfyEw/RKzCZf72+xmBebIg+WOe8o07WCYuXJhei/ymf9yj
	71xZoBtgaL5UPk1GPf0LQzv3+3rOuoSNY7sCvSj+aiht4O9aCID6Fj2mb3hAZ23tYQ7M1hsn9Zm
	WVjzfrZ1kzdcgRILlibApoIFi/blBfvLOBepaDtekwQGO4sdgZZZvKk1XUtH2A==
X-Received: by 2002:a17:90b:3c12:b0:3a4:c52e:8126 with SMTP id 98e67ed59e1d1-3a8736af0d8mr491188a91.40.1791277009678;
        Tue, 06 Oct 2026 01:56:49 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853d00fc5sm3931542a91.16.2026.10.06.01.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:56:49 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D975216FBFCF; Tue,  6 Oct 2026 17:56:47 +0900 (JST)
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
Subject: [PATCH v5 0/2] support kselftest on nommu platform
Date: Tue,  6 Oct 2026 17:56:40 +0900
Message-ID: <20261006085642.3852152-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_015651_158695_38D04102 
X-CRM114-Status: GOOD (  12.88  )
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

--

- v4:
https://lore.kernel.org/all/20260929235711.2287931-1-thehajime@gmail.com/
- v3:
https://lore.kernel.org/linux-mm/20260926010819.604346-1-thehajime@gmail.com/
- v2:
https://lore.kernel.org/linux-mm/20260825015945.141739-1-thehajime@gmail.com/
- rfc:
https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/

Hajime Tazaki (2):
  selftests: run tests on nommu architecture
  selftests/nommu: add nommu mmap and mremap behavior tests

 Documentation/dev-tools/kselftest.rst         |  18 +
 tools/testing/selftests/kselftest/runner.sh   |  11 +-
 tools/testing/selftests/nommu/Makefile        |   7 +
 tools/testing/selftests/nommu/nommu.h         |  33 ++
 .../testing/selftests/nommu/nommu_mmap_test.c | 264 +++++++++++++
 .../selftests/nommu/nommu_mremap_test.c       | 356 ++++++++++++++++++
 6 files changed, 688 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/nommu/Makefile
 create mode 100644 tools/testing/selftests/nommu/nommu.h
 create mode 100644 tools/testing/selftests/nommu/nommu_mmap_test.c
 create mode 100644 tools/testing/selftests/nommu/nommu_mremap_test.c


base-commit: e8d0f6a1b2a447d02845984fa6288787543cb03c
-- 
2.52.0


