Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krc47-0001of-B9
 for linux-um@lists.infradead.org; Tue, 22 Dec 2020 07:26:40 +0000
Received: by mail-lf1-x12a.google.com with SMTP id b26so20173652lff.9
 for <linux-um@lists.infradead.org>; Mon, 21 Dec 2020 23:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20201221144302.GR4077@smile.fi.intel.com>
 <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
In-Reply-To: <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Tue, 22 Dec 2020 15:26:24 +0800
Message-ID: <CABVgOSnGnFf_LUhcbPxDYYq8q1f3aC228k2kas8=uXMvwVORLQ@mail.gmail.com>
Subject: Re: kunit stopped working
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-um <linux-um@lists.infradead.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Johannes Berg <johannes@sipsolutions.net>, Guenter Roeck <linux@roeck-us.net>, KUnit Development <kunit-dev@googlegroups.com>

On Tue, Dec 22, 2020 at 9:43 AM David Gow <davidgow@google.com> wrote:
>
> On Tue, Dec 22, 2020 at 4:02 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Dec 21, 2020 at 09:40:08PM +0200, Andy Shevchenko wrote:
> > > +Cc people from culprit commit
> >
> > Guys, revert helps. I am open to test any solution you may propose, thanks!
> >
> > ...
> >
> > > # first bad commit: [757055ae8dedf5333af17b3b5b4b70ba9bc9da4e] init/console: Use ttynull as a fallback when there is no console
> >
> > --
>
> +CC linux-um
>
> There appear to be two problems here:
> 1. UML now no longer has console output by default (which KUnit needs
> to get results)
> 2. UML now seems to crash on startup when ttynull is used (which is now default)

Whoops. I was wrong about number 2 here (thanks Johannes for pointing
that out). The segfault in n_tty_open() actually happens normally as
part of UML startup, and it's recovered from perfectly.

So the only real issue is that this is changing the default console
output to ttynull, and hence hiding the output.

>
> This can be worked around for KUnit by passing console=tty to the
> kernel. I don't think this is a "correct" fix, as UML seems to be
> crashing out-of-the-box anyway (see below), but it may be worth us
> forcing this as we require the console output as well.
>
> In any case, this patch fixes it in kunit_tool for now. I may submit
> this as a proper patch anyway, but that won't fix UML in general:
>
> diff --git a/tools/testing/kunit/kunit_kernel.py
> b/tools/testing/kunit/kunit_kernel.py
> index 57c1724b7e5d..698358c9c0d6 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -198,7 +198,7 @@ class LinuxSourceTree(object):
>                return self.validate_config(build_dir)
>
>        def run_kernel(self, args=[], build_dir='', timeout=None):
> -               args.extend(['mem=1G'])
> +               args.extend(['mem=1G', 'console=tty'])
>                self._ops.linux_bin(args, timeout, build_dir)
>                outfile = get_outfile_path(build_dir)
>                subprocess.call(['stty', 'sane'])
>

I'll send this out properly as a patch to kunit_tool: while I still
think that the default console on UML shouldn't change, it probably
makes sense for KUnit to not rely on the default.

Cheers,
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

