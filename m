Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3671C9830E
	for <linux-um@archiver.kernel.org>; Sat, 26 Sep 2026 01:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nCkD0NEbpweweLPyYmTDv9COC7AncTDYJNFGXpSt24U=; b=AcvofmuS64q7UlUSdqfoMzsOIt
	+/2rYEsQYAn0XzZHROa2mChEZPbyGz0gm59aRO+hbqzRABmPfeb6nqvvUw59xd6sECrNBo//NFo0+
	C5m5fO1gxQMBDtol+LpeLEcRNFLh6xcz7qwTs4eGE+4wA6OEUImJGyHQKudhWfSB/VY/xagCPoU3i
	TYnVJhD9XfaXsWRjRRX0Q6+Bq9jKJAwXSAjHEtXJo0aA0/zD3bt/lfUc6bitPgx4EAuSxNcnlyABc
	aX+W5BITN69KbxL7pyek8+a20X9f9u//UBG4iAZ0GrFrTTjTZM9LHdb/1W/Wj8rizg2KqU+qLc7aX
	IRjmd1xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGtz-0000000En9C-1Okz;
	Sat, 26 Sep 2026 01:08:31 +0000
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAGtv-0000000En6l-2hWf
	for linux-um@lists.infradead.org;
	Sat, 26 Sep 2026 01:08:29 +0000
Received: by mail-pz2-x0c.google.com with SMTP id 41be03b00d2f7-cc515bef69dso577726a12.2
        for <linux-um@lists.infradead.org>; Fri, 25 Sep 2026 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790384907; x=1790989707; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nCkD0NEbpweweLPyYmTDv9COC7AncTDYJNFGXpSt24U=;
        b=hfB6NkfgBPbgCxiFn1cYDPdvEvrdwhYsK70OfoW/SCZCNuNXNzzfFyBkusl2XfcFeS
         NYGP+e7Ga9JXhxD3Z8FfC12LyRyClw91RbiCNyHxeHMAT8xYAm3wcT3Dm7djybRvld4B
         Wk04NFC7b9cNmprWx4M5fVPC2Swd2JfXf+1AJKpgo/yILiAOV3mh7Mg+ildUDvnJbrsG
         1dw7MK04QO09mfPQvstuafy0RU+Eblps8ytXImngcgEda08LkdtZby4VbaybKRtefEUQ
         eAIaaaw8NTVOAWsmveF7oxda08ftAAKqfVEBapXBmRKZZo6Uo6lq/UfsKeWkfM9cComL
         7eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790384907; x=1790989707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nCkD0NEbpweweLPyYmTDv9COC7AncTDYJNFGXpSt24U=;
        b=KOWXbin5x+qUULwm6Bnh8Wkgb9+PVIvufaA6ZLP0hagdo2yXvnutNVJmRCZdaW2Kld
         Wg6xbH7iIXqmmr2nP5s4Qx36vnDtQWEDxz1QDZMrNPhYx4qNiyY58nXtE4p/W1Q92LfK
         GRBMfCbVv4deNrV0bpN2v+36YdxOopV4V3I9ioJgAc1aDU+3l87HKXcu+6giVkptxSzq
         1Gtlt7gziG7W6Fi6L6s2VyrT5dHubqJ70+QQfjBDFwG89+XnoxuWwqHZN4UQpkmqXEZL
         HsCJ8Spyr9Y0BJ/yk1WOGmEN6G9xvD4Pa/nc59DjYyGzqaMB+HLthYZxpUsXw1Ho3pif
         BnMw==
X-Forwarded-Encrypted: i=1; AKwUvBwpKKmUkCKmPhCF5XbqbBBaf+H2aEiTBjOXa1w2Ac8z+E8soMUEVzCWK4H9jqnRDu5dq/mly6O5aA==@lists.infradead.org
X-Gm-Message-State: AFuF++mpkAA6F6dARCOHPje0dFEld7yYajr/BrhJBA8gTJyRulCHYwj4
	RB+iWeyOLQqx6l4qVEb6HHfzNva6rSyLBvIZMzZTBiqxc2Qx11lKxRDh
X-Gm-Gg: AYBFou1WPszYEFDzaNG1Z17U9sTnDrd6eAyE1Rcnt/hzYzZr0unozK7K62uok+YiA6H
	nAezRkQ0cd19ZiSVEocb2N6kAqk8u9CWh9IoF8wkPSetLzdgSJAXrNC2jT7SrliLzsy3UBQGSP6
	B54oGCtswoa3VzV3jtaw+GFyuEI+cZyw814pVSl+o0NYAWBmTIvgk0vv+W/y3RHbsATugYmD5ea
	KB8xKQafrAY2r3VUj+mVJlnOfRGpsi72jhYu+sq0KZkBNTih/v+Xj6tQei9upMWV1Yr2JZnf7jA
	tt68PHM3HwhK03PQcvN1qO+jv8nZVKmhucpG1pmMthNS5cPjkg2x2W2LuevdHKPbCJwAAsM3AYV
	veJPT1IiFI7bnha6STzTqtqSFmg+lZY11kwbdT9MNnc5j8epQAM3ibog+5xRUUh0H0cesT3i483
	qZWJYJCbLBgaLqN/AsNeNCOYKS/8IpsM34P2VQtgxnEtoONGkDc78ziZHUnSHVuwhq0MQ6GmBLr
	1tPG1abSHzHrFBaSb20suklbgj0xykGIu5vSwqCtoHCoJdIOawZR7BzbjeQJKCwgV+3FfWnpHJP
	2s70p6xXinS1KGMrJ8WGuZZbtZvwgNiLzsjOKR00cWbhoHJRK4vaToVjj16CXg==
X-Received: by 2002:a17:90b:39a6:b0:3a0:c0f0:9a96 with SMTP id 98e67ed59e1d1-3a0c0f0ab36mr2504067a91.62.1790384906461;
        Fri, 25 Sep 2026 18:08:26 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99dcd78sm7026970a91.15.2026.09.25.18.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 18:08:25 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DFEC716C9C98; Sat, 26 Sep 2026 10:08:24 +0900 (JST)
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
Subject: [PATCH v3 2/3] selftests: run tests on nommu architecture
Date: Sat, 26 Sep 2026 10:08:18 +0900
Message-ID: <20260926010819.604346-3-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926010819.604346-1-thehajime@gmail.com>
References: <20260926010819.604346-1-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_180827_688500_E46DE294 
X-CRM114-Status: GOOD (  13.33  )
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
index 8fc1018d6fec..95b5ebb8bbb9 100644
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


