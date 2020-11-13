Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 13 Nov 2020 23:20:04 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <588878911.301948.1605306004530.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] um fixes for 5.10-rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

Linus,

The following changes since commit eccc876724927ff3b9ff91f36f7b6b159e948f0c:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2020-11-10 10:33:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.10-rc4

for you to fetch changes up to 9a5085b3fad5d5d6019a3d160cdd70357d35c8b1:

  um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb() (2020-11-10 21:49:32 +0100)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Call PMD destructor in __pmd_free_tlb()

----------------------------------------------------------------
Richard Weinberger (1):
      um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()

 arch/um/include/asm/pgalloc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

