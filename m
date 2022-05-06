Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nn6hZ-005Go8-KR
 for linux-um@lists.infradead.org; Fri, 06 May 2022 22:45:34 +0000
Date: Fri, 6 May 2022 15:45:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 00/15] kbuild: yet another series of cleanups
 (modpost, LTO, MODULE_REL_CRCS)
Message-ID: <YnWlCH2tfr5YMb1/@dev-arch.thelio-3990X>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
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
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org, Nicolas Schier a <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, linux-s390@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>

Hi Masahiro,

On Thu, May 05, 2022 at 04:22:29PM +0900, Masahiro Yamada wrote:
> 
> This is the third batch of cleanups in this development cycle.
> 
> Major changes in v3:
> 
>  - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.
> 
> Major changes in v2:
> 
>  - V1 did not work with CONFIG_MODULE_REL_CRCS.
>    I fixed this for v2.
> 
>  - Reflect some review comments in v1
> 
>  - Refactor the code more
> 
>  - Avoid too long argument error
> 
> 
> Masahiro Yamada (15):
>   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
>   modpost: change the license of EXPORT_SYMBOL to bool type
>   modpost: merge add_{intree_flag,retpoline,staging_flag} to add_header
>   modpost: move *.mod.c generation to write_mod_c_files()
>   kbuild: generate a list of objects in vmlinux
>   kbuild: record symbol versions in *.cmd files
>   modpost: extract symbol versions from *.cmd files
>   kbuild: link symbol CRCs at final link, removing
>     CONFIG_MODULE_REL_CRCS
>   kbuild: stop merging *.symversions
>   genksyms: adjust the output format to modpost
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
>   modpost: simplify the ->is_static initialization
>   modpost: use hlist for hash table implementation
>   kbuild: make built-in.a rule robust against too long argument error
>   kbuild: make *.mod rule robust against too long argument error

I merged this series into mainline and tested an Arch Linux
x86_64 configuration and Fedora aarch64 configuration with ThinLTO and
saw no new warnings or issues. Modules loaded just fine in QEMU for Arch
Linux and I did not notice any boot issues or warnings.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

