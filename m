Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55567A07.7020801@nod.at>
Date: Sat, 16 May 2015 00:58:15 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML fixes for 4.1-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

the following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.1-rc4

for you to fetch changes up to a718c92219b35e8a75175fde85c4566ac5730273:

  hostfs: Use correct mask for file mode (2015-05-04 14:50:29 +0200)
----------------------------------------------------------------
This pull request contains a single fix for a regression
introduced in 4.1-rc1.

----------------------------------------------------------------
Richard Weinberger (1):
      hostfs: Use correct mask for file mode

 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
