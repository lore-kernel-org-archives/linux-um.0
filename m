Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAPfT-0000TK-8Z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 04:22:39 -0700
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GAPfR-0002Vc-Qn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 04:22:39 -0700
References: <20060806154700.536.32978.stgit@memento.home.lan>
From: Andi Kleen <ak@suse.de>
Date: 08 Aug 2006 13:22:31 +0200
In-Reply-To: <20060806154700.536.32978.stgit@memento.home.lan>
Message-ID: <p733bc7pj48.fsf@verdi.suse.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:

> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> We have never used this flag and recently one user experienced a complaining
> warning about this (there was a symbol in the positive half of the address space
> IIRC). So fix it.

You can't use kernel cmodel in user space.  It requires running on negative
virtual addresses. I would be surprised if it worked for you.

-Andi
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
