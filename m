Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Honggang Li <enjoymindful@gmail.com>
Date: Thu,  5 Jun 2014 12:15:23 +0800
Message-Id: <1401941724-6703-1-git-send-email-enjoymindful@gmail.com>
In-Reply-To: <538F275B.7000508@nod.at>
References: <538F275B.7000508@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH linux-next] remove csum_partial_copy_generic_i386 to clean up exception table
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org, Honggang Li <enjoymindful@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The csum_partial_copy_generic_i386 never been called. It mess up x86 uml kernel
exception table. So remove it.

linux-next]$ grep -n -r  csum_partial_copy_generic_i386 .
./arch/x86/um/checksum_32.S:249:csum_partial_copy_generic_i386:
./arch/x86/um/checksum_32.S:384:csum_partial_copy_generic_i386:

Honggang Li (1):
  remove csum_partial_copy_generic_i386 to clean up exception table

 arch/x86/um/checksum_32.S | 239 ----------------------------------------------
 1 file changed, 239 deletions(-)

-- 
1.8.3.1

