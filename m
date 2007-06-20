Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I111t-0007uT-LK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2007 07:19:29 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1I111p-0002qu-QI
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2007 07:19:29 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 20 Jun 2007 16:06:58 +0200
References: <20070619184245.GA10567@c2.user-mode-linux.org>
	<20070619195003.GA11718@c2.user-mode-linux.org>
	<20070619131441.01b5ae4b.akpm@linux-foundation.org>
In-Reply-To: <20070619131441.01b5ae4b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706201606.58331.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/2] UML - Add stack usage monitoring
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

On marted=EC 19 giugno 2007, Andrew Morton wrote:
> On Tue, 19 Jun 2007 15:50:03 -0400
>
> Jeff Dike <jdike@addtoit.com> wrote:
> > On Tue, Jun 19, 2007 at 11:54:22AM -0700, Andrew Morton wrote:
> > > On Tue, 19 Jun 2007 14:42:45 -0400
> > >
> > > Jeff Dike <jdike@addtoit.com> wrote:
> > > > Add a machanism to see how much of a kernel stack is used.  This
> > > > allocates zeroed stacks and sees where the lowest non-zero byte is =
on
> > > > process exit.  It keeps track of the lowest value and logs values as
> > > > they get lower.
> > >
> > > remind us again why the generic code is unsuitable?
> >
> > It does something different - it will tell you the greatest stack
> > usage of any currently running process.  What I want to be able to do
> > is run a workload and come back a few days later and see how close
> > anything came to running out of stack.
>
> <looks>
>
> wth?  I'm _sure_ we used to have code in there which would, within
> do_exit(), work out the maximum amount of kernel stack which a task had
> used and if that was max-since-boot, drop a printk.
>
> Maybe I dreamed it, but I don't think so.
>
> I wonder where it went?

Oh, it's exactly what CONFIG_DEBUG_STACK_USAGE does for i386... (not sure i=
f =

you were still wondering...).

> Oh well.  Your new code should really be generic, utilising the
> stack-page-zeroing which CONFIG_DEBUG_STACK_USAGE enables.  There's nothi=
ng
> UML-specific about it.

> low_water_lock and lowest_to_date should be static to check_stack_usage(),
> btw..

-- =

Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
