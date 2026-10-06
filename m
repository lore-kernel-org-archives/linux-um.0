Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D2DCA6002
	for <linux-um@archiver.kernel.org>; Tue,  6 Oct 2026 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZc7x+1xFrkceqpJwcgU1RKoagSWQzy1+YI5nAgqplo=; b=sviIT+z0X/PAOCCQ6bZzGDIvvW
	v2K9zE+EZ2gi/IVwSkDmaA9Jb/OxaYi6QXVwGIhqvsn0js6VDtN3ncCFS7syyB5IbhtoWQZ5j4vbv
	9QhIKrKUlMMtAb1Koth6OaaItW/lP7dm0KeHZZe/0OQdzI/t634ywML6JhY7Gm+l7ZT9qmByx5dxk
	xh3yIzavom85VH1AO0Pu9K4c8XNle+2Onob1qMMH3m7ccfKhvwtsNfp3pbmFWOph2fl/CuaI48Z8L
	7TcGvkJ1TDtGLHY4noAVWpUtzYkVKUE4GUVzIjdYNe7GqLGTPop7yDOVoX29vW5tSeAE0Ss/MS1+N
	wKNxWL2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE0yq-00000000KM7-1nvL;
	Tue, 06 Oct 2026 08:57:00 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE0yn-00000000KKY-0q1v
	for linux-um@lists.infradead.org;
	Tue, 06 Oct 2026 08:56:58 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3a4c47bb6e3so213441a91.1
        for <linux-um@lists.infradead.org>; Tue, 06 Oct 2026 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791277016; x=1791881816; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZc7x+1xFrkceqpJwcgU1RKoagSWQzy1+YI5nAgqplo=;
        b=Xn8oirJwDSHDry0ayMedRRYvubcSvWumkVXs42qrp27v+MaShOQ4NCnAa7wQSQCI8O
         wUn3/Am3JtuqBzl1D5uVZRf+PnPVyRxsNZ4G/a6kUkFUrX7myNn376D599vzyGewaVL/
         Kkmtn617r7VUtz/D/IRnwhROGrP7yNTUAFbex8lf+yaZK2Gki35XF8yvYv9ykpuKLqJ1
         gKtKVX8dAVzYUm2dhJ6hbuF5uumhvS64TR8ktHErwoQu9VbystnB0wLPshXKtC35dTX/
         ujUCS1xtZQDbuR8zaSFoRAWkPxlGInk/wt94CFqeKPwrA283buz8HppSoZ0+1kI2Owz8
         5Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791277016; x=1791881816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZc7x+1xFrkceqpJwcgU1RKoagSWQzy1+YI5nAgqplo=;
        b=EfcJ92SqrtnswScZldEN3f6mHogbQEVW8tRjst/YCZdEZSGSR9FzGZaacEgARtXWMN
         UQ9TBCoQoelh3phJ5aIbVRPVykW7wyT9V8kwIbTGHvwhSpFDDJUhT6LwBnOyPFT+z+GE
         6l+qK8TkEtB5DaPMHk+n6ANFW9V7PYyQDkqkIvnD1vEk81DhG3dO8/Eua+NiAqDVe7U8
         GzGNYrH6/317+zhbgwrhC4GHhHfGZ3cjtkvCtYWrDdhVeTeIAp+5VJv+ZRs9cT9NeY+m
         AfELPMYbZMy/F6irHJ902dSN2QlLqSemqOO4CwC75yKBxBf4znFDT929v7jkCleLby8o
         WpeA==
X-Forwarded-Encrypted: i=1; AKwUvBxaDkG2XsmqkybWV0Jam+8tTopo40FQ3GPqsMYHC2EGx2PRx2wL8znIqqDa6ChBFckG3e3ye3nK2Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYLz292zldHGKyrtfX40ew5BDaAh+38GTtzMpApIHl6wluapFkGH
	6g/1+R9sZG9taEeKvbk6ahIwS6xzn9BH7CPFSTNrmqodqFLrOMIRAhbw
