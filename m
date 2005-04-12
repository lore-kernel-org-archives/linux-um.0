Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLSPT-0004cL-98 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 13:54:59 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DLSP9-000484-IQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 13:54:59 -0700
From: Chris Wright <chrisw@osdl.org>
Message-ID: <20050412205433.GS11199@shell0.pdx.osdl.net>
References: <20050412175209.10A11126095@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412175209.10A11126095@zion>
Subject: [uml-devel] Re: [stable] [patch 1/1] uml: add nfsd syscall when nfsd
	is modular
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
Date: Tue, 12 Apr 2005 13:54:33 -0700
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org

* blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> 
> CC: <stable@kernel.org>
> 
> This trick is useless, because sys_ni.c will handle this problem by itself,
> like it does even on UML for other syscalls.
> Also, it does not provide the NFSD syscall when NFSD is compiled as a module,
> which is a big problem.

Thanks, queued to -stable.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
