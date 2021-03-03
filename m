Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 3 Mar 2021 09:34:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: lkml delivery: was: Re: [PATCH next v4 00/15] printk: remove
 logbuf_lock
Message-ID: <20210303093421.2b9c936a@gandalf.local.home>
In-Reply-To: <YD+MpccJp4gX6bOP@alley>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
 <YD+MpccJp4gX6bOP@alley>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, Kees Cook <keescook@chromium.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jordan Niethe <jniethe5@gmail.com>, Alistair Popple <alistair@popple.id.au>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Wei Li <liwei391@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net, "K. Y. Srinivasan  <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger" <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Michael Kelley <mikelley@microsoft.com>, linux-hyperv@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
List-ID: <linux-um.lists.infradead.org>

On Wed, 3 Mar 2021 14:18:29 +0100
Petr Mladek <pmladek@suse.com> wrote:

> Hi John,
> 
> On Wed 2021-03-03 11:15:13, John Ogness wrote:
> > Hello,
> > 
> > Here is v4 of a series to remove @logbuf_lock, exposing the
> > ringbuffer locklessly to both readers and writers. v3 is
> > here [0].  
> 
> Have you got some reply from lkml that it has not delivered there,
> please?

vger has been having some issues as of late, and emails have been coming in
slowly. I just received emails I sent more than 24 hours a head of time.
Those in charge are trying to work things out.

-- Steve

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

