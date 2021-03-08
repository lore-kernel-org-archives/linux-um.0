Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 8 Mar 2021 16:09:24 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH next v4 00/15] printk: remove logbuf_lock
Message-ID: <YEY+JBoW6TByix30@alley>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
 <YD+seF3dQUoPcZP7@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YD+seF3dQUoPcZP7@alley>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, Kees Cook <keescook@chromium.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jordan Niethe <jniethe5@gmail.com>, Alistair Popple <alistair@popple.id.au>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Wei Li <liwei391@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Michael Kelley <mikelley@microsoft.com>, linux-hyperv@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
List-ID: <linux-um.lists.infradead.org>

On Wed 2021-03-03 16:34:19, Petr Mladek wrote:
> On Wed 2021-03-03 11:15:13, John Ogness wrote:
> > Hello,
> > 
> > Here is v4 of a series to remove @logbuf_lock, exposing the
> > ringbuffer locklessly to both readers and writers. v3 is
> > here [0].
> 
> The series look ready. I am going to push it into printk/linux.git
> the following week unless anyone speaks against it in the meantime.

The series is committed in printk/linux.git, branch printk-rework.

Best Regards,
Petr

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

