Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8a6Y-0004gr-L3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 00:30:14 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D8a6X-0001Tn-V1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 00:30:14 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050308082502.GB23067@bytesex>
References: <20041128010910.1b5478c7.akpm@osdl.org>
	<200503051858.05050.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503051858.05050.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Fw: [patch] uml: terminal cleanup
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 8 Mar 2005 09:25:03 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > -void register_winch(int fd, void *device_data)
> > +void register_winch(int fd, struct tty_struct *tty)
> >  {
> >   int pid, thread, thread_fd;
> >   int count;
> Hmm, I saw you have put a forward declaration of struct tty_struct, however it 
> does not seem nice anyway... I don't think that using void* is nice either, 
> but both things have pitfalls.

It's enougth to just have "struct tty_struct;" declared, at least for
code paths which don't access the elements of the the struct and just
pass it through (like the usermode code does in that case).  That
shouldn't create much trouble as you don't need the full tty_struct
declaration for the userspace code, but the compiler can still do type
checking on the arguments (thats why I didn't want it being void*).

> > -void line_close(struct line *lines, struct tty_struct *tty)
> > +void line_close(struct tty_struct *tty, struct file * filp)
> >  {
> > - struct line *line;
> > - int n;
> > -
> > - if(tty == NULL) n = 0;
> > - else n = tty->index;
> > - line = &lines[n];
> > + struct line *line = tty->driver_data;
> >
> >   down(&line->sem);
> >   line->count--;
> > -
> > - /* I don't like this, but I can't think of anything better.  What's
> > -  * going on is that the tty is in the process of being closed for
> > -  * the last time.  Its count hasn't been dropped yet, so it's still
> > -  * at 1.  This may happen when line->count != 0 because of the initial
> > -  * console open (without a tty) bumping it up to 1.
> > -  */
> > - if((line->tty != NULL) && (line->tty->count == 1))
> > -  line->tty = NULL;
> > - if(line->count == 0)
> > -  line_disable(line, -1);
> > + if (tty->count == 1) {

Hmm, while looking at this again, I think maybe this should be
"tty->count == 0" (it's _behind_ the line->count-- after all ...).
Guess you are writing me because you are trying to pin down a bug,
maybe that one is it ;)

> > +  line_disable(tty, -1);
> > +  tty->driver_data = NULL;
> > + }
> >   up(&line->sem);
> >  }
> Why did you delete this comment? I don't think you fixed the problem, you just 
> worked it around the other way...

No, it's fixed.

> Or better, you removed the initial console open, if it refers to the item #2 
> above... but the code isn't clean...

Yes, the hackish console open is gone, and thus the hack above which
attempts to care about that on close (but never really worked correctly)
is gone as well.

The old code used to use the stdio console device before it actually
registered the device in the tty layer, this is why these hacks used to
be in there.  Now the console device is registered after the stdio
console is initialized, and all the problems associated with that are
gone ;)

Drawback of that is that is that you don't see any messages until the
stdio console is initialized.  That isn't a big problem if the kernel
survives up to this point as the console code will simply print all
messages buffered up so far as soon as the console device is opened.
But if the kernel dies early you don't see the messages.  In that case
the new stderr console will help, which can be enabled with "stderr=1"
in the kernel cmd line (maybe additionally "console=stderr") and which
is simple enougth that it can register very early in the boot process.

HTH,

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
