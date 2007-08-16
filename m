Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 16 Aug 2007 10:52:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070816145210.GD6670@c2.user-mode-linux.org>
References: <20070815235825.GB17004@redhat.com>
	<1187224811.5906.55.camel@localhost>
Mime-Version: 1.0
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
Cc: Chas Williams <chas@cmf.nrl.navy.mil>, linux-s390@vger.kernel.org, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, mikep@linuxtr.net, netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org, Linux Kernel <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, isdn4linux@listserv.isdn4linux.de, user-mode-linux-user@lists.sourceforge.net, linux390@de.ibm.com, Dave Jones <davej@redhat.com>, rolandd@cisco.com, swen@vnet.ibm.com

On Wed, Aug 15, 2007 at 05:40:11PM -0700, Joe Perches wrote:
> fs/hostfs/hostfs_user.c:        if(attrs->ia_valid & HOSTFS_ATTR_CTIME) ;

This one can be deleted, but I think I did it for documentation
reasons, to make it clear that ctime handling wasn't left out by
mistake.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
