Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F873C5321C
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZXqtF8b6I/e2AIIn3xD2AACZivykLEyLycWHjqlL584=; b=jr+qwCTuzCItd6juhvvmWnGAXZ
	jekUUAO4gx8/ZHNvUbt2FL0rOI+i7ytVgfH99eS2eCo1qXbS+dDZtefRH+/cmp54HGVxOfAH+NgbY
	GCCO66a+o2gfMI3HPdpb5xjlzGo2ZJKImUU0gVX1ihNZ3c9oIQjAjLHA7H5b3rUliSYg0FXNLtjIR
	/UWLISfmLksbXmS9GIXpED5NRlnikpEdxQhd8CF62t7dWmpkM0RpfzbL39HOxV9V/Ng49cZ0O1fb+
	4vg1zkzOwWOcioam/mDkJypimfWXfOIFgF5/LAOKUfPX5tcrqsqEvFg1K55ZSKljvQ7W9Q11BP9OX
	viWzJccA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe9-0000000HGqW-0fSn;
	Fri, 24 Jul 2026 21:41:33 +0000
Received: from lpdvsmtp10.broadcom.com ([192.19.144.205] helo=relay.smtp-ext.broadcom.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe1-0000000HGgz-05TS
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:30 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1983AC0000F8;
	Fri, 24 Jul 2026 14:41:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1983AC0000F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929283;
	bh=B/FVPqJ84r1NeF4yRoSJgPJFblvoill5bI2J/4InfJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FA4JeYelE+tG7xu1u12xUIQEaqHuPcleuj+ctJVm80+XGX0ttBNcSMVRiiOXCl7IY
	 P4KFOUoJevMxf4QX6klfqWuyxDOI7NPT4YBZSAj92vJo4nASkQmN8yNojLEDdOvyI7
	 4hXx+aqDbMjYTJGAeGM5CQWUNEtRZklX3nh/pd3k=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 988A2AD0;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: David Gow <david@davidgow.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH stable 6.12 7/9] kunit: tool: Terminate kernel under test on SIGINT
Date: Fri, 24 Jul 2026 14:41:17 -0700
Message-Id: <20260724214119.1066665-8-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144125_184479_3E7CF084 
X-CRM114-Status: GOOD (  16.78  )
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
---
 tools/testing/kunit/kunit_kernel.py | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 12b0f2ee5665..3f2979f2f6ea 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -15,7 +15,7 @@ import shlex
 import shutil
 import signal
 import threading
-from typing import Iterator, List, Optional, Tuple
+from typing import Iterator, List, Optional, Tuple, Any
 from types import FrameType
 
 import kunit_config
@@ -252,6 +252,7 @@ class LinuxSourceTree:
 		if kconfig_add:
 			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
 			self._kconfig.merge_in_entries(kconfig)
+		self._process : Optional[subprocess.Popen[Any]] = None
 
 	def arch(self) -> str:
 		return self._arch
@@ -345,36 +346,45 @@ class LinuxSourceTree:
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


