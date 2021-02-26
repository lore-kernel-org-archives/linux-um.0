Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH next v3 12/15] printk: introduce a kmsg_dump iterator
In-Reply-To: <20210225202438.28985-13-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-13-john.ogness@linutronix.de>
Date: Fri, 26 Feb 2021 08:59:10 +0100
Message-ID: <87a6rrxnsh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
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
Cc: linux-hyperv@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Douglas Anderson <dianders@chromium.org>, Paul Mackerras <paulus@samba.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Thomas Meyer <thomas@m3y3r.de>, Vignesh Raghavendra <vigneshr@ti.com>, Wei Liu <wei.liu@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Stephen Hemminger <sthemmin@microsoft.com>, kernel test robot <lkp@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Anton Vorontsov <anton@enomsg.org>, clang-built-linux@googlegroups.com, Joel Stanley <joel@jms.id.au>, Jason Wessel <jason.wessel@windriver.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Wei Li <liwei391@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Kees Cook <keescook@chromium.org>, Alistair Popple <alistair@popple.id.au>, Jeff Dike <jdike@addtoit.com>, Colin Cross <ccross@android.com>, linux-um@lists.infradead.org, Daniel Thompson <daniel.thompson@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Davidlohr Bueso <dave@stgolabs.net>, Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jordan Niethe <jniethe5@gmail.com>, Michael Kelley <mikelley@microsoft.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Tony Luck <tony.luck@intel.com>, kbuild-all@lists.01.org, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Richard Weinberger <richard@nod.at>, kgdb-bugreport@lists.sourceforge.net, linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>

Hello,

Thank you kernel test robot!

Despite all of my efforts to carefully construct and test this series,
somehome I managed to miss a compile test with CONFIG_MTD_OOPS. That
kmsg_dumper does require the dumper parameter so that it can use
container_of().

I will discuss this with the printk team. But most likely we will just
re-instate the dumper parameter in the callback.

I apologize for the lack of care on my part.

John Ogness

On 2021-02-26, kernel test robot <lkp@intel.com> wrote:
> Hi John,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on next-20210225]
>
> url:    https://github.com/0day-ci/linux/commits/John-Ogness/printk-remove-logbuf_lock/20210226-043457
> base:    7f206cf3ec2bee4621325cfacb2588e5085c07f5
> config: arm-randconfig-r024-20210225 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a921aaf789912d981cbb2036bdc91ad7289e1523)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/0day-ci/linux/commit/fc7f655cded40fc98ba5304c200e3a01e8291fb4
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review John-Ogness/printk-remove-logbuf_lock/20210226-043457
>         git checkout fc7f655cded40fc98ba5304c200e3a01e8291fb4
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> drivers/mtd/mtdoops.c:277:45: error: use of undeclared identifier 'dumper'
>            struct mtdoops_context *cxt = container_of(dumper,
>                                                       ^
>>> drivers/mtd/mtdoops.c:277:45: error: use of undeclared identifier 'dumper'
>>> drivers/mtd/mtdoops.c:277:45: error: use of undeclared identifier 'dumper'
>    3 errors generated.
>
>
> vim +/dumper +277 drivers/mtd/mtdoops.c
>
> 4b23aff083649e Richard Purdie 2007-05-29  274  
> fc7f655cded40f John Ogness    2021-02-25  275  static void mtdoops_do_dump(enum kmsg_dump_reason reason)
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  276  {
> 2e386e4bac9055 Simon Kagstrom 2009-11-03 @277  	struct mtdoops_context *cxt = container_of(dumper,
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  278  			struct mtdoops_context, dump);
> fc7f655cded40f John Ogness    2021-02-25  279  	struct kmsg_dump_iter iter;
> fc2d557c74dc58 Seiji Aguchi   2011-01-12  280  
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  281  	/* Only dump oopses if dump_oops is set */
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  282  	if (reason == KMSG_DUMP_OOPS && !dump_oops)
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  283  		return;
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  284  
> fc7f655cded40f John Ogness    2021-02-25  285  	kmsg_dump_rewind(&iter);
> fc7f655cded40f John Ogness    2021-02-25  286  
> df92cad8a03e83 John Ogness    2021-02-25  287  	if (test_and_set_bit(0, &cxt->oops_buf_busy))
> df92cad8a03e83 John Ogness    2021-02-25  288  		return;
> fc7f655cded40f John Ogness    2021-02-25  289  	kmsg_dump_get_buffer(&iter, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
> e2ae715d66bf4b Kay Sievers    2012-06-15  290  			     record_size - MTDOOPS_HEADER_SIZE, NULL);
> df92cad8a03e83 John Ogness    2021-02-25  291  	clear_bit(0, &cxt->oops_buf_busy);
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  292  
> c1cf1d57d14922 Mark Tomlinson 2020-09-03  293  	if (reason != KMSG_DUMP_OOPS) {
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  294  		/* Panics must be written immediately */
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  295  		mtdoops_write(cxt, 1);
> c1cf1d57d14922 Mark Tomlinson 2020-09-03  296  	} else {
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  297  		/* For other cases, schedule work to write it "nicely" */
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  298  		schedule_work(&cxt->work_write);
> 2e386e4bac9055 Simon Kagstrom 2009-11-03  299  	}
> c1cf1d57d14922 Mark Tomlinson 2020-09-03  300  }
> 4b23aff083649e Richard Purdie 2007-05-29  301  
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

