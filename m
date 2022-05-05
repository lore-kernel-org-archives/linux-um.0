Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmhd7-0003xt-DR
 for linux-um@lists.infradead.org; Thu, 05 May 2022 19:59:25 +0000
Date: Thu, 5 May 2022 21:58:52 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v3 03/15] modpost: merge
 add_{intree_flag,retpoline,staging_flag} to add_header
Message-ID: <YnQsfA8kHDDpnBcU@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-4-masahiroy@kernel.org>
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

On Thu, May 05, 2022 at 04:22:32PM +0900 Masahiro Yamada wrote:
> add_intree_flag(), add_retpoline(), and add_staging_flag() are small
> enough to be merged into add_header().
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v3:
>   - New patch
> 
>  scripts/mod/modpost.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index ebd80c77fa03..ae8e4a4dcfd2 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2200,25 +2200,17 @@ static void add_header(struct buffer *b, struct module *mod)
>  			      "#endif\n");
>  	buf_printf(b, "\t.arch = MODULE_ARCH_INIT,\n");
>  	buf_printf(b, "};\n");
> -}
>  
> -static void add_intree_flag(struct buffer *b, int is_intree)
> -{
> -	if (is_intree)
> +	if (!external_module)
>  		buf_printf(b, "\nMODULE_INFO(intree, \"Y\");\n");
> -}
>  
> -/* Cannot check for assembler */
> -static void add_retpoline(struct buffer *b)
> -{
> -	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
> -	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
> -	buf_printf(b, "#endif\n");
> -}
> +	buf_printf(b,
> +		   "\n"
> +		   "#ifdef CONFIG_RETPOLINE\n"
> +		   "MODULE_INFO(retpoline, \"Y\");\n"
> +		   "#endif\n");
>  
> -static void add_staging_flag(struct buffer *b, const char *name)
> -{
> -	if (strstarts(name, "drivers/staging"))
> +	if (strstarts(mod->name, "drivers/staging"))
>  		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
>  }
>  
> @@ -2544,9 +2536,6 @@ int main(int argc, char **argv)
>  		check_exports(mod);
>  
>  		add_header(&buf, mod);
> -		add_intree_flag(&buf, !external_module);
> -		add_retpoline(&buf);
> -		add_staging_flag(&buf, mod->name);
>  		add_versions(&buf, mod);
>  		add_depends(&buf, mod);
>  		add_moddevtable(&buf, mod);
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

