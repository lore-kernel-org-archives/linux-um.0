Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC67C5DF65
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70ar5JlTr4siaYWARGHSNLurtbvgFrnTr20To12QjOE=; b=zpkAF3BlXsG7+CPIAtRD+dh5Z7
	FMPd+LXnWrr/FQUHDBeOgsHd4CwT5ZMJFPpK7E5FAoJ1+/YONvWtO4n3lt9UN2L30brhhE08l44qT
	aF8QyLtXwJPuu0SypGkbprc8YatnI1iOPonGnQs6ktBlLZoDUxVPnpJz3NBTbhYGcBP2rBNCTM0fA
	m/bC0yj3HYeD9SDlg3imN0jiWa0SDPR5m0aOQzNJdDR3auc12pkDlrxvuGIui4CZ+s7rWphVyNdlr
	iGuWPjQTiZPBOe7xTay/2M2l9LC1+Q/kJmSplrHKJAcAUl4dcSU/n5csbghAuPBglEUgoB0zI5fVA
	/CwN+RiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuP1A-0000000HUB0-1rnx;
	Thu, 13 Aug 2026 06:34:20 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuP14-0000000HU8p-3FNd
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 06:34:18 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so2019939b3a.3
        for <linux-um@lists.infradead.org>; Wed, 12 Aug 2026 23:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786602854; x=1787207654; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70ar5JlTr4siaYWARGHSNLurtbvgFrnTr20To12QjOE=;
        b=AJifwrQwqG23ogUSVNnORSbw9q2YX3M28zMTbjooIcXYJkOr30FfcSag5e5EPrgDFk
         EJXfTe7d/I+WnOTNq9Sur2qSdfmlwQkxz0afC/yXtUtqrT+r+mXibF9f6j0oglexBZUA
         7jSohgyzkJ7Bdzpiqiv81GZhY0k9Ia0PSJqONXrCgqDQ8aPPgG5apW8ERaJG2bGgyywk
         o/juNYmYH+Jm6uPGRfiQlBtsjOn/s4ZHCXK3FCxdhilhbrZTSE3BnogYKh81xcTQYzQ/
         GzH97NalpoTtPYcwrl9iq0AwX/y5kz6ykROYmUbQD/DmW2KWvvDWPxQ/uG2EFbk4LcA/
         rVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786602854; x=1787207654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=70ar5JlTr4siaYWARGHSNLurtbvgFrnTr20To12QjOE=;
        b=VMw4Y2+KMudTjNK3wzxYEqcqJAI3u5iRb0PEbnAUzV0sXxjZPvcsseif/8WiRERPJE
         N+ieE7Q7dKOVMHmntso5rHPMSOdAyJiB7YkH4iD/AqFYIRVKjRiorPZEHIVMDuNVuVRI
         v9JKeREUAjpHx9N5XARnkRWt2DtJVSSyDqhvs2cKaOCSSwXnF/VtcmcXl6klnZw8NUVn
         0OYbwlEW1X+o0rI4DFLjW1BT0BMk+jsRMW+rncSJtrsk2vmiFk7Xp38Ri4wn6gInt32p
         01rLFdcykZ6X5/kdFuUmLh169VAv5yY+tprbxeuce30iT9KzV9ehDb+EW8g09+ldUi13
         dD7w==
X-Forwarded-Encrypted: i=1; AHgh+RrHSEhx4KIbUflYX8iaEyxjRZSmjfQjjI7LDtOWlaquFZd5g+1p7u5W97xWp36pGj2VcQM6osqXeA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywenilg9bRjNcjmItnKpUHkxDy3a9oRUL8/07mDfPPHtqUJSEBv
	Mv8v0ItBpnWW15o7LPKCRmK2Kl0MmN4gJnz9qmeNZm6ivpbmLQ1YY602
X-Gm-Gg: AR+sD138qRpCSgWQwWhVbCiccixD5mjr3affwHzfCKqG0evAUltOuc6Sl6EK4SqSEJw
	r5DNz7FNmHQibzELtQNdBQT6Giw2pslN2/2Rh9MqPcNKDdFCvQ29h0/fWwGFhG15jR5Vas8WoXu
	uOvJXhHv3M7AuymCeTRDOrivaA/3z3wPCVcunsFRq0ZdFeUucQfoWZykY4EPBq2aIbNCQ9VEAf4
	gAKLPLnFTV4y6+/RgvjXuWY0dKBiiA2Lfw9abXJQqoLd4zwECCBmOyi3Gzu4De/I2QyhvQzAnnb
	3IHZhx6IEZj4BoTGMCX9foc/Zu2dpz1qqV0JYVQ4iwTrFfyPxfUWekF8GVlZ6esNdJmrpdNo21a
	WBrL2tZWdZKdzj9qIxjhSlOVqvHD/I6W1Y3STgoToBgtueDNkWFok9YTJa5Gdonfqb1lAGk7CZg
	yn3mWd4KrBOJn4YUXgzWpyu6K5PF2yURUG+MzptGTCwgPZn7vq6EUWQANmNiMiHsNqaGgCZ48tQ
	Hs2AqnrRJIfU2XLyBrvPLWHW2TtifAB0S3kOS097/GrsQB7c3VbewLg8TeyyG7EcA==
