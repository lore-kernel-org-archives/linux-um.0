Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 11 Dec 2017 10:33:37 +0100
Message-ID: <3254171.LO6pLlHuPk@blindfold>
In-Reply-To: <54b3ee94-6afd-7907-3764-e2413f231209@cambridgegreys.com>
References: <20171209114940.fsi7jbxd7zbhhu74@mwanda>
 <54b3ee94-6afd-7907-3764-e2413f231209@cambridgegreys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/2] um: vector_kern: Unlock on error in
 vector_net_open()
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: user-mode-linux-user@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, kernel-janitors@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Dan Carpenter <dan.carpenter@oracle.com>

Anton,

Am Samstag, 9. Dezember 2017, 18:09:17 CET schrieb Anton Ivanov:
> Thanks,
> 
> I guess I missed that one.
> 
> A.
> 
> On 09/12/17 11:49, Dan Carpenter wrote:
> > We need to unlock and restore IRQs on this error path.
> > 
> > Fixes: ad1f62ab2bd4 ("High Performance UML Vector Network Driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> > index d1d53015d572..bb83a2d22ac2 100644
> > --- a/arch/um/drivers/vector_kern.c
> > +++ b/arch/um/drivers/vector_kern.c
> > @@ -1156,8 +1156,10 @@ static int vector_net_open(struct net_device *dev)
> > 
> >  	struct vector_device *vdevice;
> >  	
> >  	spin_lock_irqsave(&vp->lock, flags);
> > 
> > -	if (vp->opened)
> > +	if (vp->opened) {
> > +		spin_unlock_irqrestore(&vp->lock, flags);
> > 
> >  		return -ENXIO;
> > 
> > +	}
> > 
> >  	vp->opened = true;
> >  	spin_unlock_irqrestore(&vp->lock, flags);

Please review/ack these patches.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

