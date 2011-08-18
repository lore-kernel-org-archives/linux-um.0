Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Aug 2011 20:13:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1Qu828-00088o-2X@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Subject: [PATCH 88/91] um: segment.h is x86-only and needed only
 there
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/{um/include => x86/um}/asm/segment.h |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/{um/include => x86/um}/asm/segment.h (100%)

diff --git a/arch/um/include/asm/segment.h b/arch/x86/um/asm/segment.h
similarity index 100%
rename from arch/um/include/asm/segment.h
rename to arch/x86/um/asm/segment.h
-- 
1.7.2.5