X-Received: by 2002:a05:6a00:e10:b0:84e:1a9d:d879 with SMTP id d2e1a72fcca58-84fc760d2b4mr3746110b3a.28.1786602853695;
        Wed, 12 Aug 2026 23:34:13 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbef710cc24sm493765a12.20.2026.08.12.23.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 23:34:13 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 24DD715B0433; Thu, 13 Aug 2026 15:34:11 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-mm@kvack.org
Cc: geert@linux-m68k.org,
	daniel@thingy.jp,
	Hajime Tazaki <thehajime@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	"Ricardo B. Marliere" <rbm@suse.com>,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [RFC PATCH 5/6] selftests: run tests on nommu architecture
Date: Thu, 13 Aug 2026 15:34:00 +0900
Message-ID: <20260813063401.1786548-6-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813063401.1786548-1-thehajime@gmail.com>
References: <20260813063401.1786548-1-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_233414_844041_B806B76D 
X-CRM114-Status: GOOD (  18.94  )
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

Architectures lacks MMU doesn't support fork(2) syscall and only
vfork(2) is available with limitations.  Thus, we cannot run kselftest
on nommu architecture as is.

This commit addresses this issue with the following changes:

- on build stage, add -DCONFIG_NOMMU to CFLAGS when NOMMU=1 variable
  added to the build/make argument.
- on test run stage, avoid calling timeout command when NOMMU=1 variable
  added to environmental variable, since timeout command uses fork
  syscall which nommu platform doesn't support.
- kselftest_harness.h warns if the file is include when building for
  NOMMU platform, as there is no fork(2) syscall.
- replace "cd -" use as it is not available a shell supported on nommu
  (e.g., busybox hush), use cd "$OLDDIR" instead.
- describe the difference of nommu tests in the document.

So command line to build/execute tests for nommu should be like below:

 $ make ARCH=um NOMMU=1 O=build kselftest
 $ make ARCH=um NOMMU=1 -C tools/testing/selftests/mm run_tests
 $ NOMMU=1 /tmp/kselftest_install/run_kselftest.sh -s -c mm

Cc: Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-um@lists.infradead.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 Documentation/dev-tools/kselftest.rst       | 12 ++++++++++++
 tools/testing/selftests/kselftest/runner.sh |  9 +++++++--
 tools/testing/selftests/kselftest_harness.h |  4 ++++
 tools/testing/selftests/lib.mk              |  8 ++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 64c0ec7428a2..800b2b688aff 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -230,6 +230,18 @@ section::
 
 .. _tar's auto-compress: https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
 
+Build and test on nommu target
+==============================
+
+If you (cross-)build kselftests for nommu targets, or run tests on nommu targets, use
+``NOMMU=1`` as a make variable/environment setting to tell build system to do the additional
+checks.  These nommu targets may differ in several ways, such as not supporting fork(2) or
+using musl or another libc.  Set this variable to apply the necessary build and test adjustments.
+
+  $ make ARCH=um NOMMU=1 O=build kselftest
+  $ make ARCH=um NOMMU=1 -C tools/testing/selftests/mm run_tests
+  $ NOMMU=1 /tmp/kselftest_install/run_kselftest.sh -s -c mm
+
 Contributing new tests
 ======================
 
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 311811dc55a0..7287d8290b6c 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -38,8 +38,12 @@ tap_prefix()
 
 tap_timeout()
 {
+	# nommu doesn't support timeout command (missing fork(2))
+	if [ "$NOMMU" = "1" ] ; then
+		echo "timeout isn't supported for nommu"
+		$1
 	# Make sure tests will time out if utility is available.
-	if [ -x /usr/bin/timeout ] ; then
+	elif [ -x /usr/bin/timeout ] ; then
 		/usr/bin/timeout --foreground "$kselftest_timeout" \
 			/usr/bin/timeout "$kselftest_timeout" $1
 	else
@@ -130,6 +134,7 @@ run_one()
 				return $KSFT_FAIL
 			fi
 		fi
+		OLDDIR=$(pwd)
 		cd `dirname $TEST` > /dev/null
 		(((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
@@ -147,7 +152,7 @@ run_one()
 		*)
 			ktap_test_fail "$TEST_HDR_MSG # exit=$rc";;
 		esac
-		cd - >/dev/null
+		cd "$OLDDIR" >/dev/null
 	fi
 
 	return $rc
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 261e4df94d9d..8eee7b14f824 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1274,6 +1274,10 @@ static int test_harness_run(int argc, char **argv)
 	unsigned int count = 0;
 	unsigned int pass_count = 0;
 
+#ifdef CONFIG_NOMMU
+	ksft_print_msg("harness test doesn't support on NOMMU architecture (no fork(2)).\n");
+	return KSFT_SKIP;
+#endif /* CONFIG_NOMMU */
 	ret = test_harness_argv_check(argc, argv);
 	if (ret != KSFT_PASS)
 		return ret;
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2cc819006424..4734b5ce613f 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -97,6 +97,14 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+# detect if users request NOMMU build or not
+# User can set NOMMU to 1 to build/test for NOMMU platforms
+NOMMU ?= 0
+ifeq ($(NOMMU),1)
+CFLAGS += -DCONFIG_NOMMU
+export NOMMU
+endif
+
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
 	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
 
-- 
2.43.0


