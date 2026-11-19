Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86594606A336
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JhA2z7ub;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=NT1Z+x9K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MWe39Nb/RxFSnXc3f1VE9L5I8zRUdFYpRSvZyE5F344=; b=JhA2z7ubCL7o2A
	7VMloGuSGe7el1a0CxCYgGnSmspRpqXBI7VlXo/7Ieq/SJoHTvI6mKVeho1HeQZ78hbBCrB59EVoX
	iqbSllQ8bv0cf69ZlTdq4E4zzHmQw0OcVuR/gf4SMzJwrWBBf0PEuswzsJtlHGPPM79KBlb/fy6ci
	Lplnl/YD12cz4jBdMIbjRGUVXNeUCWsXgVIK9NN9d2ye2C+SfCINFqn+JdqQqWS26t72ozEXpOn/O
	BWKmemEzdDSCCgj6yqPsfPufpAHs7/CqDGa9cE1sG5yx4FHjLmtfaCR8mCioRcQ/w8XbV35sqSUkI
	VFqKxFkPCQuIMKKZpnQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU27F-0000000C1Lp-12JQ;
	Thu, 19 Nov 2026 13:23:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU27A-0000000C1Im-2x7B
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MWe39Nb/RxFSnXc3f1VE9L5I8zRUdFYpRSvZyE5F344=;
	t=1795094628; x=1796304228; b=NT1Z+x9Ks1pMa8nO44HZngb9hqB2daNAHb1Vo6r/M4GZlka
	44GJx5UFqKpPf9I/HaR7mWxz9qmSAFJlS3NtFh4ZA6VFkVeic2FCJyLCn9t3y8lzUGU0VM7D40dsQ
	WvFx2fWllCpqUiX+ViezITrNjlU64HE2NYEQzC7Hf0xOOx2oPDySeXIhNCVO3tBPvjbldpbcUcJfA
	Xkc/BoicvpKbL/xFMInwB/PSxYVpH/onR4qhyvpj2ZYSDz2BivuC7KP0Y/qAgMx2c4tYv3Gk1xapC
	tuQc0Yva2+HerJfplnen2s20q/sB2nxiQBF4n61ylfCq8eS8Ga49q5TQ804fQiyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU276-00000004LIl-3FwG;
	Thu, 19 Nov 2026 14:23:44 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 1/3] um: Use fixed random seed if UML_RANDOM is set
Date: Thu, 19 Nov 2026 14:19:12 +0100
Message-ID: <20261119142340.9fcebd4d1520.I4b0e4ca4bf79c8cbece27e919366079e39c13151@changeid>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119132340.225696-5-johannes@sipsolutions.net>
References: <20261119132340.225696-5-johannes@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052348_748840_9CDEF63E 
X-CRM114-Status: GOOD (  13.29  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Benjamin Berg <benjamin.berg@intel.com>

For a more reproducible /dev/random inside test runs,
enable setting the UML_RANDOM environment variable.
This helps create reproducable test runs.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/util.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index e3ad71a0d13c..3a3baf4df587 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -98,6 +98,42 @@ static inline void __attribute__ ((noreturn)) uml_abort(void)
 
 ssize_t os_getrandom(void *buf, size_t len, unsigned int flags)
 {
+	static char random_pattern[128];
+	static ssize_t random_pattern_len = -1;
+
+	/* This happens when called by setup_arch */
+	if (random_pattern_len == -1) {
+		const char *env;
+
+		env = getenv("UML_RANDOM");
+		if (env) {
+			random_pattern_len =
+				strlen(env) > sizeof(random_pattern) ?
+				sizeof(random_pattern) : strlen(env);
+			memcpy(random_pattern, env, random_pattern_len);
+		} else {
+			random_pattern_len = 0;
+		}
+	}
+
+	if (random_pattern_len > 0) {
+		size_t tail = len;
+		/*
+		 * If the returned length is too short, then the kernel might
+		 * loop trying to generate random from the passing of time.
+		 * Which seems to possibly infinite loop in time-travel mode.
+		 * So just repeat the given pattern.
+		 */
+		while (tail > random_pattern_len) {
+			memcpy(buf, random_pattern, random_pattern_len);
+			tail -= random_pattern_len;
+			buf += random_pattern_len;
+		}
+		memcpy(buf, random_pattern, tail);
+
+		return len;
+	}
+
 	return getrandom(buf, len, flags);
 }
 
-- 
2.56.1


