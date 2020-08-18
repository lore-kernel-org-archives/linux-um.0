Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 18 Aug 2020 06:32:16 -0500
From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] char: ipmi: convert tasklets to use new tasklet_setup()
 API
Message-ID: <20200818113216.GD2842@minyard.net>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
 <20200817091617.28119-3-allen.cryptic@gmail.com>
 <20200817121514.GE2865@minyard.net>
 <CAOMdWSJXCn5KYHen4kynH1A5Oixo+yPzs3oathsfa8gtKZGkjg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMdWSJXCn5KYHen4kynH1A5Oixo+yPzs3oathsfa8gtKZGkjg@mail.gmail.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: minyard@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Allen <allen.lkml@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-atm-general@lists.sourceforge.net, manohar.vanga@gmail.com, airlied@linux.ie, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com, kys@microsoft.com, anton.ivanov@cambridgegreys.com, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux1394-devel@lists.sourceforge.net, maximlevitsky@gmail.com, richard@nod.at, deller@gmx.de, jassisinghbrar@gmail.com, 3chas3@gmail.com, intel-gfx@lists.freedesktop.org, Jakub Kicinski <kuba@kernel.org>, mporter@kernel.crashing.org, jdike@addtoit.com, Kees Cook <keescook@chromium.org>, oakad@yahoo.com, s.hauer@pengutronix.de, linux-input@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, broonie@kernel.org, openipmi-developer@lists.sourceforge.net, mitch@sfgoth.com, linux-arm-kernel@lists.infradead.org, axboe@kernel.dk, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, martyn@welchs.me.uk, dmitry.torokhov@gmail.com, linux-mmc@vger.kernel.org, sre@kernel.org, linux-spi@vger.kernel.org, alex.bou9@gmail.com, Allen Pais <allen.cryptic@gmail.com>, stefanr@s5r6.in-berlin.de, daniel@ffwll.ch, linux-ntb@googlegroups.com, Romain Perier <romain.perier@gmail.com>, shawnguo@kernel.org, David Miller <davem@davemloft.net>

On Tue, Aug 18, 2020 at 02:46:23PM +0530, Allen wrote:
> > >
> > > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> >
> > This looks good to me.
> >
> > Reviewed-by: Corey Minyard <cminyard@mvista.com>
> >
> > Are you planning to push this, or do you want me to take it?  If you
> > want me to take it, what is the urgency?
> 
>  Thanks. Well, not hurry, as long as it goes into 5.9 with all other
> changes.

Ok, this is queued in my for-next branch.

-corey

> 
> 
> >
> > -corey
> >
> > > ---
> > >  drivers/char/ipmi/ipmi_msghandler.c | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > > index 737c0b6b24ea..e1814b6a1225 100644
> > > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > > @@ -39,7 +39,7 @@
> > >
> > >  static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
> > >  static int ipmi_init_msghandler(void);
> > > -static void smi_recv_tasklet(unsigned long);
> > > +static void smi_recv_tasklet(struct tasklet_struct *t);
> > >  static void handle_new_recv_msgs(struct ipmi_smi *intf);
> > >  static void need_waiter(struct ipmi_smi *intf);
> > >  static int handle_one_recv_msg(struct ipmi_smi *intf,
> > > @@ -3430,9 +3430,8 @@ int ipmi_add_smi(struct module         *owner,
> > >       intf->curr_seq = 0;
> > >       spin_lock_init(&intf->waiting_rcv_msgs_lock);
> > >       INIT_LIST_HEAD(&intf->waiting_rcv_msgs);
> > > -     tasklet_init(&intf->recv_tasklet,
> > > -                  smi_recv_tasklet,
> > > -                  (unsigned long) intf);
> > > +     tasklet_setup(&intf->recv_tasklet,
> > > +                  smi_recv_tasklet);
> > >       atomic_set(&intf->watchdog_pretimeouts_to_deliver, 0);
> > >       spin_lock_init(&intf->xmit_msgs_lock);
> > >       INIT_LIST_HEAD(&intf->xmit_msgs);
> > > @@ -4467,10 +4466,10 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
> > >       }
> > >  }
> > >
> > > -static void smi_recv_tasklet(unsigned long val)
> > > +static void smi_recv_tasklet(struct tasklet_struct *t)
> > >  {
> > >       unsigned long flags = 0; /* keep us warning-free. */
> > > -     struct ipmi_smi *intf = (struct ipmi_smi *) val;
> > > +     struct ipmi_smi *intf = from_tasklet(intf, t, recv_tasklet);
> > >       int run_to_completion = intf->run_to_completion;
> > >       struct ipmi_smi_msg *newmsg = NULL;
> > >
> > > @@ -4542,7 +4541,7 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
> > >               spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
> > >
> > >       if (run_to_completion)
> > > -             smi_recv_tasklet((unsigned long) intf);
> > > +             smi_recv_tasklet(&intf->recv_tasklet);
> > >       else
> > >               tasklet_schedule(&intf->recv_tasklet);
> > >  }
> > > --
> > > 2.17.1
> > >
> 
> 
> 
> -- 
>        - Allen

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

