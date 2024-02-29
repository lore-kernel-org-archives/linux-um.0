Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C4FC54E49
	for <linux-um@archiver.kernel.org>; Thu, 29 Feb 2024 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZJ4iZR2qsWlZ4aapEky+vEYApfMYzxKzJ6l+O/T6keg=; b=a3eoZm+hHACpXAo8nKStADEoqE
	RtxklA8wN2yLBxHP75itPGX3mjEN8hWv7rVTnXjJhy4AEMS9+0KAK+wiZij2LJm2pRGX7ukTD0Jem
	EFBval9Dj0ZCDdFleaqw/H2rtJ0jg0I5A+64m+3TXVA9oYhrS+dDuiSrIq6Y2IxSD8sckJEn5/6lN
	mp2SwwaChEodHxG3AClJWYnj7NtbYbk5Wn2hxCSbuARA5C8CKv3KI52ytlUv3Tr5Zu7+ay3OADpp0
	KWBUVpCQf16HKV+dL6cwyTpPXrUxaawvzU2ixn31pxZvfTNME76Omt+U57QFVLZfcLFPIG/iMvXGD
	OtsF2u2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfjpt-0000000EPjP-2o3a;
	Thu, 29 Feb 2024 17:04:45 +0000
Received: from smtp-8fa9.mail.infomaniak.ch ([2001:1600:7:10::8fa9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfjpo-0000000EPaq-1gZE
	for linux-um@lists.infradead.org;
	Thu, 29 Feb 2024 17:04:43 +0000
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TlyHp6JJMz5wk;
	Thu, 29 Feb 2024 18:04:22 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TlyHm47S2zYBH;
	Thu, 29 Feb 2024 18:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709226262;
	bh=4wDdbt4I56G5n6LSUJ2u1jaEVBMsm/64WWZPbsYi9U0=;
	h=From:To:Cc:Subject:Date:From;
	b=nlVkoodRGG/+JH60co6QTYI+j/xS/kAvzRqTk/xdhkVfSSC5JtD7P7treNBKoqd0u
	 U5gu49lO236cmDqZAiQi+oFIZbE1jszXjS2h0mslolmhNqIG4IKa/drMCKvMRTmYRX
	 pKXV1VkrqQbG3nE+oEnjraDdG3Vrknapc8Mb93bc=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v1 0/8] Run KUnit tests late and handle faults
Date: Thu, 29 Feb 2024 18:04:01 +0100
Message-ID: <20240229170409.365386-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_090440_617129_473C8D2B 
X-CRM114-Status: UNSURE (   8.56  )
X-CRM114-Notice: Please train this message.
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

Hi,

This patch series moves KUnit test execution at the very end of kernel
initialization, just before launching the init process.  This opens the
way to test any kernel code in its normal state (i.e. fully
initialized).

This patch series also teaches KUnit to handle kthread faults as errors,
and it brings a few related fixes and improvements.

New tests check NULL pointer dereference and read-only memory, which
wasn't possible before.

This is useful to test current kernel self-protection mechanisms or
future ones such as Heki: https://github.com/heki-linux

Regards,

Mickaël Salaün (8):
  kunit: Run tests when the kernel is fully setup
  kunit: Handle thread creation error
  kunit: Fix kthread reference
  kunit: Fix timeout message
  kunit: Handle test faults
  kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
  kunit: Print last test location on fault
  kunit: Add tests for faults

 include/kunit/test.h                |  24 +++++-
 include/kunit/try-catch.h           |   3 -
 init/main.c                         |   4 +-
 lib/bitfield_kunit.c                |   8 +-
 lib/checksum_kunit.c                |   2 +-
 lib/kunit/executor.c                |  81 ++++++++++++++------
 lib/kunit/kunit-example-test.c      |   6 +-
 lib/kunit/kunit-test.c              | 115 +++++++++++++++++++++++++++-
 lib/kunit/try-catch.c               |  33 +++++---
 lib/kunit_iov_iter.c                |  70 ++++++++---------
 tools/testing/kunit/kunit_kernel.py |   6 +-
 11 files changed, 261 insertions(+), 91 deletions(-)


base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.44.0


