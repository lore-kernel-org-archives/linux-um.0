Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZD9I-0004r0-ES for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:13:00 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KZD9E-0004rU-5W
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:13:00 -0700
Date: Fri, 29 Aug 2008 16:12:55 -0700 (PDT)
From: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
Message-ID: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 0/6] support valgrinding uml
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jiayingz@google.com, dkegel@google.com

The following patches enables Valgrind to produce useful results for
User Mode Linux.  Valgrind requires some patches as well.  A list of
the limitations and a recipe for building and using everything can be
found on this page: http://uml.jfdi.org/uml/Wiki.jsp?page=ValgrindingUML

  Documentation/uml/valgrind-suppressions |   95
  arch/um/Makefile                        |    4
  arch/um/include/valgrind.h              |   12
  arch/um/kernel/physmem.c                |   21
  arch/um/kernel/process.c                |   31
  arch/um/kernel/skas/process.c           |    3
  arch/um/os-Linux/skas/process.c         |    7
  include/asm-um/thread_info.h            |    8
  include/linux/memcheck.h                |  285 ++
  include/linux/sched.h                   |    6
  include/linux/valgrind.h                | 3928 ++++++++++++++++++++++++++++++++
  lib/Kconfig.debug                       |   20
  mm/page_alloc.c                         |    4
  mm/slab.c                               |   20
  mm/vmalloc.c                            |   15
  15 files changed, 4456 insertions(+), 3 deletions(-)

--
Steve

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
