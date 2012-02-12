Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Rwg1H-00072P-Oe
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Feb 2012 20:27:35 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rwg1H-0001Hj-0k
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Feb 2012 20:27:35 +0000
Date: Sun, 12 Feb 2012 20:27:28 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120212202728.GR23916@ZenIV.linux.org.uk>
References: <20120130192552.GL23916@ZenIV.linux.org.uk>
	<1328311063-17630-1-git-send-email-richard@nod.at>
	<20120204001431.GY23916@ZenIV.linux.org.uk>
	<4F2C7F7A.1090605@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F2C7F7A.1090605@nod.at>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: Cleanup headers files
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Feb 04, 2012 at 01:44:42AM +0100, Richard Weinberger wrote:
> Am 04.02.2012 01:14, schrieb Al Viro:
> > On Sat, Feb 04, 2012 at 12:17:43AM +0100, Richard Weinberger wrote:
> >> Many header files can be replaced by generic variants.
> > 
> > Umm...  I suspect that for auxvec.h the right thing is to simply
> > remove it - it's never used on uml builds.
> > 
> > FWIW, I've rebased my local queue to current and pushed it to kernel.org
> > again; it's on git.kernel.org/pub/scm/linux/kernel/git/viro/um-headers.git
> 
> So, I pulled your work and merged it into my shiny new UML tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git

Hmm...  I would really, really recommend you to clean the git history in that
tree up.  As it is, you have
	* merge of that branch from um-headers
	* um: Switch to large mcmodel on x86_64
	* um: Serve io_remap_pfn_range()
	* 205 merges from Linus, from mid-April to late January.
	* mismerge from Linus on April 14; the diff between the result
of that merge and its mainline parent is
diff --git a/drivers/platform/x86/intel_pmic_gpio.c b/drivers/platform/x86/intel_pmic_gpio.c
index 753bdb3..464bb3f 100644
--- a/drivers/platform/x86/intel_pmic_gpio.c
+++ b/drivers/platform/x86/intel_pmic_gpio.c
@@ -208,8 +208,8 @@ static struct irq_chip pmic_irqchip = {
        .name                   = "PMIC-GPIO",
        .irq_mask               = pmic_irq_mask,
        .irq_unmask             = pmic_irq_unmask,
-       .irq_set_type = pmic_irq_type, <<<<<<< HEAD
-       .irq_bus_lock           = pmic_irq_buslock,
+       .irq_set_type           = pmic_irq_type,
+       .irq_bus_lock           = pmic_bus_lock,
        .irq_bus_sync_unlock    = pmic_bus_sync_unlock,
 };
and that mangling is still in your tree
	* a bunch of cherry-picked (or manually applied?) commits from
mainline, done on April 12-13
	* 23 more backmerges
	* a _lot_ of cherry-picks circa March 12
	* 91 more backmerges
	* backmerge with a conflict; note that result of merge is identical
to the mainline parent of it (August 2010)
	* 5 more backmerges (once a week or so)
	* your "um: call free_irq() only on enabled channels", applied by
Linus (over mail, presumably) a couple of weeks later
	* 7 more backmerges
	* your variant of removal of unused variable in apic/es7000_32.c;
that's what caused conflict resolved by Aug 2010 merge.

As it is, you have mainline with mangled intel_pmic_gpio.c plus two recent
um commits plus the merge from um-headers.  _Please_, replace that with
mainline + the same two commits + merge.  And don't do the compulsive
backmerging like that...

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

