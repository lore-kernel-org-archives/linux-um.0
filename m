Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 30 Mar 2022 21:58:02 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] Revert "um: clang: Strip out -mno-global-merge from
 USER_CFLAGS"
Message-ID: <202203302158.BEAB17240@keescook>
References: <20220330234528.1426991-1-nathan@kernel.org>
 <20220330234528.1426991-3-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330234528.1426991-3-nathan@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, llvm@lists.linux.dev, patches@lists.linux.dev
List-ID: <linux-um.lists.infradead.org>

On Wed, Mar 30, 2022 at 04:45:28PM -0700, Nathan Chancellor wrote:
> This reverts commit 6580c5c18fb3df2b11c5e0452372f815deeff895.
> 
> This patch is buggy, as noted in the patch linked below. The root cause
> has been solved by removing '-mno-global-merge' for the entire kernel.
> 
> Link: https://lore.kernel.org/r/20220322173547.677760-1-nathan@kernel.org/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

