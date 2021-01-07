Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxPVn-0001gK-MT
 for linux-um@lists.infradead.org; Thu, 07 Jan 2021 07:15:12 +0000
Received: by mail-pl1-x630.google.com with SMTP id s15so3016546plr.9
 for <linux-um@lists.infradead.org>; Wed, 06 Jan 2021 23:15:10 -0800 (PST)
Date: Thu, 7 Jan 2021 16:15:04 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: kunit stopped working
Message-ID: <X/a0+Cb6xFZOEk7x@jagdpanzerIV.localdomain>
References: <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <X/SRA1P8t+ONZFKb@alley> <X/SYhBZyudfnKY1u@alley>
 <X/U26cwfHTMYJTtU@jagdpanzerIV.localdomain>
 <X/W2sl7RMvfaV4Ru@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/W2sl7RMvfaV4Ru@alley>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-um <linux-um@lists.infradead.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, KUnit Development <kunit-dev@googlegroups.com>

On (21/01/06 14:10), Petr Mladek wrote:
> > > 
> > > But I am not completely sure that it is the right solution.
> > 
> > Wow, hmm, puzzled. Why does it help?
> 
> I have been as well. But it seems that I got it, see below.

Thanks!

[..]
> 
> Alternative solution is to ignore ttynull as the fallback console
> in register_console(). I mean the following:

I personally would prefer a very explicit fix (IOW, the patch below),
rather than relying on some initcall trickery (which has already
failed on us)

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ffdd0dc7ec6d..cdb77903b0af 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2816,8 +2816,12 @@ void register_console(struct console *newcon)
>  	 *	See if we want to use this console driver. If we
>  	 *	didn't select a console we take the first one
>  	 *	that registers here.
> +	 *
> +	 *	Ignore ttynull console. It should be used only
> +	 *	when explicitly configured or as an ultimate
> +	 *	fallback when no better console gets registered at all.
>  	 */
> -	if (!has_preferred_console) {
> +	if (!has_preferred_console && strcmp(newcon->name, "ttynull") != 0) {
>  		if (newcon->index < 0)
>  			newcon->index = 0;
>  		if (newcon->setup == NULL ||

So IIUC in case of ttynull fallback (console= ) we still end up setting
CON_CONSDEV on nulltty console, but we do it in try_enable_new_console().

Feel free to add
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

