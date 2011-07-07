Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Jul 2011 19:34:40 +0300
Message-ID: <1310056480.3528.47.camel@vivanov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 0/3] UML: Memory leak fixes.
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, vitalivanov@gmail.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Richard,

Here is a set of fixes for UML memory leak cleanups.

 arch/um/drivers/net_user.c  |    5 +++--
 arch/um/drivers/slip_user.c |    3 +--
 arch/um/os-Linux/main.c     |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

Thanks,
Vitaliy

