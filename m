Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D94k2-0005Ug-PR for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 09:13:02 -0800
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1D94jy-0006KD-3n
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 09:13:02 -0800
From: Russell King <rmk+lkml@arm.linux.org.uk>
Message-ID: <20050309171231.H25398@flint.arm.linux.org.uk>
References: <20050309094234.8FC0C6477@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309094234.8FC0C6477@zion>;
	from blaisorblade@yahoo.it on Wed, Mar 09, 2005 at 10:42:33AM
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
Date: Wed, 9 Mar 2005 17:12:31 +0000
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net

On Wed, Mar 09, 2005 at 10:42:33AM +0100, blaisorblade@yahoo.it wrote:
> 
> From: <domen@coderock.org>
> Cc: <user-mode-linux-devel@lists.sourceforge.net>, <domen@coderock.org>, <amitg@calsoftinc.com>, <gud@eth.net>
> 
> Unify the spinlock initialization as far as possible.

Are you sure this is really the best option in this instance?
Sometimes, static data initialisation is more efficient than
code-based manual initialisation, especially when the memory
is written to anyway.

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
