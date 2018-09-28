Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]
 helo=smtprelay.hostedemail.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g60t3-0001Vg-DC
 for linux-um@lists.infradead.org; Fri, 28 Sep 2018 22:05:27 +0000
From: Joe Perches <joe@perches.com>
Subject: Bad MAINTAINERS pattern in section 'USER-MODE LINUX (UML)'
Date: Fri, 28 Sep 2018 15:05:07 -0700
Message-Id: <20180928220507.31886-1-joe@perches.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	15491	USER-MODE LINUX (UML)
	15492	M:	Jeff Dike <jdike@addtoit.com>
	15493	M:	Richard Weinberger <richard@nod.at>
	15494	L:	linux-um@lists.infradead.org
	15495	W:	http://user-mode-linux.sourceforge.net
	15496	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
	15497	S:	Maintained
	15498	F:	Documentation/virtual/uml/
	15499	F:	arch/um/
	15500	F:	arch/x86/um/
	15501	F:	fs/hostfs/
-->	15502	F:	fs/hppfs/

Commit that introduced this:

commit 679655daffdd2725b66ba2c5a759bbcb316fca5a
 Author: Joe Perches <joe@perches.com>
 Date:   Tue Apr 7 20:44:32 2009 -0700
 
     MAINTAINERS - Add file patterns
     
     Better description of file pattern tag "F:"
     Add file exclusion tag "X:"
     Add patterns to sections
     
     Signed-off-by: Joe Perches <joe@perches.com>
 
  MAINTAINERS | 1194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
  1 file changed, 1193 insertions(+), 1 deletion(-)

Last commit with fs/hppfs/

commit f74a14e870c80d6261afed66d4bad779c1213e03
Author: Richard Weinberger <richard@nod.at>
Date:   Tue Apr 21 20:52:26 2015 +0200

    um: Remove hppfs
    
    hppfs (honeypot procfs) was an attempt to use UML as honeypot.
    It was never stable nor in heavy use.
    
    As Al Viro and Christoph Hellwig pointed some major issues out
    it is better to let it die.
    
    Signed-off-by: Richard Weinberger <richard@nod.at>

 arch/um/Kconfig.um |  15 --
 fs/Makefile        |   1 -
 fs/hppfs/Makefile  |   6 -
 fs/hppfs/hppfs.c   | 766 -----------------------------------------------------
 4 files changed, 788 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

