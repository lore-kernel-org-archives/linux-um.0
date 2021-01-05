Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwpWB-0006xD-6g
 for linux-um@lists.infradead.org; Tue, 05 Jan 2021 16:49:12 +0000
Date: Tue, 5 Jan 2021 17:49:08 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: kunit stopped working
Message-ID: <X/SYhBZyudfnKY1u@alley>
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <X/SRA1P8t+ONZFKb@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/SRA1P8t+ONZFKb@alley>
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
To: David Gow <davidgow@google.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-um <linux-um@lists.infradead.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, KUnit Development <kunit-dev@googlegroups.com>

On Tue 2021-01-05 17:17:08, Petr Mladek wrote:
> On Tue 2020-12-22 09:43:48, David Gow wrote:
> > On Tue, Dec 22, 2020 at 4:02 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Dec 21, 2020 at 09:40:08PM +0200, Andy Shevchenko wrote:
> > > > +Cc people from culprit commit
> > >
> > > Guys, revert helps. I am open to test any solution you may propose, thanks!
> > >
> > > ...
> > >
> > > > # first bad commit: [757055ae8dedf5333af17b3b5b4b70ba9bc9da4e] init/console: Use ttynull as a fallback when there is no console
> > >
> > > --
> > 
> > +CC linux-um
> > 
> > There appear to be two problems here:
> > 1. UML now no longer has console output by default (which KUnit needs
> > to get results)
> 
> > This can be worked around for KUnit by passing console=tty to the
> > kernel. I don't think this is a "correct" fix
> 
> It is rather a workaround. ttynull was supposed to be an ultimate
> fallback to provide a "valid" stdin, stdout, and stderr for
> the init process. ttyX still should be used by default when
> there is no console defined on the command line.
> 
> So the question is why ttyX was not registered with this patch.
> 
> I see the problem even when I revert the commit
> 757055ae8dedf5333af ("init/console: Use ttynull as a fallback when
> there is no console") and enable the ttynull driver as built in:
> 
>      CONFIG_NULL_TTY=y
> 
> By other words, the problem existed even before. The commit only
> made it visible by default.
> 
> I am still trying to understand arch/um and kunit code. I wonder
> if it is somehow related to stdiocons implemented in
> arch/um/drivers/stdio_console.c.

The following change solved the problem for me as well. It causes
that ttynull is initialized after stdiocons console.

diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index eced70ec54e1..602af4d30bd4 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -121,7 +121,6 @@ static void __exit ttynull_exit(void)
 	tty_port_destroy(&ttynull_port);
 }
 
-module_init(ttynull_init);
-module_exit(ttynull_exit);
+late_initcall_sync(ttynull_init);
 
 MODULE_LICENSE("GPL v2");

But I am not completely sure that it is the right solution.

It is strange. Console should get registered only when
it was added by add_preferred_console(). It means that
ttynull_init() should not register by default.

Some clue might be in stderr_console. It has
to be explicitly unregistered to avoid staying as
the default console, see unregister_stderr() in
arch/um/drivers/stderr_console.c

I am going to dig more into it.

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

