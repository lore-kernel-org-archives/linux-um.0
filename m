Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A06CC5516F
	for <linux-um@archiver.kernel.org>; Thu, 30 Jul 2026 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kh0YNRsKbMT5fdjQhDMHibLAJzCLrvhl5Z5FXrqD/Xc=; b=l8dAlx8EkSl3/0Nrtmxn4eyHm8
	qruijkam0IbwgIAsAJpxhbkzovJoxC9hBLKGqWFPecrO0r+9nF2TVB/x3iDyWLywMzWBaObS4Oka5
	SpdXnxXoGHj1+LRnxBedZH9AEnGMgsAMNjwGh/l+svIJZQ/qkxEjZoYs0GgFTPe/tIexZEYjrg5HI
	Z0BreCCoIs4yG1VbPm7//sVXbwMCaVtCTOMRrjjgdKTtVWc3XHHQOJF/rcigm/wqxdYIgm4JgBXpG
	EmVyC22Xr6Fj81KA4nraCwGWV+SPihGWiSttuyojKc4mSQeCER5NlrZLDHTouSN8RHrjQTfqBl+4L
	/d2hD4Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpW2h-0000000BCPo-0YFU;
	Thu, 30 Jul 2026 19:03:43 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.166.231])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpW2a-0000000BCNg-1O6E
	for linux-um@lists.infradead.org;
	Thu, 30 Jul 2026 19:03:39 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9F047C0000E1;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9F047C0000E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1785438213;
	bh=UuXufE5a5AF00jV9V57D39nWiz6i8jzSr3rAMw7EwH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6sU10F4AwOqJ/zl+xFcHz88e4AfcA9BVv1CMxgPZGhbDjIq5N2PCL6n8DtJaIyZ2
	 1cDy+Pu0n7JDb5lGmuEnEIBiyhRk/PLrq1bGiFy7FpP0jOGiB1ox+aCascyRqRXDJL
	 39oCT9KcaZPyYNKodDqJ90rYKejjHA9LRswrsLNI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 6D76AAE0;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Shuvam Pandey <shuvampandey1@gmail.com>,
	David Gow <david@davidgow.net>,
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
Subject: [PATCH stable 6.18 2/2] kunit: tool: skip stty when stdin is not a tty
Date: Thu, 30 Jul 2026 12:03:29 -0700
Message-Id: <20260730190329.3388222-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
References: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_120338_257020_A10A7866 
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
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I6c5292f5db0f5ce95399ee3dc87c00116709391e
---
 tools/testing/kunit/kunit_kernel.py    | 10 ++++--
 tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 4f0bec8fb4e1..2869fcb199ff 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -346,6 +346,12 @@ class LinuxSourceTree:
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
@@ -393,11 +399,11 @@ class LinuxSourceTree:
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
index ed45bac1548d..0eb61de9abd4 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -515,6 +515,48 @@ class LinuxSourceTreeTest(unittest.TestCase):
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


