Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6CFC433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oG0dCKqMXOFjGjCZP/wcBXJfKkS0zqIRQwrgkmvt+PI=; b=IQIk/D4tgqdTcp
	gFCa6l9bHd4yWa+esgt6DxO2TnD3o1oqg7erj4NpRpACMTMoQyP2KJZ1h8G90vHNgwStfPmZWiSZ6
	MED4ucNK8y8hG82S22V4IZhoWe5kQmFdlgTJ59ujHDPKj1ao1uthF5mDouuLtzQiOclre2wWmqK8B
	50J2f8GKWRq0MP8Jl66sTD8tyA0Kc8Oz5RzbdXVCs5AiWAbEQqjxTczlpKy5tD3+IxHfGmPWHCtU7
	vNiYbZ5o/OFSUU30Mux5pkncuNadkz2Gb49vXpC3L8sNKarNIXeRfbwLaj1W3IwFwwHh0CGSXZzWh
	vVpLf22Wfjhavdw2fA5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFC-007fqP-8W; Tue, 22 Nov 2022 10:11:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF0-007ff0-E8
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Tf+OtFyVX64LUnXkiI23V6ewhmeW6dbdRWL6ZKcORDw=;
	t=1669111858; x=1670321458; b=jh1a9b6V4Kd4vJD/s1Idm5kGQUMiQHf/eHCXLq/OG8KfFCI
	mbOZ1VFE5du9nssrVn/hMtxRz+Jtu4OVGhDGALpjRkflWw6CXMaBFutQoE9d70dDpoAeZw85aQMcD
	uHCeVw5Md8HSSmEabOYYjnDvL52TWR1nFYGq+yUtRoBdQCNFMoBuq8xVoCMVl6yEzu9gOYCnXM0mj
	dzA2IAnyMh9q52X29yqUwWNPnldNKdGLhJjfXjUJHixfNhbDSRh+13kCHUvqIBDGLuQKVv9V7BNqE
	LcFleMEf8reBUv9SnFxm6x2Kv96eaqLufV52v0z9uR55VxWtbO7iw8t7BPJs2Tzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEn-006IGn-0r;
	Tue, 22 Nov 2022 11:10:45 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 05/28] um: Make errors to stop ptraced child fatal during startup
Date: Tue, 22 Nov 2022 11:07:36 +0100
Message-Id: <20221122100759.208290-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021058_849497_F18DA8A1 
X-CRM114-Status: GOOD (  14.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

For the detection code to check whether SYSEMU_SINGLESTEP works
correctly we needed some error cases while stopping to be non-fatal.
However, at this point stop_ptraced_child must always succeed, and we
can therefore simplify it slightly to exit immediately on error.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/start_up.c | 41 +++++++++++--------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 561c08e0cc9c..8b0e98ab842c 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -112,35 +112,20 @@ static int start_ptraced_child(void)
 	return pid;
 }
 
-/* When testing for SYSEMU support, if it is one of the broken versions, we
- * must just avoid using sysemu, not panic, but only if SYSEMU features are
- * broken.
- * So only for SYSEMU features we test mustpanic, while normal host features
- * must work anyway!
- */
-static int stop_ptraced_child(int pid, int exitcode, int mustexit)
+static void stop_ptraced_child(int pid, int exitcode)
 {
-	int status, n, ret = 0;
+	int status, n;
+
+	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0)
+		fatal_perror("stop_ptraced_child : ptrace failed");
 
-	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0) {
-		perror("stop_ptraced_child : ptrace failed");
-		return -1;
-	}
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if (!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
-		if (exit_with == 2)
-			non_fatal("check_ptrace : child exited with status 2. "
-				  "\nDisabling SYSEMU support.\n");
-		non_fatal("check_ptrace : child exited with exitcode %d, while "
-			  "expecting %d; status 0x%x\n", exit_with,
-			  exitcode, status);
-		if (mustexit)
-			exit(1);
-		ret = -1;
+		fatal("stop_ptraced_child : child exited with exitcode %d, "
+		      "while expecting %d; status 0x%x\n", exit_with,
+		      exitcode, status);
 	}
-
-	return ret;
 }
 
 static void __init check_sysemu(void)
@@ -185,16 +170,14 @@ static void __init check_sysemu(void)
 			goto fail;
 		}
 	}
-	if (stop_ptraced_child(pid, 0, 0) < 0)
-		goto fail_stopped;
+	stop_ptraced_child(pid, 0);
 
 	os_info("OK\n");
 
 	return;
 
 fail:
-	stop_ptraced_child(pid, 1, 0);
-fail_stopped:
+	stop_ptraced_child(pid, 1);
 	fatal("missing\n");
 }
 
@@ -233,7 +216,7 @@ static void __init check_ptrace(void)
 			break;
 		}
 	}
-	stop_ptraced_child(pid, 0, 1);
+	stop_ptraced_child(pid, 0);
 	os_info("OK\n");
 	check_sysemu();
 }
@@ -312,7 +295,7 @@ void __init os_early_checks(void)
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
-	stop_ptraced_child(pid, 1, 1);
+	stop_ptraced_child(pid, 1);
 }
 
 int __init parse_iomem(char *str, int *add)
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
