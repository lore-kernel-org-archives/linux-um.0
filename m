Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36B5C9833A
	for <linux-um@archiver.kernel.org>; Sat, 26 Sep 2026 01:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8o3YWWPI331T0WI+WVvTTsIk9M0avmYjoyCPD/hirYQ=; b=1uNQJwbmMeAwGEav6YUIVluKLI
	SRHghnMZd9AjX18PWU/6qD3qnoBv7Qp256gZit2H/zPvf9VXaPQf2Ga8V7UhgcSBRm5hg4jjQsR3e
	y41MteBe29uwDD2/l4aKdSrRc3gYpBTY0NXJl41b4w/fFhUrtpoali24me/UTjKXJdR9GXNV2No3t
	jyoM9rdJ5VKDnN0PKj4kjcQ+MARd2lkT3YgRySQuxg6deITGVEvJSSxFthGWnpU32Pl2jeIeknO2Q
	iBr6E8Ufyahhde3+1BCohCbUlFCa+O8wixutxidf6GibBCMR8vJx41zpm9IVraW2qp8MNEepRMN3k
	07Qow+3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGtx-0000000En7r-0E9x;
	Sat, 26 Sep 2026 01:08:29 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGtt-0000000En5j-28c8
	for linux-um@lists.infradead.org;
	Sat, 26 Sep 2026 01:08:27 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so936709a91.3
        for <linux-um@lists.infradead.org>; Fri, 25 Sep 2026 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790384904; x=1790989704; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8o3YWWPI331T0WI+WVvTTsIk9M0avmYjoyCPD/hirYQ=;
        b=i/NO0Pk8uFe8IZMB72IHC2CFNdEQ6TeWdtUe5y7RTtG6mmqWJaQTFjHioD4lnJ/q3l
         iQe1oqZ7jQ6PeAFXV08qRIiXsuW0AjBKh18YNG1QlFViv3eIOiLq8d1mQKKXQZa/3xQ2
         BpgxfcNW0kNn+yjcDuwC+b0+TjtyrSkgLNy5PhWvT7hhmLbJt2htEUK255SmlYZ5InUA
         6SVLUI/ZjbO5rqX8eeKiJ7yf9yi3iVp6OvllKlUlzRGTiBeogjqs9voXGDYssrkTG+Ax
         7umUotT+RhLyKTqb38f3/afYONmxmkGek2gMI01g3sixGBk4BJMylE2y+ebUD/vNjfcS
         jGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790384904; x=1790989704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8o3YWWPI331T0WI+WVvTTsIk9M0avmYjoyCPD/hirYQ=;
        b=ColDzO3LvJln65xCdKdRBEtQ4RmGQXJsZzAKB/TbSHlOpDclcUHuOnP6Ie6J/EvdDQ
         uj9uYnNCv9CptI2E4tOf9PYh7kYtZ7y7OYl28G+1EXXVeQUPDb77I3A2JshYnF0pMhKH
         wFeRhv1mZ/gxuxygQzmptqSmZ/Dbe6kjgaZpLuKwGCRqtDvuDpTWCiSkoqUOKAUMrVM+
         qU0pgP+78T6vlHZx2m1uzjh407eUP91fOPJFtWocjJavixy+7dtD8U/s9YDswTE7D6px
         vo4+A0SS43GpQ00D1Xbwcys976d4KYg8naijZkQtQf68TkM9x2OPgRQjU/Zxo3XZ5mNR
         mWHA==
X-Forwarded-Encrypted: i=1; AKwUvBwjh3D9gbuGWzrA6O2835wPOq52fsd8VQGBW4tqN6WLltMieZwAh3JfLtV1Rg0vkmyqJCh2FR9sjA==@lists.infradead.org
X-Gm-Message-State: AFuF++kqWXGO1/PEisknDvjWs+vOSBCwDedl9M0ffWBHC864EEYiDU6d
	FUZq/E6aSw1Qi+HlrM1EGTxu/oB2yeZkSW10D9Vv+hBgW/vbJ/NI5ZPU
X-Gm-Gg: AYBFou1KewIyqPysjXoVsCJpGkMoHIMukVZbaTOq9uPR4M/g1J2MT3qndIaTujTNg3p
	WHZmDIXFJ9cTN/0dMXV9aOC31o0GUJTmdfkM0TbNEZ+UtvRPNcPs/wN4GGox83CcAjmweo+K+al
	3VQjcGIl3V5Xnv2QSdBPmAaYwgO2N1ZdHlWqQgNzetw1Iczg20TRL+qzmwasvNVwUbDaALuj4ab
	VtjdvRUY9vtpACtse5ksY23K8iTHRhZOzvXLJn9YCK8K9LDV7L2ff0Js6w+0k2lrYkvCzlk90z9
	VqsYy9dlRBj5yhbTROpFVPzVV9lXdkQfoGc+YxYx5zOez4ezLRg25ICIKn0/ZWZYpPjnynteDoo
	9LA3/pbN7h14mf7eykMXnByXvkS4QcyumXpHGPF3aLVas9r69GhF9cB48/13jMY+1193PcEI1tn
	i/32wRS2UiDS6RrZnbA/3SgxFzw3gVQhd/5OnrNkhwEfrOX0EcYyJUROAe8JfVLcdaOow2uVw6W
	AUMvyWr/Fe18ziuTDE+3g64qlvX9VHlyekF/h4JbQtSJ2rt89ThPGjMoeCV8+qAh9ivlj2dLP4N
	nBkKdVbAyWhPIfsznm19X6z/4nKolOaejsUg5UX7zCQ6cXEXS6MlhQYHaIxT
X-Received: by 2002:a17:90b:2604:b0:3a0:d9ee:a2e9 with SMTP id 98e67ed59e1d1-3a0d9eeb955mr765639a91.45.1790384904050;
        Fri, 25 Sep 2026 18:08:24 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm7032117a91.6.2026.09.25.18.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:08:23 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5950016C9C94; Sat, 26 Sep 2026 10:08:21 +0900 (JST)
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
Subject: [PATCH v3 0/3] support kselftest on nommu platform
Date: Sat, 26 Sep 2026 10:08:16 +0900
Message-ID: <20260926010819.604346-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_180825_550692_B47C0E78 
X-CRM114-Status: GOOD (  12.98  )
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

- v2:
https://lore.kernel.org/linux-mm/20260825015945.141739-1-thehajime@gmail.com/
- rfc:
https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/

Hajime Tazaki (3):
  selftests: kselftest: avoid cd - in runner
  selftests: run tests on nommu architecture
  selftests/nommu: add nommu mmap and mremap behavior tests

 Documentation/dev-tools/kselftest.rst         |  14 +
 tools/testing/selftests/kselftest/runner.sh   |   9 +-
 tools/testing/selftests/nommu/Makefile        |   8 +
 tools/testing/selftests/nommu/local.mk        |   7 +
 .../testing/selftests/nommu/nommu_mmap_test.c | 258 +++++++++++++
 .../selftests/nommu/nommu_mremap_test.c       | 362 ++++++++++++++++++
 6 files changed, 656 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/nommu/Makefile
 create mode 100644 tools/testing/selftests/nommu/local.mk
 create mode 100644 tools/testing/selftests/nommu/nommu_mmap_test.c
 create mode 100644 tools/testing/selftests/nommu/nommu_mremap_test.c


base-commit: e8d0f6a1b2a447d02845984fa6288787543cb03c
-- 
2.43.0


