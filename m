Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4OMC-0006Ho-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 11:36:48 -0700
Received: from imladris.demon.co.uk ([193.237.130.41]
	helo=phoenix.infradead.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C4OMA-0003Dd-BR
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 11:36:48 -0700
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20040906193620.A8502@infradead.org>
References: <20040906173524.EE034B977@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906173524.EE034B977@zion.localdomain>;
	from blaisorblade_spam@yahoo.it on Mon, Sep 06, 2004 at
	07:35:24PM +0200
Subject: [uml-devel] Re: [patch 1/1] uml: no extraversion in arch/um/Makefile
	for mainline
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
Date: Mon, 6 Sep 2004 19:36:20 +0100
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Could you please fix UML to not use ghash.h and remove that one before
playing with new toys?  This has been requested a few times now.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
