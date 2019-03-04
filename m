Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from imap.cs.msu.ru ([188.44.42.39] helo=mail.cs.msu.ru)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h0qup-0000W1-Le
 for linux-um@lists.infradead.org; Mon, 04 Mar 2019 16:58:38 +0000
From: Arseny Maslennikov <ar@cs.msu.ru>
Date: Mon,  4 Mar 2019 19:57:29 +0300
Message-Id: <20190304165732.24043-1-ar@cs.msu.ru>
MIME-Version: 1.0
Subject: [PATCH 0/3] kbuild: More KCONFIG_CONFIG ignorance
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arseny Maslennikov <ar@cs.msu.ru>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org

Following a recent bug with `make *config' not supporting a redefined
kernel config file, I ran a `git grep -w -nE [.]config **/Makefile'
and discovered these:

Arseny Maslennikov (3):
  kconfig/Makefile: localmodconfig: use KCONFIG_CONFIG
  Makefile: kselftest: use KCONFIG_CONFIG
  arch/um/kernel/Makefile: use KCONFIG_CONFIG

 Makefile                 |  4 ++--
 arch/um/kernel/Makefile  |  2 +-
 scripts/kconfig/Makefile | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

