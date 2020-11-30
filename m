Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjhro-0000W4-1j
 for linux-um@lists.infradead.org; Mon, 30 Nov 2020 12:01:17 +0000
Message-ID: <0eb098cf6a82e6656e2179a0f43cc014d437e271.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 30 Nov 2020 13:00:57 +0100
In-Reply-To: <41545b47-bf98-f520-c832-4cbe4145b745@kot-begemot.co.uk>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <9cc47f08-2ca2-d4df-d0b0-09552a9a209b@kot-begemot.co.uk>
 <d60986af3d7065c2a0f9052083e4526b5f64aada.camel@sipsolutions.net>
 <41545b47-bf98-f520-c832-4cbe4145b745@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

Sorry, looks like I forgot to reply to this earlier.

On Tue, 2020-11-24 at 22:36 +0000, Anton Ivanov wrote:

> > > > @@ -151,73 +171,33 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
> > > >    		goto out;
> > > >    
> > > >    	spin_lock_irqsave(&irq_lock, flags);
> > > > -
> > > > -	/* Check if we have an entry for this fd */
> > > > -
> > > > -	err = -EBUSY;
> > > > -	for (irq_entry = active_fds;
> > > > -		irq_entry != NULL; irq_entry = irq_entry->next) {
> > > > -		if (irq_entry->fd == fd)
> > > > -			break;
> > > > -	}
> > > > -
> > > > -	if (irq_entry == NULL) {
> > > > -		/* This needs to be atomic as it may be called from an
> > > > -		 * IRQ context.
> > > > -		 */
> > > > -		irq_entry = kmalloc(sizeof(struct irq_entry), GFP_ATOMIC);
> > > > -		if (irq_entry == NULL) {
> > > > -			printk(KERN_ERR
> > > > -				"Failed to allocate new IRQ entry\n");
> > > > +	irq_entry = get_irq_entry_by_fd(fd);
> > > > +	if (irq_entry) {
> > > 
> > > This is not right.
> > > 
> > > You can re-register the same IRQ/fd, but with a different mask - f.e.
> > > turn on/off write or read on the same fd. F.E. - you have registered a
> > > read IRQ, you after that register same IRQ for write and you can alter
> > > the mask.
> > 
> > Hmm. You snipped some code, and it continued like this:
> > 
> >          irq_entry = get_irq_entry_by_fd(fd);
> >          if (irq_entry) {
> >                  /* cannot register the same FD twice with the same type */
> >                  if (WARN_ON(irq_entry->reg[type].events)) {
> >                          // basically return -EALREADY
> > 
> > 
> > I'm not sure I see this is different from what it was before? If the
> 
> The original intention was to be able to do it :)

To do _what_ exactly? You said to re-register the same FD, but you could
do that before by unregistering?

And read/write are completely separate entries anyway. You cannot do
both at the same time (they're not bitmasks, just enum values.)

In fact, you *can* still use the same FD for both, with and without this
patch. We find the irq_entry here (by FD), and then check if this type
of event is already used. That means you cannot register for READ for
the same FD twice, but using the other event (WRITE) is still fine.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