X-Gm-Gg: AYBFou1dIsaSacvRNpWEyxk8JyVhsqg695LBZ6h4P45xFrowzJw1D0sxiMFll8/i9iQ
	kiFIqZb/7G4+por7nIJtc0ikKeRqxfqTwaCG3e01rGCt0c5CKc0jVnO1k2f2njpl/OzmqZlhnC5
	ZTGH8VUbwu9TTBIe32tzCP81ukSzEnMHDSqK64/zgmy5EOphJU1n14d5PjDTtUwFpILJ4opQYm6
	w6RHWoBpnaGoriqO+sDDXO7piPXIjjXZyR9EIjwG4DEBOeIERw4poKLl6sRJf60VFjajx8f+EL0
	QRWK82Wi4YbBcKQ+88CnMhfFs96Sk91uv9o39PvuFuEqceMqw2gZY3kwedtBQ74TvXMcixahkhn
	ilbLkoVL/Hz7hXs6uVY6BtLch450ylT6cGIAML56dQ2c4XpWcQE5P4w2GYe3icYLEYPJvbDK4zu
	HOjIHPXnPDFzT/wmXdwZiHoeDYfq9kBIqlCuc+yhUS+dOTUx3SmIrtFa4yssZjQPpL1ziTN92GU
	pfKdQx1oEQezw8Om7tS/39uWPn/CjLqXNHJ5n+HOXzObCz69TZbkz2JmyG1gy0K1maldUCm9FaH
	n/f/FoFoC/1ZnS5+OQiu4nwEt73JXKMbl0A2UiVL+T0TqoGCFdhC3bsKOIHQjtpjsICSJ2xR
X-Received: by 2002:a17:90b:33d1:b0:3a7:cffb:8b96 with SMTP id 98e67ed59e1d1-3a8735173f6mr510245a91.18.1791277016147;
        Tue, 06 Oct 2026 01:56:56 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cde769sm3761921a91.13.2026.10.06.01.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:56:55 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4543816FBFD1; Tue,  6 Oct 2026 17:56:54 +0900 (JST)
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
Subject: [PATCH v5 1/2] selftests: run tests on nommu architecture
Date: Tue,  6 Oct 2026 17:56:41 +0900
Message-ID: <20261006085642.3852152-2-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006085642.3852152-1-thehajime@gmail.com>
References: <20261006085642.3852152-1-thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_015657_248397_549882DD 
X-CRM114-Status: GOOD (  16.07  )
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

- Detect NOMMU at runtime from the MmapCopy field in /proc/meminfo
  and avoid timeout, which requires fork(2).
- Document how to build and run the NOMMU tests, including the procfs
  prerequisite for runtime detection.

Build and run the tests with:

 $ make ARCH=um O=build kselftest-all TARGETS=nommu
 $ make ARCH=um O=build kselftest-install TARGETS=nommu
 $ ./build/kselftest/kselftest_install/run_kselftest.sh -p -c nommu

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

v4 => v5
- remove build-time selection and detect NOMMU at runtime

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
 Documentation/dev-tools/kselftest.rst       | 18 ++++++++++++++++++
 tools/testing/selftests/kselftest/runner.sh | 11 ++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 64c0ec742..fc4dc1f9d 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -230,6 +230,24 @@ section::
 
 .. _tar's auto-compress: https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
 
+Build and test on nommu target
+==============================
+
+The nommu selftests detect NOMMU at runtime by checking for the ``MmapCopy``
+entry in ``/proc/meminfo``. Ensure procfs is mounted at ``/proc`` before
+building and running the tests.
+
+::
+
+  $ make ARCH=um O=build kselftest-all TARGETS=nommu  # <= build-only
+  $ make ARCH=um O=build kselftest-install TARGETS=nommu
+  $ ./build/kselftest/kselftest_install/run_kselftest.sh -p -c nommu
+
+The C tests report a skip if ``/proc/meminfo`` is unavailable. On a NOMMU
+system, the runner needs that file to avoid wrapping the tests in ``timeout``
+before they can report a skip. Mounting procfs is therefore a prerequisite
+for running this target through the kselftest runner.
+
 Contributing new tests
 ======================
 
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 311811dc5..45fb8ec38 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -36,10 +36,19 @@ tap_prefix()
 	fi
 }
 
+is_nommu()
+{
+	grep -q '^MmapCopy:' /proc/meminfo 2>/dev/null
+}
+
 tap_timeout()
 {
+	# nommu doesn't support timeout command (missing fork(2))
+	if is_nommu; then
+		echo "timeout isn't supported for NOMMU"
+		$1
 	# Make sure tests will time out if utility is available.
-	if [ -x /usr/bin/timeout ] ; then
+	elif [ -x /usr/bin/timeout ]; then
 		/usr/bin/timeout --foreground "$kselftest_timeout" \
 			/usr/bin/timeout "$kselftest_timeout" $1
 	else
-- 
2.52.0


