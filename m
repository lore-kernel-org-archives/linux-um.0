Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D97Eh-0005zy-E0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:52:51 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D97Ed-00062Q-Mp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:52:51 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050309094234.8FC0C6477@zion>
	<20050309171231.H25398@flint.arm.linux.org.uk>
In-Reply-To: <20050309171231.H25398@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503092052.24803.blaisorblade@yahoo.it>
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
Date: Wed, 9 Mar 2005 20:52:24 +0100
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net

On Wednesday 09 March 2005 18:12, Russell King wrote:
> On Wed, Mar 09, 2005 at 10:42:33AM +0100, blaisorblade@yahoo.it wrote:
> > From: <domen@coderock.org>
> > Cc: <user-mode-linux-devel@lists.sourceforge.net>, <domen@coderock.org>,
> > <amitg@calsoftinc.com>, <gud@eth.net>
> >
> > Unify the spinlock initialization as far as possible.

> Are you sure this is really the best option in this instance?
> Sometimes, static data initialisation is more efficient than
> code-based manual initialisation, especially when the memory
> is written to anyway.
Agreed, theoretically, but this was done for multiple reasons globally, for 
instance as a preparation to Ingo Molnar's preemption patches. There was 
mention of this on lwn.net about this:

http://lwn.net/Articles/108719/

Ok?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
