Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmi4U-000Ay2-Ib
 for linux-um@lists.infradead.org; Thu, 05 May 2022 20:27:42 +0000
Date: Thu, 5 May 2022 22:27:04 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v3 12/15] modpost: simplify the ->is_static initialization
Message-ID: <YnQzGMfWqnP6CMir@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-13-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-13-masahiroy@kernel.org>
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

On Thu, May 05, 2022 at 04:22:41PM +0900 Masahiro Yamada wrote:
> ->is_static is set to true at allocation, then to false if the symbol
> comes from the dump file.
> 
> It is simpler to use !mod->from_dump as the init value.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>   - New patch
> 
>  scripts/mod/modpost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index e07542a90fc6..4edd5b223f49 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -242,7 +242,7 @@ static struct symbol *alloc_symbol(const char *name)
>  
>  	memset(s, 0, sizeof(*s));
>  	strcpy(s->name, name);
> -	s->is_static = true;
> +
>  	return s;
>  }
>  
> @@ -376,6 +376,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
>  
>  	s = alloc_symbol(name);
>  	s->module = mod;
> +	s->is_static = !mod->from_dump;
>  	s->is_gpl_only = gpl_only;
>  	list_add_tail(&s->list, &mod->exported_symbols);
>  	hash_add_symbol(s);
> @@ -2523,7 +2524,6 @@ static void read_dump(const char *fname)
>  			mod->from_dump = true;
>  		}
>  		s = sym_add_exported(symname, mod, gpl_only);
> -		s->is_static = false;
>  		sym_set_crc(s, crc);
>  		sym_update_namespace(symname, namespace);
>  	}
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

