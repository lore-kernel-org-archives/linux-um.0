Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Fri, 17 Aug 2007 01:19:37 +0900
From: Paul Mundt <lethal@linux-sh.org>
Message-ID: <20070816161937.GA15530@linux-sh.org>
References: <exportbomb.1187270320@pinky> <20070815235825.GB17004@redhat.com>
	<1187224811.5906.55.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <exportbomb.1187270320@pinky> <1187224811.5906.55.camel@localhost>
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
To: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@shadowen.org>
Cc: Chas Williams <chas@cmf.nrl.navy.mil>, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com, mikep@linuxtr.net, netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Randy Dunlap <rdunlap@xenotime.net>, coreteam@netfilter.org, isdn4linux@listserv.isdn4linux.de, user-mode-linux-user@lists.sourceforge.net, linux390@de.ibm.com, Dave Jones <davej@redhat.com>, rolandd@cisco.com, swen@vnet.ibm.com

On Wed, Aug 15, 2007 at 05:40:11PM -0700, Joe Perches wrote:
> $ egrep -r --include=*.c "\bif[[:space:]]*\([^\)]*\)[[:space:]]*\;" * 
> arch/sh/boards/se/7343/io.c:    if (0) ;
> drivers/atm/iphase.c:     if (!desc1) ;
> drivers/infiniband/hw/mlx4/mad.c:       if (!err);
> drivers/isdn/capi/capiutil.c:   else if (c <= 0x0f);
> drivers/net/tokenring/ibmtr.c:  else if (ti->shared_ram_paging == 0xf);  /* No paging in adapter */
> drivers/s390/scsi/zfcp_erp.c:           if (status == ZFCP_ERP_SUCCEEDED) ;     /* no further action */
> fs/hostfs/hostfs_user.c:        if(attrs->ia_valid & HOSTFS_ATTR_CTIME) ;
> net/netfilter/xt_u32.c:         if (skb->len < 4 || pos > skb->len - 4);
> sound/pci/au88x0/au88x0_synth.c:                                if (eax == 0) ;

On Thu, Aug 16, 2007 at 02:18:40PM +0100, Andy Whitcroft wrote:
> A couple of people suggested adding checks to checkpatch for trailing
> semicolons on conditionals, where the conditional block may not be
> actually conditional:
> 
> 	if (err);
> 		return err;
> 
> While regression testing the changes, I ran these checks across the
> whole of 2.6.23-rc3 and there appear to be 5 places where this is
> occurs (above and beyond the IPv6 one which triggered this effort)
> and a benign use which could be confused later which it seems safest
> to fix.
> 
> Following this email are 6 patches for these issues, relevant
> maintainers cc'd.  All against 2.6.23-rc3
> 
It looks like you may want to refine your search parameters to match the
above, as there are at least a few cases where the space exists.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
