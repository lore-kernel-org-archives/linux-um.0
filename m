Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmi0N-0009Cq-HV
 for linux-um@lists.infradead.org; Thu, 05 May 2022 20:23:27 +0000
Date: Thu, 5 May 2022 22:22:49 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v3 10/15] genksyms: adjust the output format to modpost
Message-ID: <YnQyGUlhvUIZwoNy@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-11-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-11-masahiroy@kernel.org>
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
Cc: linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, linux-s390@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>

On Thu, May 05, 2022 at 04:22:39PM +0900 Masahiro Yamada wrote:
> Make genksyms output symbol versions in the format modpost expects,
> so the 'sed' is unneeded.
> 
> This commit makes *.symversions completely unneeded.
> 
> I will keep *.symversions in .gitignore and 'make clean' for a while.
> Otherwise, some people might be upset with 'git status'.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>   - New patch
> 
>  scripts/Makefile.build      | 6 ------
>  scripts/genksyms/genksyms.c | 3 +--
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index dff9220135c4..461998a2ad2b 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -165,16 +165,10 @@ ifdef CONFIG_MODVERSIONS
>  # o modpost will extract versions from that file and create *.c files that will
>  #   be compiled and linked to the kernel and/or modules.
>  
> -genksyms_format := __crc_\(.*\) = \(.*\);
> -
>  gen_symversions =								\
>  	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
>  		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
> -		    > $@.symversions;						\
> -		sed -n 's/$(genksyms_format)/$(pound)SYMVER \1 \2/p' $@.symversions \
>  			>> $(dot-target).cmd;					\
> -	else									\
> -		rm -f $@.symversions;						\
>  	fi
>  
>  cmd_gen_symversions_c =	$(call gen_symversions,c)
> diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
> index 6e6933ae7911..f5dfdb9d80e9 100644
> --- a/scripts/genksyms/genksyms.c
> +++ b/scripts/genksyms/genksyms.c
> @@ -680,8 +680,7 @@ void export_symbol(const char *name)
>  		if (flag_dump_defs)
>  			fputs(">\n", debugfile);
>  
> -		/* Used as a linker script. */
> -		printf("__crc_%s = 0x%08lx;\n", name, crc);
> +		printf("#SYMVER %s 0x%08lx\n", name, crc);
>  	}
>  }
>  
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

