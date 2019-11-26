Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Tue, 26 Nov 2019 08:25:28 -0800
From: Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] seccomp updates for v5.5-rc1
Message-ID: <201911260818.9C5DC1E@keescook>
MIME-Version: 1.0
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Song Liu <songliubraving@fb.com>, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Shuah Khan <shuah@kernel.org>, linux-s390@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>, Daniel Borkmann <daniel@iogearbox.net>, kernel test robot <rong.a.chen@intel.com>, x86@kernel.org, Yonghong Song <yhs@fb.com>, Borislav Petkov <bp@suse.de>, linux-um@lists.infradead.org, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org, David Abdurachmanov <david.abdurachmanov@sifive.com>, netdev@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tyler Hicks <tyhicks@canonical.com>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>
List-ID: <linux-um.lists.infradead.org>

Hi Linus,

Please pull these seccomp updates for v5.5-rc1. Mostly this is
implementing the new flag SECCOMP_USER_NOTIF_FLAG_CONTINUE, but there
are cleanups as well. Most notably, the secure_computing() prototype
has changed (to remove an unused argument), but this has happened at the
same time as riscv adding seccomp support, so the cleanest merge order
would be to merge riscv first, then seccomp with the following patch for
riscv to handle the change from "seccomp: simplify secure_computing()":

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 0f84628b9385..407464201b91 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -159,7 +159,7 @@ __visible void do_syscall_trace_enter(struct pt_regs *regs)
 	 * If this fails we might have return value in a0 from seccomp
 	 * (via SECCOMP_RET_ERRNO/TRACE).
 	 */
-	if (secure_computing(NULL) == -1) {
+	if (secure_computing() == -1) {
 		syscall_set_nr(current, regs, -1);
 		return;
 	}

Thanks!

-Kees

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.5-rc1

for you to fetch changes up to 23b2c96fad21886c53f5e1a4ffedd45ddd2e85ba:

  seccomp: rework define for SECCOMP_USER_NOTIF_FLAG_CONTINUE (2019-10-28 12:29:46 -0700)

----------------------------------------------------------------
seccomp updates for v5.5

- implement SECCOMP_USER_NOTIF_FLAG_CONTINUE (Christian Brauner)
- fixes to selftests (Christian Brauner)
- remove secure_computing() argument (Christian Brauner)

----------------------------------------------------------------
Christian Brauner (6):
      seccomp: avoid overflow in implicit constant conversion
      seccomp: add SECCOMP_USER_NOTIF_FLAG_CONTINUE
      seccomp: test SECCOMP_USER_NOTIF_FLAG_CONTINUE
      seccomp: simplify secure_computing()
      seccomp: fix SECCOMP_USER_NOTIF_FLAG_CONTINUE test
      seccomp: rework define for SECCOMP_USER_NOTIF_FLAG_CONTINUE

 arch/arm/kernel/ptrace.c                      |   2 +-
 arch/arm64/kernel/ptrace.c                    |   2 +-
 arch/parisc/kernel/ptrace.c                   |   2 +-
 arch/s390/kernel/ptrace.c                     |   2 +-
 arch/um/kernel/skas/syscall.c                 |   2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c         |   2 +-
 include/linux/seccomp.h                       |   6 +-
 include/uapi/linux/seccomp.h                  |  29 +++++++
 kernel/seccomp.c                              |  28 +++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 110 +++++++++++++++++++++++++-
 10 files changed, 169 insertions(+), 16 deletions(-)

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

