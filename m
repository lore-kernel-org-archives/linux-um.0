Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FA2CA5FB1
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 23:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jFwQ7bBmiDvOjFgxrjCdqBVWt11ayQv2mN1CYnb1whI=; b=DY10/V4OXDE5f/zKvQJLUHHAgc
	nqiMzW/lxHQCorDQ0mnBGZTJlrrTTGJzlOQ3vuUFLsMQrQq6GGI6TkEkQprhZZbG557oRt1ai1TBD
	OhMxcUFkjOMcxIDM+6kIVGZEfvgewQ4uY1TtGBgOKgeIal+aYMwLnNYn+Txp+LvD78ZIli5Abvhql
	l3NdOvbokTS56d87Kdpn1nISa8z3JltxXgfgGVPJ8xBLw895lpCmz6+jsjCKcjOSdZrvqmuMOD0zr
	FapKifKXSfmfwz2iaGmIKQC8ltBa2eQiBUAIAdWJBI9NC0dWPwf3ATashMN2dNyKxAuxpGKk6RwV7
	dlUiMiNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBhhJ-00000004mwU-0wYj;
	Tue, 29 Sep 2026 23:57:21 +0000
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBhhF-00000004mvM-0inQ
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 23:57:19 +0000
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so1493119a91.0
        for <linux-um@lists.infradead.org>; Tue, 29 Sep 2026 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790726236; x=1791331036; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jFwQ7bBmiDvOjFgxrjCdqBVWt11ayQv2mN1CYnb1whI=;
        b=MDjEeb6H9aPZ2hWBS+raApQ3vS8EP1dAnjKVULelT50GcDyalYsTMAVJsPkswGCAZL
         D05WuuYwgIt2eQCX/RNXGmJp/0ByXtBNsUVsvOlowRO0wpZaEsuACGfbOvLG9PDpur8v
         SoU7OvB0/Pse2i9GjR1WyXHs8cmtrOjBa81Lpz7rq/guPvHnBXYUinPvPvkowF7CR4kO
         E1UHQ2OYnK8jQFx5P0S2UgUVSTfRpPGcm+dxa+wC1rBWlWWuLHJsd3AmAj5m/sqiRHhA
         tCg3rKdVNs8SscP2fOB3NgaTrW6O6E9kIcMyKsnk6RfzbqpnQG/59SvVUgZYQSz1aEQ+
         AEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790726236; x=1791331036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jFwQ7bBmiDvOjFgxrjCdqBVWt11ayQv2mN1CYnb1whI=;
        b=TD3uKJXHrL2Nyd5QilBMd8f7AGocW8RnGZUw+1SDZypMiCDEhmAf+EEHuxGp0G+eEu
         5ZtmhEVBYPAKpAkFuhX8XFlVqzzCMR9xzmVIdN+Ba9/mSwtK/K2hZxethddoHk6ELi/Y
         f3npSqM5SUBDoooL7m2NF4VgpNmqgDjtiKx58HfCIgR3IWrPf0MlrlcXY6HMTi79KulU
         4pA5CJiFWZSOqKmRPSN4sO3Y7oy8e1VHqSX2784sy9iE+dvuoB0n7PiQMcXTXBbfQE1g
         ymhISHsZlBSczS1aaVmCbnfsOmWiIUhlgKGAYmc5qfh5skoYKV10udhA0LdEGcQ0VkBi
         8aqw==
X-Forwarded-Encrypted: i=1; AKwUvBzQiA1/V+sMetGrojGA6ifxiOr1Y5wsLwFb2YlQaTE9gBLbqu4sKEiYoBBgoOHNOb/K2YTGaGsFUQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKUPv+JvbwCXvLBcLX3er/YF9dL/hkyGGEV9izMlu/DM0VirvGW
	ezZzbPP1VWnUiGWCMuSwhSbJLxsDpT7bI8ib3IlyI0RLBqXCGzwnBA6X
