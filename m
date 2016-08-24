Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bceJE-0007TF-TK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Aug 2016 19:58:00 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bceJD-00053Q-LD
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Aug 2016 19:58:00 +0000
From: Richard Weinberger <richard@nod.at>
Message-ID: <27d788f7-ebf9-f131-a316-f5999fad9a8f@nod.at>
Date: Wed, 24 Aug 2016 21:57:39 +0200
MIME-Version: 1.0
Subject: [uml-devel] [GIT PULL] UML fixes for 4.8-rc4
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Linus,

The following changes since commit 7a1dcf6adaa7cc4b8cd93a3883267497a77b1051:

  Merge tag 'usercopy-v4.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux (2016-08-23 14:32:38 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.8-rc4

for you to fetch changes up to dad2232844073295c64e9cc2d734a0ade043e0f6:

  um: Don't discard .text.exit section (2016-08-23 23:16:16 +0200)

----------------------------------------------------------------
This pull request contains a fix for a build regression
introduced during the merge window.

----------------------------------------------------------------

Andrey Ryabinin (1):
      um: Don't discard .text.exit section

 arch/um/include/asm/common.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

