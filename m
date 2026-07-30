Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D358C55171
	for <linux-um@archiver.kernel.org>; Thu, 30 Jul 2026 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnQpQazhuoQZQ4MkZl3H8uG69ObR8DBJRmYylJiH5k4=; b=mLT2wDZJ1EGjq7cNtxOY/M8pFU
	p29g1dCPkUKHKur6j/k2z8b1ci6WDt00IUvt1YE54BmIIMRYH1wtJk8SoPaDSbWK8FMDJaBm9OZP3
	dIpv3PcY6b1/116OiGNLWCRA3gnYf/U5xc5SS4sPgl/5KW2cNsbGMnDiWFFhZePLVR0l6FFT2p7C2
	QAas1QwRRcZHzbtkTxLOkstyjL+Rt9g1JYafYmCHp0kXpcnsHRMA8Cq+xloeIeCvbL6afURfxbkBz
	U4biZNeQdQV+h0tE3bxNEN0qJ8t0cMLtUNSM6Xy1Gq5xVwEX0M+ff+vkcht9HQM1bQgpRxXVrvSGt
	dqczFq7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpW2h-0000000BCPc-0Aa1;
	Thu, 30 Jul 2026 19:03:43 +0000
Received: from lpdvsmtp10.broadcom.com ([192.19.144.205] helo=relay.smtp-ext.broadcom.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpW2a-0000000BCNe-2Dbn
	for linux-um@lists.infradead.org;
	Thu, 30 Jul 2026 19:03:38 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A6F0DC0005CB;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A6F0DC0005CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1785438213;
	bh=bEojjssgy+3BVmNhMsFy/IPLoFjK4P2FmNivYkd0/vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHy+TmYmSosSUrvVzqRYNpqu7/nfKORF0xH9EjA0uhDbMXlIYp9hWakGokxvR9gdY
	 mkCEH7154OFsRD0zRr151ISuR27VxXSZtWs+JAyqjouwto4eeZcPGK6UBjiA8NfHEt
	 NQZgolfED513EOQk/MvwATI4lSR1Mpi2FvvMym3Q=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 34531ADE;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: David Gow <david@davidgow.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Cursor <cursoragent@cursor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.18 1/2] kunit: tool: Terminate kernel under test on SIGINT
Date: Thu, 30 Jul 2026 12:03:28 -0700
Message-Id: <20260730190329.3388222-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
References: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_120337_017231_3617083A 
X-CRM114-Status: GOOD (  16.66  )
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

From: David Gow <david@davidgow.net>

commit 8f260b02eeeffbf2263c2b82b6e3e32fd73cde2b upstream

kunit.py will attempt to catch SIGINT / ^C in order to ensure the TTY isn't
messed up, but never actually attempts to terminate the running kernel (be
it UML or QEMU). This can lead to a bit of frustration if the kernel has
crashed or hung.

Terminate the kernel process in the signal handler, if it's running. This
requires plumbing through the process handle in a few more places (and
having some checks to see if the kernel is still running in places where it
may have already been killed).

Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Closes: https://lore.kernel.org/all/aaFmiAmg9S18EANA@smile.fi.intel.com/
Signed-off-by: David Gow <david@davidgow.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
[florian: resolved conflict in signal_handler(): upstream references
_restore_terminal_if_tty() which is introduced by the following commit;
retained subprocess.call(['stty', 'sane']) until that helper is available]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I4fc947a1e9268b8611151f7845edb4c832f05890
---
 tools/testing/kunit/kunit_kernel.py | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2998e1bc088b..4f0bec8fb4e1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -16,7 +16,7 @@ import shutil
 import signal
 import sys
 import threading
-from typing import Iterator, List, Optional, Tuple
+from typing import Iterator, List, Optional, Tuple, Any
 from types import FrameType
 
 import kunit_config
@@ -265,6 +265,7 @@ class LinuxSourceTree:
 		if kconfig_add:
 			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
 			self._kconfig.merge_in_entries(kconfig)
+		self._process : Optional[subprocess.Popen[Any]] = None
 
 	def arch(self) -> str:
 		return self._arch
@@ -358,36 +359,45 @@ class LinuxSourceTree:
 			args.append('kunit.filter_action=' + filter_action)
 		args.append('kunit.enable=1')
 
-		process = self._ops.start(args, build_dir)
-		assert process.stdout is not None  # tell mypy it's set
+		self._process = self._ops.start(args, build_dir)
+		assert self._process is not None # tell mypy it's set
+		assert self._process.stdout is not None  # tell mypy it's set
 
 		# Enforce the timeout in a background thread.
 		def _wait_proc() -> None:
 			try:
-				process.wait(timeout=timeout)
+				if self._process:
+					self._process.wait(timeout=timeout)
 			except Exception as e:
 				print(e)
-				process.terminate()
-				process.wait()
+				if self._process:
+					self._process.terminate()
+					self._process.wait()
 		waiter = threading.Thread(target=_wait_proc)
 		waiter.start()
 
 		output = open(get_outfile_path(build_dir), 'w')
 		try:
 			# Tee the output to the file and to our caller in real time.
-			for line in process.stdout:
+			for line in self._process.stdout:
 				output.write(line)
 				yield line
 		# This runs even if our caller doesn't consume every line.
 		finally:
 			# Flush any leftover output to the file
-			output.write(process.stdout.read())
+			if self._process:
+				if self._process.stdout:
+					output.write(self._process.stdout.read())
+					self._process.stdout.close()
+				self._process = None
 			output.close()
-			process.stdout.close()
 
 			waiter.join()
 			subprocess.call(['stty', 'sane'])
 
 	def signal_handler(self, unused_sig: int, unused_frame: Optional[FrameType]) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
+		if self._process:
+				self._process.terminate()
+				self._process.wait()
 		subprocess.call(['stty', 'sane'])
-- 
2.34.1


