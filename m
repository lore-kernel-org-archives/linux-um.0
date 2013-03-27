Return-Path: <linux-kernel-owner@vger.kernel.org>
From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 27 Mar 2013 10:47:11 +0000
Message-ID: <1364381234-22960-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 0/3] hostfs: tweaks from imgdafs review
To: Jeff Dike <jdike@addtoit.com>, Al Viro <viro@ZenIV.linux.org.uk>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This patchset contains some tweaks to hostfs, based on imgdafs review
comments from Al Viro which also apply to hostfs.

James Hogan (3):
  hostfs: remove "will unlock" comment
  hostfs: move HOSTFS_SUPER_MAGIC to <linux/magic.h>
  hostfs: use kmalloc instead of kzalloc

 fs/hostfs/hostfs_kern.c    | 8 ++++----
 include/uapi/linux/magic.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.8.1.2


