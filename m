Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <39e063ad-208d-f5f0-9807-eedcf0db1692@infradead.org>
Date: Fri, 26 Aug 2022 13:35:13 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] arch: um: Mark the stack non-executable to fix a binutils
 warning
Content-Language: en-US
References: <20220823010830.2675419-1-davidgow@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220823010830.2675419-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, x86@kernel.org



On 8/22/22 18:08, David Gow wrote:
> Since binutils 2.39, ld will print a warning if any stack section is
> executable, which is the default for stack sections on files without a
> .note.GNU-stack section.
> 
> This was fixed for x86 in commit ffcf9c5700e4 ("x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments"),
> but remained broken for UML, resulting in several warnings:
> 
> /usr/bin/ld: warning: arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
> /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing .note.GNU-stack section implies executable stack
> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
> /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing .note.GNU-stack section implies executable stack
> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
> 
> Link both the VDSO and vmlinux with -z noexecstack, fixing the warnings
> about .note.GNU-stack sections. In addition, pass --no-warn-rwx-segments
> to dodge the remaining warnings about LOAD segments with RWX permissions
> in the kallsyms objects. (Note that this flag is apparently not
> available on lld, so hide it behind a test for BFD, which is what the
> x86 patch does.)
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffcf9c5700e49c0aee42dcba9a12ba21338e8136
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/um/Makefile          | 9 ++++++++-
>  arch/x86/um/vdso/Makefile | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)


-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

