Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h1df8-0006dv-Jq
 for linux-um@lists.infradead.org; Wed, 06 Mar 2019 21:01:19 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] arch: um: Kconfig: pedantic cleanups
Date: Wed, 06 Mar 2019 22:01:01 +0100
Message-ID: <31062067.NyzppZ7ELz@blindfold>
In-Reply-To: <1551896897-30963-1-git-send-email-info@metux.net>
References: <1551896897-30963-1-git-send-email-info@metux.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com

Am Mittwoch, 6. M=E4rz 2019, 19:28:17 CET schrieb Enrico Weigelt, metux IT =
consult:

Can we please have a changelog?

Thanks,
//richard

> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/um/Kconfig | 52 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> =

> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index ec9711d..216ee50 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -80,46 +80,46 @@ config LD_SCRIPT_DYN
>  	bool
>  	default y
>  	depends on !LD_SCRIPT_STATIC
> -        select MODULE_REL_CRCS if MODVERSIONS
> +	select MODULE_REL_CRCS if MODVERSIONS
>  =

>  config HOSTFS
>  	tristate "Host filesystem"
>  	help
> -          While the User-Mode Linux port uses its own root file system f=
or
> -          booting and normal file access, this module lets the UML user
> -          access files stored on the host.  It does not require any
> -          network connection between the Host and UML.  An example use of
> -          this might be:
> +	  While the User-Mode Linux port uses its own root file system for
> +	  booting and normal file access, this module lets the UML user
> +	  access files stored on the host.  It does not require any
> +	  network connection between the Host and UML.  An example use of
> +	  this might be:
>  =

> -          mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
> +	  mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
>  =

> -          where /tmp/fromhost is an empty directory inside UML and
> -          /tmp/umlshare is a directory on the host with files the UML us=
er
> -          wishes to access.
> +	  where /tmp/fromhost is an empty directory inside UML and
> +	  /tmp/umlshare is a directory on the host with files the UML user
> +	  wishes to access.
>  =

> -          For more information, see
> -          <http://user-mode-linux.sourceforge.net/hostfs.html>.
> +	  For more information, see
> +	  <http://user-mode-linux.sourceforge.net/hostfs.html>.
>  =

> -          If you'd like to be able to work with files stored on the host,
> -          say Y or M here; otherwise say N.
> +	  If you'd like to be able to work with files stored on the host,
> +	  say Y or M here; otherwise say N.
>  =

>  config MCONSOLE
>  	bool "Management console"
>  	depends on PROC_FS
>  	default y
>  	help
> -          The user mode linux management console is a low-level interfac=
e to
> -          the kernel, somewhat like the i386 SysRq interface.  Since the=
re is
> -          a full-blown operating system running under every user mode li=
nux
> -          instance, there is much greater flexibility possible than with=
 the
> -          SysRq mechanism.
> -
> -          If you answer 'Y' to this option, to use this feature, you nee=
d the
> -          mconsole client (called uml_mconsole) which is present in CVS =
in
> -          2.4.5-9um and later (path /tools/mconsole), and is also in the
> -          distribution RPM package in 2.4.6 and later.
> -
> -          It is safe to say 'Y' here.
> +	  The user mode linux management console is a low-level interface to
> +	  the kernel, somewhat like the i386 SysRq interface.  Since there is
> +	  a full-blown operating system running under every user mode linux
> +	  instance, there is much greater flexibility possible than with the
> +	  SysRq mechanism.
> +
> +	  If you answer 'Y' to this option, to use this feature, you need the
> +	  mconsole client (called uml_mconsole) which is present in CVS in
> +	  2.4.5-9um and later (path /tools/mconsole), and is also in the
> +	  distribution RPM package in 2.4.6 and later.
> +
> +	  It is safe to say 'Y' here.
>  =

>  config MAGIC_SYSRQ
>  	bool "Magic SysRq key"
> =






_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

