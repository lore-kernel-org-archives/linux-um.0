Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524BDC531F9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rwL6wxnKddJXSKzDl/SaHxfcvabP6bVVdgQ1DVVdgKk=; b=QY3KuXP5w8pf0wBEL24W0q7/Ck
	Wcqs7k8Z3ACX3QWcFs9lRkeaHzaSqz8GF4qlY0j0oKJAf2FxCr3t1e4Ckyg5etlrvH4PmS/ZZZVGl
	CAfeE4xxphuDEOgHSBr1n9lrLmPdMzMVl1jdtgjPUJkQ2PU4ofhcbaB+JQEWsBfWmWuVKkBW/6jDz
	G1vkURhto7f+at/gTzKMZnbdJQ7mOJ7R8/CwM0tn6+zStgJKlizwjrP8Du4JT0mfzbPk+/ttNdavE
	SQ79+YG0hQVJE/Xkv50putcs2/n5Fk+hqv/8fFcgECX9HS39YYb50kp1hr78Jb5dxXA87y/TNGYWu
	CbRi8xsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe8-0000000HGpr-491V;
	Fri, 24 Jul 2026 21:41:32 +0000
Received: from lpdvsmtp10.broadcom.com ([192.19.144.205] helo=relay.smtp-ext.broadcom.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe1-0000000HGh3-07HA
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:29 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 551F3C0000F9;
	Fri, 24 Jul 2026 14:41:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 551F3C0000F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929283;
	bh=6bIR/igc8vtJnwe2y1aD78jUwOu4p7lxaqy0G9VYVCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJYyCdcUFWFjlHqsjLXkitcJEJLrYg5So/9dA5K9khMILJItPWq+fSa7EpoblrrC1
	 Q6RVdH6yrSkXeo8KTkmSgb+yNXfkVpJmcZEG6h5oLZLPzAucn/HaObTiCeWgaf7fHl
	 OYit4J/S9heBFS62V4P24EEYQCSr0lV77OXgeaCo=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id D0CF5ACD;
	Fri, 24 Jul 2026 14:41:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Shuvam Pandey <shuvampandey1@gmail.com>,
	David Gow <david@davidgow.net>,
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
Subject: [PATCH stable 6.12 8/9] kunit: tool: skip stty when stdin is not a tty
Date: Fri, 24 Jul 2026 14:41:18 -0700
Message-Id: <20260724214119.1066665-9-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144125_194885_801A0A2F 
X-CRM114-Status: GOOD (  13.79  )
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

From: Shuvam Pandey <shuvampandey1@gmail.com>

commit e42c349f4cdfa43cb39a68c8f764f8cafc23a9a9 upstream

run_kernel() cleanup and signal_handler() invoke stty unconditionally.
When stdin is not a tty (for example in CI or unit tests), this writes
noise to stderr.

Call stty only when stdin is a tty.

Add regression tests for these paths:
- run_kernel() with non-tty stdin
- signal_handler() with non-tty stdin
- signal_handler() with tty stdin

Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
[florian: add missing 'import sys' required by sys.stdin.isatty(); the
module was already present in the mainline tree before this commit but
was absent from the 6.12 base of kunit_kernel.py]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/testing/kunit/kunit_kernel.py    | 11 +++++--
 tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 3f2979f2f6ea..c09b66ba734b 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,6 +14,7 @@ import os
 import shlex
 import shutil
 import signal
+import sys
 import threading
 from typing import Iterator, List, Optional, Tuple, Any
 from types import FrameType
@@ -333,6 +334,12 @@ class LinuxSourceTree:
 			return False
 		return self.validate_config(build_dir)
 
+	def _restore_terminal_if_tty(self) -> None:
+		# stty requires a controlling terminal; skip headless runs.
+		if sys.stdin is None or not sys.stdin.isatty():
+			return
+		subprocess.call(['stty', 'sane'])
+
 	def run_kernel(self, args: Optional[List[str]]=None, build_dir: str='', filter_glob: str='', filter: str='', filter_action: Optional[str]=None, timeout: Optional[int]=None) -> Iterator[str]:
 		# Copy to avoid mutating the caller-supplied list. exec_tests() reuses
 		# the same args across repeated run_kernel() calls (e.g. --run_isolated),
@@ -380,11 +387,11 @@ class LinuxSourceTree:
 			output.close()
 
 			waiter.join()
-			subprocess.call(['stty', 'sane'])
+			self._restore_terminal_if_tty()
 
 	def signal_handler(self, unused_sig: int, unused_frame: Optional[FrameType]) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
 		if self._process:
 				self._process.terminate()
 				self._process.wait()
-		subprocess.call(['stty', 'sane'])
+		self._restore_terminal_if_tty()
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 70e5d0abe87f..6e6200d52540 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -503,6 +503,48 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				self.assertIn('kunit.filter_glob=suite.test1', start_calls[0])
 				self.assertIn('kunit.filter_glob=suite.test2', start_calls[1])
 
+	def test_run_kernel_skips_terminal_reset_without_tty(self):
+		def fake_start(unused_args, unused_build_dir):
+			return subprocess.Popen(['printf', 'KTAP version 1\n'],
+						text=True, stdout=subprocess.PIPE)
+
+		non_tty_stdin = mock.Mock()
+		non_tty_stdin.isatty.return_value = False
+
+		with tempfile.TemporaryDirectory('') as build_dir:
+			tree = kunit_kernel.LinuxSourceTree(build_dir, kunitconfig_paths=[os.devnull])
+			with mock.patch.object(tree._ops, 'start', side_effect=fake_start), \
+			     mock.patch.object(kunit_kernel.sys, 'stdin', non_tty_stdin), \
+			     mock.patch.object(kunit_kernel.subprocess, 'call') as mock_call:
+				for _ in tree.run_kernel(build_dir=build_dir):
+					pass
+
+				mock_call.assert_not_called()
+
+	def test_signal_handler_skips_terminal_reset_without_tty(self):
+		non_tty_stdin = mock.Mock()
+		non_tty_stdin.isatty.return_value = False
+		tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[os.devnull])
+
+		with mock.patch.object(kunit_kernel.sys, 'stdin', non_tty_stdin), \
+		     mock.patch.object(kunit_kernel.subprocess, 'call') as mock_call, \
+		     mock.patch.object(kunit_kernel.logging, 'error') as mock_error:
+			tree.signal_handler(signal.SIGINT, None)
+			mock_error.assert_called_once()
+			mock_call.assert_not_called()
+
+	def test_signal_handler_resets_terminal_with_tty(self):
+		tty_stdin = mock.Mock()
+		tty_stdin.isatty.return_value = True
+		tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[os.devnull])
+
+		with mock.patch.object(kunit_kernel.sys, 'stdin', tty_stdin), \
+		     mock.patch.object(kunit_kernel.subprocess, 'call') as mock_call, \
+		     mock.patch.object(kunit_kernel.logging, 'error') as mock_error:
+			tree.signal_handler(signal.SIGINT, None)
+			mock_error.assert_called_once()
+			mock_call.assert_called_once_with(['stty', 'sane'])
+
 	def test_build_reconfig_no_config(self):
 		with tempfile.TemporaryDirectory('') as build_dir:
 			with open(kunit_kernel.get_kunitconfig_path(build_dir), 'w') as f:
-- 
2.34.1


