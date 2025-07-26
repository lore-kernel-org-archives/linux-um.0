Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C9C87FCA
	for <linux-um@archiver.kernel.org>; Sat, 26 Jul 2025 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3Xsf8BwNfX+9WQapyUmLR6LbHjEJWolG21G8mCBRHLw=; b=wb6ZbS09dkE12CUq4pT3rMoGVy
	jHYlyTPISlvxK6Vown7kmkDONnb3UeY1OZvkVlWtmg8ds0sOLIx4dDtV4o4mPE0+0UGymbTKQCRhb
	c3+W3gl2u20CPU6ILc+y7whr/mSIyqX+SFOCkQnYgyowvfDduzRQgy7Cv7ABp2qTa9ByMcfJ26Iq3
	I7BJ3xNzMAZ+ubJuaj+bAThzO6Tuxqd0JWSNYU8tgUVvFPGMI3cKMGGPn4Xgge7HOHx990pl9/Yx9
	kxiG3fu/rVpQ7Ms0x0Fjf893w/zk6E2AgqjIO3QlIdVqz3WnSAPGCCXmLtQcMY8w+HCcvkxCpiuH6
	6gU1WGEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufmc2-0000000Bwug-0KIP;
	Sat, 26 Jul 2025 21:39:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufmbz-0000000Bwtf-0OnQ;
	Sat, 26 Jul 2025 21:39:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DDE2A5C136A;
	Sat, 26 Jul 2025 21:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8BEC4CEED;
	Sat, 26 Jul 2025 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753565960;
	bh=bE8gOgUvTZi4vI0lg9qUYLnf/GEXOkxooNHihx3vuJw=;
	h=Date:From:To:Cc:Subject:From;
	b=XHrb3axiSsGzIoF2z2Ix7pQjSMf1Hy42ar894fKLOABDtiMSiJhU7EOw7iJrgd6tB
	 IbaRdb5qeWEpZin3fRvADFhKWu6rwXZK251hn0vmJbDMaGw9ALbzwGt5jlO4g1Ev/5
	 38kyT5jk9ILeJA/C732uod/apU+rxyQj7EYgW1D/FfLwRv3xciKcU+EEYDtA1K1HQw
	 89qGLSJb5I1UF5EVZNysHbVA4poyaagUpDWiSn+7w1Wkxrul3aS8xbgWpQmDVmq97o
	 1XX7DFiDUydJ2ZJduymhDp4XdKL9MxP2XYT1rwFJYEc0IFFTjUHBVSjh8qB39SdIcg
	 FmVRs5hgMDysg==
Date: Sat, 26 Jul 2025 14:39:20 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andreas Larsson <andreas@gaisler.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Dishank Jogi <dishank.jogi@siqol.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonas Bonn <jonas@southpole.se>, Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org, loongarch@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>,
	Russell King <linux@armlinux.org.uk>, sparclinux@vger.kernel.org,
	Stafford Horne <shorne@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>,
	x86@kernel.org, Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [GIT PULL] execve updates for v6.17
Message-ID: <202507261437.F2079B3B7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_143923_204470_3EC8C280 
X-CRM114-Status: GOOD (  12.24  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Linus,

Please pull these execve updates for v6.17. Note that while the REGSET
macro changes touch all the architectures, they are fairly mechanical
and have been in linux-next for almost the entire development window.

Thanks!

-Kees

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.17

for you to fetch changes up to 7f71195c15dcf5f34c4c7f056603659374e3a525:

  fork: reorder function qualifiers for copy_clone_args_from_user (2025-07-17 16:37:05 -0700)

----------------------------------------------------------------
execve updates for v6.17

- Introduce regular REGSET note macros arch-wide (Dave Martin)

- Remove arbitrary 4K limitation of program header size (Yin Fengwei)

- Reorder function qualifiers for copy_clone_args_from_user() (Dishank Jogi)

----------------------------------------------------------------
Dave Martin (23):
      regset: Fix kerneldoc for struct regset_get() in user_regset
      regset: Add explicit core note name in struct user_regset
      binfmt_elf: Dump non-arch notes with strictly matching name and type
      ARC: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      ARM: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      arm64: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      csky: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      hexagon: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      LoongArch: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      m68k: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      MIPS: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      nios2: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      openrisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      parisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      powerpc/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      riscv: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      s390/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      sh: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      sparc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      x86/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      um: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      xtensa: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
      binfmt_elf: Warn on missing or suspicious regset note names

Dishank Jogi (1):
      fork: reorder function qualifiers for copy_clone_args_from_user

Yin Fengwei (1):
      binfmt_elf: remove the 4k limitation of program header size

 include/linux/regset.h                   | 12 +++++-
 arch/arc/kernel/ptrace.c                 |  4 +-
 arch/arm/kernel/ptrace.c                 |  6 +--
 arch/arm64/kernel/ptrace.c               | 52 +++++++++++-----------
 arch/csky/kernel/ptrace.c                |  4 +-
 arch/hexagon/kernel/ptrace.c             |  2 +-
 arch/loongarch/kernel/ptrace.c           | 16 +++----
 arch/m68k/kernel/ptrace.c                |  4 +-
 arch/mips/kernel/ptrace.c                | 20 ++++-----
 arch/nios2/kernel/ptrace.c               |  2 +-
 arch/openrisc/kernel/ptrace.c            |  4 +-
 arch/parisc/kernel/ptrace.c              |  8 ++--
 arch/powerpc/kernel/ptrace/ptrace-view.c | 74 ++++++++++++++++----------------
 arch/riscv/kernel/ptrace.c               | 12 +++---
 arch/s390/kernel/ptrace.c                | 42 +++++++++---------
 arch/sh/kernel/ptrace_32.c               |  4 +-
 arch/sparc/kernel/ptrace_32.c            |  4 +-
 arch/sparc/kernel/ptrace_64.c            |  8 ++--
 arch/x86/kernel/ptrace.c                 | 22 +++++-----
 arch/x86/um/ptrace.c                     | 10 ++---
 arch/xtensa/kernel/ptrace.c              |  4 +-
 fs/binfmt_elf.c                          | 38 ++++++++++------
 fs/binfmt_elf_fdpic.c                    | 17 ++++----
 kernel/fork.c                            |  2 +-
 24 files changed, 196 insertions(+), 175 deletions(-)

-- 
Kees Cook

