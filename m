Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7yN-00082m-KZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:47 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7yM-0000J0-QO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:47 +0000
Date: Thu, 18 Aug 2011 20:09:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7yF-0007w6-Qp@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 64/91] um: move asm/desc.h into
	arch/x86/um/asm
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


its only purpose is to shadow the x86 asm/desc.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/{um/include => x86/um}/asm/desc.h |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/{um/include => x86/um}/asm/desc.h (100%)

diff --git a/arch/um/include/asm/desc.h b/arch/x86/um/asm/desc.h
similarity index 100%
rename from arch/um/include/asm/desc.h
rename to arch/x86/um/asm/desc.h
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

