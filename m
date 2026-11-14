Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A9606A331
	for <linux-um@archiver.kernel.org>; Sat, 14 Nov 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Axu7LQBX;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=I8r0O3zb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=usIPslq1cfT97Mm83gdtb2Vu2a+gdviQvXX9W9YM1v8=; b=Axu7LQBXgrmlFDIbtPy+N2vi8I
	youyYsSXNEEQW3i9jUs/TSXt19lM/02j9LpU8JmIlJoh5bu8x2Tuh7Cv0Dc0DbPvBJrS7fHSAG1Sd
	aEPJoefPiAaeSmXT2e7vNgFcOXMI48PmE3pqSN6zS0ECh5t4QPvT3YidXU3c+hyl2ilA8Bvq43uBx
	NAl8mVbLBA3p9JcJFQusoGoiPrmhkl/MPkd1736gWFua+MZQ5K0pAhIhOgq9GIrmiaor6lEkF78AX
	LT+uwxZ74ebB1tqj9LUERSPMVwON34BI6QIQedujmprfEfC811Up2xQ7l24cOYNzi5/ye8Ds7AnAe
	IUeF2KRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSImw-0000000Gd4d-34be;
	Sat, 14 Nov 2026 18:47:46 +0000
Received: from mail.virtlab.unibo.it ([2001:760:2e00:f0a1::32])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSIms-0000000Gd3H-3Vca
	for linux-um@lists.infradead.org;
	Sat, 14 Nov 2026 18:47:45 +0000
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 84A081C0145;
	Sat, 14 Nov 2026 19:47:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794682049;
	bh=4OoxQ6arIeZu/vN+Ihq9aApJ9I0DFUIQBpN7zRBlfZw=;
	h=From:To:Cc:Subject:Date:From;
	b=I8r0O3zbGw34mgT2X1Qre//qmSTh3gOeexo8EaGTtv1ZazwUCTNcO/YfjfCGKTnCG
	 +Qjgrxy6JEZ9aPs6zu1KrZAdFabi1gHaSujHV+wLlPncx8IFQ48giOpWqp6GIm7RYO
	 oGb/EWxerDf355sdx1T0uRv3Ywp3mhxUq8KzFGYg=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	strace-devel@lists.strace.io,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Brian Cain <bcain@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org
