Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9ImE-0008Ba-QL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 00:12:14 -0800
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]
	helo=mail.tglx.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9ImD-0008Tj-9N for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 00:12:14 -0800
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
In-Reply-To: <200503092052.24803.blaisorblade@yahoo.it>
References: <20050309094234.8FC0C6477@zion>
	<20050309171231.H25398@flint.arm.linux.org.uk>
	<200503092052.24803.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1110442320.29330.196.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/1] unified spinlock initialization
	arch/um/drivers/port_kern.c
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
Date: Thu, 10 Mar 2005 09:12:00 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net

On Wed, 2005-03-09 at 20:52 +0100, Blaisorblade wrote:
> > Are you sure this is really the best option in this instance?
> > Sometimes, static data initialisation is more efficient than
> > code-based manual initialisation, especially when the memory
> > is written to anyway.
> Agreed, theoretically, but this was done for multiple reasons globally, for 
> instance as a preparation to Ingo Molnar's preemption patches. There was 
> mention of this on lwn.net about this:
> 
> http://lwn.net/Articles/108719/

Those patches did only the conversion of

static spinlock_t lock = SPIN_LOCK_UNLOCKED;
       lock = SPIN_LOCK_UNLOCKED;
to
static DEFINE_SPINLOCK(lock);
       spin_lock_init(lock);

If you want to do static initialization inside of structures, then you
have to define a seperate MACRO similar to the static initialization of
list_head's inside of structures:

static struct sysfs_dirent sysfs_root = {
        .s_sibling      = LIST_HEAD_INIT(sysfs_root.s_sibling),

tglx




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
