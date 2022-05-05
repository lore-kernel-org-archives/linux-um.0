Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmhkX-0005ka-Lp
 for linux-um@lists.infradead.org; Thu, 05 May 2022 20:07:05 +0000
Date: Thu, 5 May 2022 22:06:34 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v3 04/15] modpost: move *.mod.c generation to
 write_mod_c_files()
Message-ID: <YnQuSlb9EbjWJ1WI@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-5-masahiroy@kernel.org>
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

On Thu, May 05, 2022 at 04:22:33PM +0900 Masahiro Yamada wrote:
> A later commit will add more code to this list_for_each_entry loop.
> 
> Before that, move the loop body into a separate helper function.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v3:
>   - New patch
> 
>  scripts/mod/modpost.c | 56 ++++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index ae8e4a4dcfd2..78a7107fcc40 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2347,6 +2347,34 @@ static void write_if_changed(struct buffer *b, const char *fname)
>  	write_buf(b, fname);
>  }
>  
> +/* do sanity checks, and generate *.mod.c file */
> +static void write_mod_c_file(struct module *mod)
> +{
> +	struct buffer buf = { };
> +	char fname[PATH_MAX];
> +	int ret;
> +
> +	check_modname_len(mod);
> +	check_exports(mod);
> +
> +	add_header(&buf, mod);
> +	add_versions(&buf, mod);
> +	add_depends(&buf, mod);
> +	add_moddevtable(&buf, mod);
> +	add_srcversion(&buf, mod);
> +
> +	ret = snprintf(fname, sizeof(fname), "%s.mod.c", mod->name);
> +	if (ret >= sizeof(fname)) {
> +		error("%s: too long path was truncated\n", fname);
> +		goto free;
> +	}
> +
> +	write_if_changed(&buf, fname);
> +
> +free:
> +	free(buf.p);
> +}
> +
>  /* parse Module.symvers file. line format:
>   * 0x12345678<tab>symbol<tab>module<tab>export<tab>namespace
>   **/
> @@ -2462,7 +2490,6 @@ struct dump_list {
>  int main(int argc, char **argv)
>  {
>  	struct module *mod;
> -	struct buffer buf = { };
>  	char *missing_namespace_deps = NULL;
>  	char *dump_write = NULL, *files_source = NULL;
>  	int opt;
> @@ -2524,30 +2551,11 @@ int main(int argc, char **argv)
>  		read_symbols_from_files(files_source);
>  
>  	list_for_each_entry(mod, &modules, list) {
> -		char fname[PATH_MAX];
> -		int ret;
> -
> -		if (mod->is_vmlinux || mod->from_dump)
> -			continue;
> -
> -		buf.pos = 0;
> -
> -		check_modname_len(mod);
> -		check_exports(mod);
> -
> -		add_header(&buf, mod);
> -		add_versions(&buf, mod);
> -		add_depends(&buf, mod);
> -		add_moddevtable(&buf, mod);
> -		add_srcversion(&buf, mod);
> -
> -		ret = snprintf(fname, sizeof(fname), "%s.mod.c", mod->name);
> -		if (ret >= sizeof(fname)) {
> -			error("%s: too long path was truncated\n", fname);
> +		if (mod->from_dump)
>  			continue;
> -		}
>  
> -		write_if_changed(&buf, fname);
> +		if (!mod->is_vmlinux)
> +			write_mod_c_file(mod);
>  	}
>  
>  	if (missing_namespace_deps)
> @@ -2563,7 +2571,5 @@ int main(int argc, char **argv)
>  		warn("suppressed %u unresolved symbol warnings because there were too many)\n",
>  		     nr_unresolved - MAX_UNRESOLVED_REPORTS);
>  
> -	free(buf.p);
> -
>  	return error_occurred ? 1 : 0;
>  }
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

