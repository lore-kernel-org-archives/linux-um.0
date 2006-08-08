Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GASBM-00065b-QK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 07:03:44 -0700
Received: from web25219.mail.ukl.yahoo.com ([217.146.176.205])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GASBJ-0005y8-RX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 07:03:44 -0700
Message-ID: <20060808140335.81959.qmail@web25219.mail.ukl.yahoo.com>
Date: Tue, 8 Aug 2006 16:03:35 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <p733bc7pj48.fsf@verdi.suse.de>
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
To: Andi Kleen <ak@suse.de>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Andi Kleen <ak@suse.de> ha scritto: 

> Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:
> 
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > 
> > We have never used this flag and recently one user experienced a
> complaining
> > warning about this (there was a symbol in the positive half of
> the address space
> > IIRC). So fix it.
> 
> You can't use kernel cmodel in user space.  It requires running on
> negative
> virtual addresses. I would be surprised if it worked for you.

Argh, yes, I didn't test the patch and I didn't think to it a lot. So
what about the following bug? Should we hack our own module loader
based on x86-64's one?

Moreover, who has recently tested module loading in x86-64 uml
kernels? I don't remember doing such testing recently...

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=115125101012707&w=2


Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
