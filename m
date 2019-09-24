Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Tue, 24 Sep 2019 11:51:27 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1] seccomp: simplify secure_computing()
Message-ID: <20190924095127.GE19317@zn.tnic>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190924064420.6353-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190924064420.6353-1-christian.brauner@ubuntu.com>
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
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: linux-s390@vger.kernel.org, wad@chromium.org, keescook@chromium.org, linux-parisc@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, oleg@redhat.com, luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

On Tue, Sep 24, 2019 at 08:44:20AM +0200, Christian Brauner wrote:
> Afaict, the struct seccomp_data argument to secure_computing() is unused
> by all current callers. So let's remove it.
> The argument was added in [1]. It was added because having the arch
> supply the syscall arguments used to be faster than having it done by
> secure_computing() (cf. Andy's comment in [2]). This is not true anymore
> though.
> 
> /* References */
> [1]: 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
> [2]: https://lore.kernel.org/r/CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: x86@kernel.org
> ---
> /* v1 */
> - Borislav Petkov <bp@alien8.de>:
>   - provide context for the arg addition to secure_computing() in the
>     commit message
> 
> /* v0 */
> Link: https://lore.kernel.org/r/20190920131907.6886-1-christian.brauner@ubuntu.com
> ---
>  arch/arm/kernel/ptrace.c              | 2 +-
>  arch/arm64/kernel/ptrace.c            | 2 +-
>  arch/parisc/kernel/ptrace.c           | 2 +-
>  arch/s390/kernel/ptrace.c             | 4 ++--
>  arch/um/kernel/skas/syscall.c         | 2 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
>  include/linux/seccomp.h               | 6 +++---
>  7 files changed, 10 insertions(+), 10 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

