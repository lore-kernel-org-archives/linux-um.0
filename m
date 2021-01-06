Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kx04H-0005wi-Pt
 for linux-um@lists.infradead.org; Wed, 06 Jan 2021 04:05:07 +0000
Received: by mail-pl1-x630.google.com with SMTP id r4so888688pls.11
 for <linux-um@lists.infradead.org>; Tue, 05 Jan 2021 20:05:04 -0800 (PST)
Date: Wed, 6 Jan 2021 13:04:57 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: kunit stopped working
Message-ID: <X/U26cwfHTMYJTtU@jagdpanzerIV.localdomain>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <X/SRA1P8t+ONZFKb@alley> <X/SYhBZyudfnKY1u@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/SYhBZyudfnKY1u@alley>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-um <linux-um@lists.infradead.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, KUnit Development <kunit-dev@googlegroups.com>

On (21/01/05 17:49), Petr Mladek wrote:
> The following change solved the problem for me as well. It causes
> that ttynull is initialized after stdiocons console.
> 
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index eced70ec54e1..602af4d30bd4 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -121,7 +121,6 @@ static void __exit ttynull_exit(void)
>  	tty_port_destroy(&ttynull_port);
>  }
>  
> -module_init(ttynull_init);
> -module_exit(ttynull_exit);
> +late_initcall_sync(ttynull_init);
>  
>  MODULE_LICENSE("GPL v2");
> 
> But I am not completely sure that it is the right solution.

Wow, hmm, puzzled. Why does it help?

> It is strange. Console should get registered only when
> it was added by add_preferred_console(). It means that
> ttynull_init() should not register by default.
[..]
> Some clue might be in stderr_console. It has
> to be explicitly unregistered to avoid staying as
> the default console, see unregister_stderr() in
> arch/um/drivers/stderr_console.c

Hmm... Some random thoughts:

Looking at arch/um/drivers/stderr_console.c - it doesn't have tty
driver and it doesn't register one. So as far as console_device()
concerned we still don't have a workable console - it will return
NULL to tty_lookup_driver(), which will eventually return an error
to filp_open("/dev/console"); hence we'd call register_ttynull_console()
from console_on_rootfs(). So now we register ttynull as preferred
console; hence when another console attempts to register itself we
don't set CON_CONSDEV on it, because of `has_preferred_console`.

But I still don't understand why the initcall patch helped.
Can you shed some light on it?

	-ss

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