Subject: [PATCH v4 0/3] ptrace_set_syscall_info: add support for instruction pointer modification
Date: Sat, 14 Nov 2026 19:47:15 +0100
Message-ID: <20261114184720.373178-1-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_104743_073787_17C796C8 
X-CRM114-Status: GOOD (  20.95  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
PTRACE_GET_SYSCALL_INFO by allowing a tracer to modify details of a
system call in which the tracee is currently blocked.

The API is designed to let tracers inspect and modify system call
information in a simple, architecture-agnostic manner.

The current implementation only supports modifying the subset of
system call information needed by strace: the system call number,
arguments, and return value.

This patch set extends PTRACE_SET_SYSCALL_INFO with support for
modifying the tracee's instruction pointer.

To do this, the tracer stores the new instruction pointer value in the
instruction_pointer field of the ptrace_syscall_info structure and
sets the PTRACE_SYSCALL_INFO_FLAG_SET_IP flag in the flags field.

This flag is introduced to avoid breaking existing code that uses
PTRACE_SET_SYSCALL_INFO and currently ignores the
instruction_pointer field.

The proposal does not add any new ptrace capability. It merely provides a
portable interface for a capability that already exists and is already relied
upon by existing applications.

WHY

PTRACE_SYSCALL_INFO_FLAG_SET_IP completes the set of actions that a tracer can
request when intercepting a system call.

A tracer can currently instruct a tracee to:

* execute the original system call;
* execute a different system call (or the same system call with modified arguments);
* skip the system call and provide the desired return value and/or errno.

The proposed PTRACE_SYSCALL_INFO_FLAG_SET_IP adds a fourth possibility:
* execute an arbitrary sequence of two or more system calls in place of the original one.

The mechanism is straightforward. During a PTRACE_SYSCALL_INFO_EXIT stop, the
tracer rewinds the instruction pointer to the system call instruction (e.g. by
2 bytes on x86-64 for syscall, or by the appropriate amount on other
architectures). When the tracee resumes, it immediately generates a new
syscall-entry stop, allowing the tracer to provide a new system call number and
arguments. By repeating this process, a tracer can transparently replace a
single system call with any sequence of system calls.

This capability already exists on all architectures through
architecture-specific interfaces such as PTRACE_POKEUSER, PTRACE_SETREGS, or
PTRACE_SETREGSET. PTRACE_SYSCALL_INFO_FLAG_SET_IP does not introduce a new
capability; it merely exposes an existing one through the portable
PTRACE_GET_SYSCALL_INFO/PTRACE_SET_SYSCALL_INFO API.

WHO

The VUOS project uses this mechanism extensively.
VUOS provides namespace-like execution environments implemented entirely in
user space, without relying on kernel namespaces.
https://wiki.virtualsquare.org/#/tutorials/vuosbasics

For example, VUOS allows unprivileged processes to use user-space
implementations of filesystems (FUSE), networking stacks, virtual devices, and
other resources.

To improve scalability on multicore systems, VUOS implements what we call the
guardian angel model: each traced thread has its own dedicated tracer thread.
This avoids a single tracer becoming a bottleneck.

When a traced thread creates a child, ownership of the new tracee must be
transferred to a newly created guardian angel. This requires delaying execution
of the child's first system call until the new tracer has attached.

The current implementation proceeds as follows:
* save the original system call number and arguments;
* replace the system call with a blocking ppoll(NULL, 0, NULL, NULL) call;
* detach the original tracer;
* attach the new guardian angel using PTRACE_SEIZE;
* interrupt the blocking ppoll() with PTRACE_INTERRUPT;
* at the subsequent syscall-exit stop, rewind the instruction pointer to the system call instruction;
* at the following syscall-entry stop, restore the original system call number and arguments.

This mechanism is currently implemented using architecture-specific register
manipulation. PTRACE_SYSCALL_INFO_FLAG_SET_IP would allow the same
implementation to be written using the portable ptrace syscall information API.

Although VUOS is the primary motivation for this proposal, the feature is
generally useful for any project implementing ptrace-based system call
interposition, including PRoot, strace's syscall injection machinery, and
similar frameworks.

This patchset is a new version of the proposed patchset entitled:
ptrace_set_syscall_info: add support for seccomp syscall skipping and
instruction pointer modification

The patchset has been split in two:
syscall skipping (previously sent)
instruction pointer modification (this)

This patch series depends on the syscall-skipping series:
[PATCH v11 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp syscall skipping
https://lore.kernel.org/lkml/20261114181923.370930-1-renzo@cs.unibo.it/

This series is based on top of v11 of that series and should be applied
after it.

The prerequisite series is currently not in mainline.

Testing (QEMU, v7.4-rc2 with v11 of the syscall-skipping series,
tools/testing/selftests/ptrace/set_syscall_info):

                               x86_64 (KVM)
  ptrace/set_syscall_info      3/3

Changes in v04:
* rebased to Linux 7.4-rc2, on top of v11 of the syscall-skipping series
* ptrace: adapted to the syscall-skipping series, where a
  PTRACE_SYSCALL_INFO_SECCOMP stop turned into a PTRACE_SYSCALL_INFO_EXIT
  one is handled by ptrace_set_syscall_info_seccomp_skip();
  PTRACE_SYSCALL_INFO_FLAG_SET_IP applies to that case too
* ptrace: check that the new instruction pointer fits in an unsigned long
  before changing any register, so that -ERANGE leaves the tracee untouched
* selftests/ptrace/set_syscall_info.c: checkpatch fixes in the
  PTRACE_SYSCALL_INFO_FLAG_SET_IP test case

Changes in v03:
rebased to Linux 7.3-rc1

Changes in v02:
compatibility issues with updated syscall skipping
set_syscall_info selftest: improve error messages

Renzo Davoli (3):
  asm/ptrace.h: add instruction_pointer_set
  ptrace: add PTRACE_SYSCALL_INFO_FLAG_SET_IP
  selftests/ptrace: add a test case for PTRACE_SYSCALL_INFO_FLAG_SET_IP

 arch/alpha/include/asm/ptrace.h               |   6 +
 arch/hexagon/include/asm/ptrace.h             |   6 +
 arch/m68k/include/asm/ptrace.h                |   6 +
 arch/microblaze/include/asm/ptrace.h          |   6 +
 arch/nios2/include/asm/ptrace.h               |   6 +
 arch/um/include/asm/ptrace-generic.h          |   6 +
 arch/xtensa/include/asm/ptrace.h              |   6 +
 include/uapi/linux/ptrace.h                   |   4 +
 kernel/ptrace.c                               |  38 ++--
 .../selftests/ptrace/set_syscall_info.c       | 173 ++++++++++++++++++
 10 files changed, 247 insertions(+), 10 deletions(-)

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
prerequisite-patch-id: bad42bc3bb8ed701597b19c4de6b76e5bab93895
prerequisite-patch-id: 1b2e63fe71203031ae67a78e49b091369f8de5e1
prerequisite-patch-id: 2135a43ed9d9539fb21b5e2539ef35e959251ab6
-- 
2.47.3


