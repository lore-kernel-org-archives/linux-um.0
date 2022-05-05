Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmi6l-000Brt-93
 for linux-um@lists.infradead.org; Thu, 05 May 2022 20:30:03 +0000
Date: Thu, 5 May 2022 22:29:23 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v3 14/15] kbuild: make built-in.a rule robust against too
 long argument error
Message-ID: <YnQzox0FyZuGmRQ0@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-15-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-15-masahiroy@kernel.org>
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

On Thu, May 05, 2022 at 04:22:43PM +0900 Masahiro Yamada wrote:
> Kbuild runs at the top of objtree instead of changing the working
> directory to subdirectories. I think this design is nice overall but
> some commands have a scapability issue.
> 
> The build command of built-in.a is one of them whose length scales with:
> 
>     O(D * N)
> 
> Here, D is the length of the directory path (i.e. $(obj)/ prefix),
> N is the number of objects in the Makefile, O() is the big O notation.
> 
> The deeper directory the Makefile directory is located, the more easily
> it will hit the too long argument error.
> 
> We can make it better. Trim the $(obj)/ by Make's builtin function, and
> restore it by a shell command (sed).
> 
> With this, the command length scales with:
> 
>     O(D + N)
> 
> In-tree modules still have some room to the limit (ARG_MAX=2097152),
> but this is more future-proof for big modules in a deep directory.
> 
> For example, you can build i915 as builtin (CONFIG_DRM_I915=y) and
> compare drivers/gpu/drm/i915/.built-in.a.cmd with/without this commit.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>   - New patch
> 
>  scripts/Makefile.build | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 0436ff94800e..cea48762299c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -370,7 +370,10 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
>  #
>  
>  quiet_cmd_ar_builtin = AR      $@
> -      cmd_ar_builtin = rm -f $@; $(AR) cDPrST $@ $(real-prereqs)
> +      cmd_ar_builtin = rm -f $@; \
> +		echo $(patsubst $(obj)/%,%,$(real-prereqs)) | \
> +		sed -E 's:([^ ]+):$(obj)/\1:g' | \
> +		xargs $(AR) cDPrST $@
>  
>  $(obj)/built-in.a: $(real-obj-y) FORCE
>  	$(call if_changed,ar_builtin)
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