X-Gm-Gg: AYBFou0Ljqeu9jKgUlZbZjSEYx88LtPG75o9NYMGPeGgCzrkt4feYtjcVeOBNsqZmY8
	FvEz+o86CyekMVC775+k973Wockqrwr5LApnEmlrcE0DFRShYGLx1Dra2/YKsepWkbrepjMlFYY
	is4zX6OmjXt3hv8ySl4Ekdld1RtlkXjiuWtnVdkGbT02B2fLAoggFH7hhc6jH/nNEbBHes8IUVu
	JNHSqz3XtpODSlEI9PrXSGbSLnc9N7QcYdAlzmijmUTnSsJlQj/pMV6gfkbL3GhK5YMJFu1dBtF
	LFvJI6iIa3uDiTRlfhPaCHRTPWVKHOyBTy77VPHWvIvggg6YLl9v3iFT6zTPBydxvSXcRxOel8f
	zlx+xg/93TVJAAd1/vsj5Fl+ANufcOaVjgThZyCkzpdpDJdIasKIagN6x/OGs9FZocfjsxQ2YBz
	LP7apYy3QNZLovYU3rQpiZ3or5MKJbLq3pTZnfB9iSWzOhiV6+f/trhgZKVFAbq4kCk42djhVvu
	STxTGSY3mHXUdQk6GsX+tQctcK06cfanXtI/X+hzxCPkpoq+guuDAc69flcHrfZAud+l8HKyk1T
	Hx4LM+Z9pct4wZiS/MRj7zIEFnQXAMkU0VyLrD1AaNjTCgIn8j0G5VDwktTQVd8=
X-Received: by 2002:a17:90b:2604:b0:3a0:7c6c:9824 with SMTP id 98e67ed59e1d1-3a4bfe867e4mr468724a91.33.1790726236229;
        Tue, 29 Sep 2026 16:57:16 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca4498f1sm265230a91.11.2026.09.29.16.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:57:15 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id A488B16DC6A2; Wed, 30 Sep 2026 08:57:14 +0900 (JST)
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
Subject: [PATCH v4 1/2] selftests: run tests on nommu architecture
Date: Wed, 30 Sep 2026 08:57:10 +0900
Message-ID: <20260929235711.2287931-2-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929235711.2287931-1-thehajime@gmail.com>
References: <20260929235711.2287931-1-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_165717_322932_843623DB 
X-CRM114-Status: GOOD (  14.19  )
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

Architectures lacking MMU don't support fork(2) syscall and only
vfork(2) is available with limitations.  Thus, we cannot run kselftest
on nommu architecture as is.

This commit addresses this issue with the following changes:

- on test run stage, avoid calling timeout command when NOMMU=1 variable
  added to environmental variable, since timeout command uses fork
  syscall which nommu platform doesn't support.
- describe the difference of nommu tests in the document.

So command line to build/execute tests for nommu should be like below:

 $ make ARCH=um NOMMU=1 O=build kselftest-all TARGETS=nommu
 $ make ARCH=um NOMMU=1 O=build kselftest-install TARGETS=nommu
 $ NOMMU=1 ./build/kselftest/kselftest_install/run_kselftest.sh -p \
   -c nommu

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

v3 => v4
- fix typos in commit message

v2 => v3
- remove unnecessary modification
- new target is moved from TARGETS=mm/nommu to TARGETS=nommu
- rename CONFIG_NOMMU to NOMMU to avoid confusion to kernel config

rfc => v2
- reformat ktap header, reported by Sashiko review
- https://lore.kernel.org/linux-mm/20260825015945.141739-2-thehajime@gmail.com/

rfc: https://lore.kernel.org/linux-mm/20260813063401.1786548-1-thehajime@gmail.com/
---
 Documentation/dev-tools/kselftest.rst       | 14 ++++++++++++++
 tools/testing/selftests/kselftest/runner.sh |  6 +++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 64c0ec7428a2..c35b819947b7 100644
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
+  $ make ARCH=um NOMMU=1 O=build kselftest-all TARGETS=nommu  # <= build-only
+  $ make ARCH=um NOMMU=1 O=build kselftest-install TARGETS=nommu
+  $ NOMMU=1 ./build/kselftest/kselftest_install/run_kselftest.sh -p -c nommu
+
 Contributing new tests
 ======================
 
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 311811dc55a0..ee2c1f0403d9 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -38,8 +38,12 @@ tap_prefix()
 
 tap_timeout()
 {
+	# nommu doesn't support timeout command (missing fork(2))
+	if [ "$NOMMU" = "1" ] ; then
+		echo "timeout isn't supported for NOMMU"
+		$1
 	# Make sure tests will time out if utility is available.
-	if [ -x /usr/bin/timeout ] ; then
+	elif [ -x /usr/bin/timeout ] ; then
 		/usr/bin/timeout --foreground "$kselftest_timeout" \
 			/usr/bin/timeout "$kselftest_timeout" $1
 	else
-- 
2.43.0


