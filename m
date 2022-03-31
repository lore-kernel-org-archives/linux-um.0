Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 30 Mar 2022 21:57:43 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] kbuild: Remove '-mno-global-merge'
Message-ID: <202203302156.87918948B8@keescook>
References: <20220330234528.1426991-1-nathan@kernel.org>
 <20220330234528.1426991-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330234528.1426991-2-nathan@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, llvm@lists.linux.dev, patches@lists.linux.dev
List-ID: <linux-um.lists.infradead.org>

On Wed, Mar 30, 2022 at 04:45:27PM -0700, Nathan Chancellor wrote:
> This flag is specific to clang, where it is only used by the 32-bit and
> 64-bit ARM backends. In certain situations, the presence of this flag
> will cause a warning, as shown by commit 6580c5c18fb3 ("um: clang: Strip
> out -mno-global-merge from USER_CFLAGS").
> 
> Since commit 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for
> building kernel with Clang") that added this flag back in 2014, there
> have been quite a few changes to the GlobalMerge pass in LLVM. Building
> several different ARCH=arm and ARCH=arm64 configurations with LLVM 11
> (minimum) and 15 (current main version) with this flag removed (i.e.,
> with the default of '-mglobal-merge') reveals no modpost warnings, so it
> is likely that the issue noted in the comment is no longer relevant due
> to changes in LLVM or modpost, meaning this flag can be removed.
> 
> If any new warnings show up that are a result of the removal of this
> flag, it can be added back under arch/arm{,64}/Makefile to avoid
> warnings on other architectures.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Yeah, this looks right -- the history of this option seems to show it
is no longer needed.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

