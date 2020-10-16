Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTYfA-00078A-Db
 for linux-um@lists.infradead.org; Fri, 16 Oct 2020 22:57:29 +0000
Received: by mail-wm1-x343.google.com with SMTP id f21so3804010wml.3
 for <linux-um@lists.infradead.org>; Fri, 16 Oct 2020 15:57:25 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH resend v3 0/2] Broad write-locking of nascent mm in execve
Date: Sat, 17 Oct 2020 00:57:11 +0200
Message-Id: <20201016225713.1971256-1-jannh@google.com>
MIME-Version: 1.0
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
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Michel Lespinasse <walken@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Johannes Berg <johannes@sipsolutions.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

(resending because DKIM got mangled on the first try by the kvack
list, hopefully setting sendemail.transferEncoding to
quoted-printable helps...)

v3:
 - add note about how this also fixes arch/um/ locking in patch 1
   (Johannes Berg)
 - use IS_DEFINED() instead of #ifdef in patch 2 (Jason Gunthorpe)
v2:
 - fix commit message of patch 1/2 and be more verbose about where
   the old mmap lock is taken (Michel, Jason)
 - resending without mangling the diffs :/ (Michel, Jason)

These two patches replace "mmap locking API: don't check locking
if the mm isn't live yet"[1], which is currently in the mmotm tree,
and should be placed in the same spot where the old patch was.

While I originally said that this would be an alternative
patch (meaning that the existing patch would have worked just
as well), the new patches actually address an additional issue
that the old patch missed (bprm->vma is used after the switch
to the new mm).

I have boot-tested these patches on x64-64 (with lockdep) and
!MMU arm (the latter with both FLAT and ELF).

[1] https://lkml.kernel.org/r/CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com

Jann Horn (2):
  mmap locking API: Order lock of nascent mm outside lock of live mm
  exec: Broadly lock nascent mm until setup_arg_pages()

 arch/um/include/asm/mmu_context.h |  3 +-
 fs/exec.c                         | 64 ++++++++++++++++---------------
 include/linux/binfmts.h           |  2 +-
 include/linux/mmap_lock.h         | 23 ++++++++++-
 kernel/fork.c                     |  7 +---
 5 files changed, 59 insertions(+), 40 deletions(-)


base-commit: fb0155a09b0224a7147cb07a4ce6034c8d29667f
prerequisite-patch-id: 08f97130a51898a5f6efddeeb5b42638577398c7
prerequisite-patch-id: 577664d761cd23fe9031ffdb1d3c9ac313572c67
prerequisite-patch-id: dc29a39716aa8689f80ba2767803d9df3709beaa
prerequisite-patch-id: 42b1b546d33391ead2753621f541bcc408af1769
prerequisite-patch-id: 2cbb839f57006f32e21f4229e099ae1bd782be24
prerequisite-patch-id: 1b4daf01cf61654a5ec54b5c3f7c7508be7244ee
prerequisite-patch-id: f46cc8c99f1909fe2a65fbc3cf1f6bc57489a086
prerequisite-patch-id: 2b0caed97223241d5008898dde995d02fda544e4
prerequisite-patch-id: 6b7adcb54989e1ec3370f256ff2c35d19cf785aa
-- 
2.29.0.rc1.297.gfa9743e501-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

