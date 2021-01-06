Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kx8Zr-00042K-MZ
 for linux-um@lists.infradead.org; Wed, 06 Jan 2021 13:10:16 +0000
Date: Wed, 6 Jan 2021 14:10:10 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: kunit stopped working
Message-ID: <X/W2sl7RMvfaV4Ru@alley>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <X/SRA1P8t+ONZFKb@alley> <X/SYhBZyudfnKY1u@alley>
 <X/U26cwfHTMYJTtU@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/U26cwfHTMYJTtU@jagdpanzerIV.localdomain>
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-um <linux-um@lists.infradead.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, KUnit Development <kunit-dev@googlegroups.com>

On Wed 2021-01-06 13:04:57, Sergey Senozhatsky wrote:
> On (21/01/05 17:49), Petr Mladek wrote:
> > The following change solved the problem for me as well. It causes
> > that ttynull is initialized after stdiocons console.
> > 
> > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > index eced70ec54e1..602af4d30bd4 100644
> > --- a/drivers/tty/ttynull.c
> > +++ b/drivers/tty/ttynull.c
> > @@ -121,7 +121,6 @@ static void __exit ttynull_exit(void)
> >  	tty_port_destroy(&ttynull_port);
> >  }
> >  
> > -module_init(ttynull_init);
> > -module_exit(ttynull_exit);
> > +late_initcall_sync(ttynull_init);
> >  
> >  MODULE_LICENSE("GPL v2");
> > 
> > But I am not completely sure that it is the right solution.
> 
> Wow, hmm, puzzled. Why does it help?

I have been as well. But it seems that I got it, see below.

> > It is strange. Console should get registered only when
> > it was added by add_preferred_console(). It means that
> > ttynull_init() should not register by default.
> [..]
> > Some clue might be in stderr_console. It has
> > to be explicitly unregistered to avoid staying as
> > the default console, see unregister_stderr() in
> > arch/um/drivers/stderr_console.c
> 
> Hmm... Some random thoughts:
> 
> Looking at arch/um/drivers/stderr_console.c - it doesn't have tty
> driver and it doesn't register one.

stderr_console.c is used only during early boot.

stdio_console.c is the console that is supposed to print kunit
test results. And it has tty driver.

> But I still don't understand why the initcall patch helped.
> Can you shed some light on it?

The trick is that both stdio_init() and ttynull_init():

  + call register_console()
  + the console has tty driver

The first one is registered as a fallback when there is
no preferred console (has_preferred_console()).

It means that late_initcall_sync(ttynull_init) makes sense.
We need to call register_console() from ttynull_init() so that
it is registered when defined on the command line. But it should
be the last chance to register a fallback console with tty binding.

Alternative solution is to ignore ttynull as the fallback console
in register_console(). I mean the following:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ffdd0dc7ec6d..cdb77903b0af 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2816,8 +2816,12 @@ void register_console(struct console *newcon)
 	 *	See if we want to use this console driver. If we
 	 *	didn't select a console we take the first one
 	 *	that registers here.
+	 *
+	 *	Ignore ttynull console. It should be used only
+	 *	when explicitly configured or as an ultimate
+	 *	fallback when no better console gets registered at all.
 	 */
-	if (!has_preferred_console) {
+	if (!has_preferred_console && strcmp(newcon->name, "ttynull") != 0) {
 		if (newcon->index < 0)
 			newcon->index = 0;
 		if (newcon->setup == NULL ||


Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

