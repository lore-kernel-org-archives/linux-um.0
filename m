Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936DAC61DB6
	for <linux-um@archiver.kernel.org>; Tue, 25 Aug 2026 02:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rXZ6arscy3bI1yYYXMDFd7SBEHMelfRFPGbyYXY2R+o=; b=XdwJYFx73hlarGPrz60CCXID/d
	sqTKDoH+oh2sMkgr5mUnhgO3sQc2t+8srYPJ8qBP4QHwTEwfja+WMG2QyxxNlLQ3k3xvt7vHOYx6M
	GoOtuylEncBzom+AQ/uqymkaOGVZvf84MOUUnGAA0QCtHBP4JogMXGMvrC+0uhVWZBsnqdwuOCY2b
	5kmwXZCzbvDO9jTZd3SSqV/inTJD6dmZ6Pjk6IHrXWEHGdAEj1oeNiRuVpKEAMhOENVHLEb5qK3Gg
	NdaYZQyR/udt4gMc4B6bafg0Avc1UkUVF4S1QTDL5JJRq1y75FdU/g6Auc9P2NBHqt0qkl2HI2dG/
	2jqUX/cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wygSG-000000002B6-372R;
	Tue, 25 Aug 2026 02:00:00 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wygSC-000000002A8-1SjE
	for linux-um@lists.infradead.org;
	Tue, 25 Aug 2026 01:59:59 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3964e480f76so323538a91.1
        for <linux-um@lists.infradead.org>; Mon, 24 Aug 2026 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787623195; x=1788227995; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXZ6arscy3bI1yYYXMDFd7SBEHMelfRFPGbyYXY2R+o=;
        b=NRg2ZmY2+5DAf0CptwywRfvF2kYT9Dyyv97Y6FAxukAN/Yh9LH1w/RKzlvpcIs8ff1
         fFWnz+dvyx18aPcG6kaonBi9fztFYgwM8IX7m24ijwrej2Wr9oqSTTNdnr0LLmxAp7NV
         kW4nG3DMnc4oy10F6ZYEwHarW4JGNMlGGQL6dIGsXo+bF7qKD/RvjDbQiy3VjHjF2ns5
         QD6jD2OvIlwQH76WBCJ50kK4IRe2NRsEfZt25fuEZbU04Qh4sXbZtVh94R7ye4pioZTI
         9LklXE8WpCOxliCQhQFzvdt77kymvDrjAy2Rvhtv4l9cJzXBK6UR6mUetXUPqWxUHG5I
         Ms4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787623195; x=1788227995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rXZ6arscy3bI1yYYXMDFd7SBEHMelfRFPGbyYXY2R+o=;
        b=f0FrGbFgWhIi8leFSn2ioObMKUqo0scCqbF7sk6Ey35nVwtaSPDwXqO3Vz2YtI8fsT
         Xs4EavOWA/BqUgr7qMZ1Qw350CWWfVfZE3njRGlILFdhvQRamTtNqua/PYfKsw2zpY90
         WraA8XFfgl+8APbnePZcXFAybMCaExRH9r+o/lWeYz5aVjqtoYCO/k5DZPGhG/L/DTmU
         YjeV6abPkbkUgi4xkml4//+gKxcw6RqatjRhbFE6gmCnPB1OQMR4hPrOrxT4w50Z/ygt
         BY8I0OOYmN1IiMqREt9PJKQYyu9gYoDtbR/Q0+1XoRb4oTGM7MtD6GPxdY8CPucm2d22
         Y25w==
X-Forwarded-Encrypted: i=1; AHgh+RruaE4PJ+W8DKKvB1ZtmfPwECm5lgqg3FETi3QN1FwqB/17ZMGWpJgdjAqzMkxB+7JjNd5CWa9gGQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nMgKGDdK0KEWOCLRwyFbkfv2pM3YocB6rVdNIcqDuTQiTxAINt
	VMLgEUHaLDxtFsa4aJ+M3pwSfLWZ6IuGknfvtChM/LSIMT9WpEy9qv/y
