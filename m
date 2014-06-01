Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Real Name <enjoymindful@gmail.com>
Date: Sun,  1 Jun 2014 21:08:50 +0800
Message-Id: <1401628131-1948-1-git-send-email-enjoymindful@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] delete unnecessary bootmem struct page array
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org, Honggang Li <enjoymindful@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Honggang Li <enjoymindful@gmail.com>

The patch based on linux-next-20140530.

Honggang Li (1):
  delete unnecessary bootmem struct page array

 arch/um/kernel/um_arch.c | 6 ------
 1 file changed, 6 deletions(-)

-- 
1.8.3.1

