Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML updates for v4.10-rc1
Message-ID: <25ac38ae-6eab-b6e3-7ced-92d269a33699@nod.at>
Date: Fri, 16 Dec 2016 15:19:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.10-rc1

for you to fetch changes up to f88f0bdfc32f3d1e2fd03ec8a7f7b456df4db725:

  um: UBD Improvements (2016-12-14 22:46:55 +0100)

----------------------------------------------------------------
This pull request contains:
* A performance enhancement for UML's block driver

----------------------------------------------------------------
Anton Ivanov (1):
      um: UBD Improvements

 arch/um/drivers/ubd.h      |   5 ++
 arch/um/drivers/ubd_kern.c | 168 ++++++++++++++++++++++++++++++++++++++-------
 arch/um/drivers/ubd_user.c |  21 +++++-
 3 files changed, 167 insertions(+), 27 deletions(-)