X-Gm-Gg: AR+sD10kKvfs62h1uchVrwfl+etDIOnOdlsfWyYzF2nwm8Ny8lFWeaF+zErENo1I2Oz
	P2Nd1LnYnIP6o3qFKpBgNvqIhLkQECTW7HgattNKME7dGCm/3kA5+SWt5+4/D0ruqRNKF0kYIk/
	jWmWapABglattuCLtEY/eTNex/yJSQOzDZq85TvpnpegGWPMwhJIo/A2R/wx1HEZXuXF+aB3/nN
	VevZUfZGgZCES6u53ZMPQGtx16Jl/45OwDYzPQK6bvo4y3qqgdoGtfAgL8yrVBbi/wVjInUZ+3L
	3NGLA0Gf/6+vKjtwn/APk2R7wmrzCrWBL5vfPEsTeMBUDDspqyOvT/WFPL2u+7/XUMSPqQ6pTPl
	4EaqrsV+89SClYuP71rdzaiRUrq1Zg+pz9MnQT65bgeQjOTiMzTpOIV3XHot3rru1LFqQqFMwVo
	g6yWhg5zOzySpCfFgjPWS5OLw+EIyAyqUGmabq9Rz/SXZ8plLvP7UzaM9QIPP4aqksQkcXL4uic
	FiGheVWOSuJIq2lzFRc6ARYKdfzcjK4VTbjd6W58AN1RP6O7Vn+cOTkl86KZrlAcAVu5A6jgGiK
X-Received: by 2002:a17:90b:56c8:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-3964652108bmr6382091a91.12.1787623195352;
        Mon, 24 Aug 2026 18:59:55 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b08ca0sm1725042a91.2.2026.08.24.18.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 18:59:54 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id A42B915C677C; Tue, 25 Aug 2026 10:59:53 +0900 (JST)
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
Subject: [PATCH v2 1/2] selftests: run tests on nommu architecture
Date: Tue, 25 Aug 2026 10:59:44 +0900
Message-ID: <20260825015945.141739-2-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825015945.141739-1-thehajime@gmail.com>
References: <20260825015945.141739-1-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_185956_395391_71F92F0B 
X-CRM114-Status: GOOD (  19.25  )
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
- kselftest_harness.h: skip the tests if the file is include when
  executing on NOMMU platform, as there is no fork(2) syscall.
- replace "cd -" use as it is not available a shell supported on nommu
  (e.g., busybox hush), use cd "$OLDDIR" instead.
- describe the difference of nommu tests in the document.

So command line to build/execute tests for nommu should be like below:

 $ make ARCH=um NOMMU=1 O=build kselftest-all TARGETS=mm/nommu
 $ make ARCH=um NOMMU=1 O=build kselftest-install TARGETS=mm/nommu
 $ NOMMU=1 ./build/kselftest/kselftest_install/run_kselftest.sh -p \
   -c mm/nommu

Cc: Shuah Khan <shuah@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/20260813063401.1786548-1-thehajime%40gmail.com
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

--

rfc => v2
- reformat ktap header, reported by Sashiko review

rfc: https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/
---
 Documentation/dev-tools/kselftest.rst       | 14 ++++++++++++++
 tools/testing/selftests/kselftest/runner.sh |  9 +++++++--
 tools/testing/selftests/kselftest_harness.h |  4 ++++
 tools/testing/selftests/lib.mk              |  8 ++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 64c0ec7428a2..a65f3ebc5906 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -230,6 +230,20 @@ section::
 
 .. _tar's auto-compress: https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
 
+Build and test on nommu target
+==============================
+
+If you (cross-)build kselftests for nommu targets, or run tests on nommu targets, use
+``NOMMU=1`` as a make variable/environment setting to tell build system to do the additional
+checks.  These nommu targets may differ in several ways, such as not supporting fork(2) or
+using musl or another libc.  Set this variable to apply the necessary build and test adjustments.
+
+::
+
+  $ make ARCH=um NOMMU=1 O=build kselftest-all TARGETS=mm/nommu  # <= build-only
+  $ make ARCH=um NOMMU=1 O=build kselftest-install TARGETS=mm/nommu
+  $ NOMMU=1 ./build/kselftest/kselftest_install/run_kselftest.sh -p -c mm/nommu
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
index 261e4df94d9d..0d05946a5e7a 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1274,6 +1274,10 @@ static int test_harness_run(int argc, char **argv)
 	unsigned int count = 0;
 	unsigned int pass_count = 0;
 
+#ifdef CONFIG_NOMMU
+	ksft_print_header();
+	ksft_exit_skip("kselftest harness requires fork(2), unavailable on NOMMU\n");
+#endif /* CONFIG_NOMMU */
 	ret = test_harness_argv_check(argc, argv);
 	if (ret != KSFT_PASS)
 		return ret;
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index f02cc8a2e4ae..fdb895967768 100644
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


