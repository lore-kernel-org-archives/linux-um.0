Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRDTZ-0001X3-My	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 11:11:01 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DRDTZ-0004pN-3U
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 11:11:01 -0700
From: Chris Wright <chrisw@osdl.org>
Message-ID: <20050428181053.GQ23013@shell0.pdx.osdl.net>
References: <20050424181909.81B8F33AED@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424181909.81B8F33AED@zion>
Subject: [uml-devel] Re: [patch 1/7] uml: fix syscall table by including
	$(SUBARCH)'s one, for i386
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
Date: Thu, 28 Apr 2005 11:10:53 -0700
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

* blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> 
> Split the i386 entry.S files into entry.S and syscall_table.S which
> is included in the previous one (so actually there is no difference between
> them) and use the syscall_table.S in the UML build, instead of tracking by
> hand the syscall table changes (which is inherently error-prone).

Xen can use this as well (it was on my todo list).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
