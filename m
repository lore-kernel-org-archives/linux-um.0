Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 16 Aug 2007 10:46:35 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20070816084635.GA15985@osiris.boeblingen.de.ibm.com>
References: <20070815235825.GB17004@redhat.com>
	<1187224811.5906.55.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1187224811.5906.55.camel@localhost>
Subject: Re: [uml-devel] drivers/infiniband/mlx/mad.c misplaced ;
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Joe Perches <joe@perches.com>
Cc: Chas Williams <chas@cmf.nrl.navy.mil>, linux-s390@vger.kernel.org, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com, mikep@linuxtr.net, netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org, Linux Kernel <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, isdn4linux@listserv.isdn4linux.de, user-mode-linux-user@lists.sourceforge.net, linux390@de.ibm.com, Dave Jones <davej@redhat.com>, rolandd@cisco.com, swen@vnet.ibm.com

On Wed, Aug 15, 2007 at 05:40:11PM -0700, Joe Perches wrote:
> On Wed, 2007-08-15 at 19:58 -0400, Dave Jones wrote:
> > Signed-off-by: Dave Jones <davej@redhat.com>
> > 
> > diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
> > index 3330917..0ed02b7 100644
> > --- a/drivers/infiniband/hw/mlx4/mad.c
> > +++ b/drivers/infiniband/hw/mlx4/mad.c
> > @@ -109,7 +109,7 @@ int mlx4_MAD_IFC(struct mlx4_ib_dev *dev, int ignore_mkey, int ignore_bkey,
> >  			   in_modifier, op_modifier,
> >  			   MLX4_CMD_MAD_IFC, MLX4_CMD_TIME_CLASS_C);
> >  
> > -	if (!err);
> > +	if (!err)
> 
> There's more than a few of these (not inspected).
> 
> $ egrep -r --include=*.c "\bif[[:space:]]*\([^\)]*\)[[:space:]]*\;" * 

[...]

> drivers/s390/scsi/zfcp_erp.c:           if (status == ZFCP_ERP_SUCCEEDED) ;     /* no further action */

At least this one is not a bug. But I'm going to add a "break" there, so it
doesn't look that strange anymore. Thanks!

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
