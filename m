Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FWck6-0000JC-P2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Apr 2006 10:14:58 -0700
Received: from mga01.intel.com ([192.55.52.88] helo=fmsmga101-1.fm.intel.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FWck5-0007u6-EZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Apr 2006 10:14:58 -0700
From: "Luck, Tony" <tony.luck@intel.com>
Message-ID: <20060420171356.GA19088@agluck-lia64.sc.intel.com>
References: <200604170328.42599.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604170328.42599.jesper.juhl@gmail.com>
Subject: [uml-devel] Re: [PATCH 3/5] Remove redundant NULL checks before
	[kv]free - in arch/
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
Date: Thu, 20 Apr 2006 10:13:56 -0700
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Erich Focht <efocht@sonycom.com>, linux-ia64@vger.kernel.org, eranian@hpl.hp.com, davidm@hpl.hp.com, Ben Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, Jeff Dike <jdike@karaya.com>, user-mode-linux-devel@lists.sourceforge.net, Jan Engelhardt <jengelh@linux01.gwdg.de>

On Mon, Apr 17, 2006 at 03:28:42AM +0200, Jesper Juhl wrote:
> Remove redundant NULL checks before [kv]free + small CodingStyle cleanup
> for arch/
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  arch/ia64/kernel/topology.c               |    7 --
>  arch/ia64/sn/kernel/xpc_partition.c       |    8 --

Applied ia64 pieces.  Thanks.

>  arch/powerpc/platforms/powermac/low_i2c.c |    3
>  arch/um/kernel/irq.c                      |   93 +++++++++++++++---------------
>  arch/um/os-Linux/irq.c                    |   47 +++++++--------

These bits left to fend for themselves in patchspace.

-Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
