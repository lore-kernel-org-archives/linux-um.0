Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-11.nifty.com ([210.131.2.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1floTn-0001xb-5M
 for linux-um@lists.infradead.org; Sat, 04 Aug 2018 04:47:52 +0000
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] Kbuild: fix and clean-up arch/um/Makefile
Date: Sat,  4 Aug 2018 13:47:00 +0900
Message-Id: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
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
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>


1/3 fixes the build failure reported by Randy.
(I may have seen a similar report before, but I cannot recall it.)

2/3 and 3/3 clean-up the Makefile a bit more.

I'd like to apply this series to kbuild tree.
Ack from UML folks are appreciated.



Masahiro Yamada (3):
  um: fix parallel building with O= option
  kbuild: add %asm-generic to no-dot-config-targets
  um: clean up archheaders recipe

 Makefile         | 2 +-
 arch/um/Makefile | 9 +--------
 2 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

