Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1isFHv-0007Dz-9S
 for linux-um@lists.infradead.org; Fri, 17 Jan 2020 00:15:01 +0000
Date: Fri, 17 Jan 2020 01:14:40 +0100
From: Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] um: Implement copy_thread_tls
Message-ID: <20200117001439.zshbw3anlzx3yzqd@wittgenstein>
References: <20200102172413.654385-1-amanieu@gmail.com>
 <20200104123928.1048822-1-amanieu@gmail.com>
 <20200105151928.qrmhnwer3r5ffc77@wittgenstein>
 <20200107123548.5fzu4v6czrlhrhmh@wittgenstein>
 <CAFLxGvzG4DJH5a7cAV6U+wPBqHUOJ6XQmy-u2ibawM3jsQXQBw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvzG4DJH5a7cAV6U+wPBqHUOJ6XQmy-u2ibawM3jsQXQBw@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Amanieu d'Antras <amanieu@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, Christian Brauner <christian@brauner.io>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Jan 17, 2020 at 01:12:31AM +0100, Richard Weinberger wrote:
> On Tue, Jan 7, 2020 at 1:36 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Sun, Jan 05, 2020 at 04:19:28PM +0100, Christian Brauner wrote:
> > > On Sat, Jan 04, 2020 at 01:39:30PM +0100, Amanieu d'Antras wrote:
> > > > This is required for clone3 which passes the TLS value through a
> > > > struct rather than a register.
> > > >
> > > > Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
> > > > Cc: linux-um@lists.infradead.org
> > > > Cc: <stable@vger.kernel.org> # 5.3.x
> > >
> > > Thanks. I'm picking this up as part of the copy_thread_tls() series.
> > > (Leaving the patch in tact so people can Ack right here if they want to.)
> > > If I could get an Ack from one of the maintainers that would be great;
> > > see
> > > https://lore.kernel.org/lkml/20200102172413.654385-1-amanieu@gmail.com
> > > for more context.
> > >
> > > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > I've this up as part of the series link in above ^^ and moved it into
> > https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=clone3_tls
> >
> > If I hear no objections I'll merge into into my fixes tree today or
> > tomorrow.
> >
> > An Ack from one of the maintainers would still be appreciated.
> 
> For sure too late, but better than nothing? ;-)
> 
> Acked-by: Richard Weinberger <richard@nod.at>

Still worth having it. :)

Thanks!
Christian

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

