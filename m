Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D99tn-00067o-TJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 14:43:27 -0800
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1D99tl-00014p-PB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 14:43:27 -0800
From: Russell King <rmk+lkml@arm.linux.org.uk>
Message-ID: <20050309224259.J25398@flint.arm.linux.org.uk>
References: <20050309094234.8FC0C6477@zion>
	<20050309171231.H25398@flint.arm.linux.org.uk>
	<200503092052.24803.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503092052.24803.blaisorblade@yahoo.it>;
	from blaisorblade@yahoo.it on Wed, Mar 09, 2005 at 08:52:24PM
	+0100
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
Date: Wed, 9 Mar 2005 22:42:59 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net

On Wed, Mar 09, 2005 at 08:52:24PM +0100, Blaisorblade wrote:
> On Wednesday 09 March 2005 18:12, Russell King wrote:
> > On Wed, Mar 09, 2005 at 10:42:33AM +0100, blaisorblade@yahoo.it wrote:
> > > From: <domen@coderock.org>
> > > Cc: <user-mode-linux-devel@lists.sourceforge.net>, <domen@coderock.org>,
> > > <amitg@calsoftinc.com>, <gud@eth.net>
> > >
> > > Unify the spinlock initialization as far as possible.
> 
> > Are you sure this is really the best option in this instance?
> > Sometimes, static data initialisation is more efficient than
> > code-based manual initialisation, especially when the memory
> > is written to anyway.
> Agreed, theoretically, but this was done for multiple reasons globally, for 
> instance as a preparation to Ingo Molnar's preemption patches. There was 
> mention of this on lwn.net about this:
> 
> http://lwn.net/Articles/108719/

Was this announced on linux-kernel as well?  I don't remember seeing it.

I'm not convinced about the practicality of converting all static
initialisations to code-based initialisations though - I can see
that the number of initialisation functions scattered throughout
the kernel is going to increase dramatically to achieve this.

With a 2.4 to 2.6 kernel bloat already on the order of 140% for
similar functionality, I can only see the kernel getting more and
more bloated _for the same feature level_ because we're trying to
add more features to the kernel.

I'm not entirely convinced that is an all round sane approach.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
