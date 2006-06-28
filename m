Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvQC1-00029D-KE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 19:54:17 -0700
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FvQC0-0007Yv-7T
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 19:54:17 -0700
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5S2s7fu012686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Jun 2006 22:54:08 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5S2s7h2229776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Jun 2006 22:54:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5S2s7PZ030684 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Jun 2006 22:54:07 -0400
Date: Tue, 27 Jun 2006 19:54:07 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
Message-ID: <20060628025407.GD4488@us.ibm.com>
References: <20060626220234.GG4223@us.ibm.com>
	<200606271656.13712.blaisorblade@yahoo.it>
	<20060627183128.GA4488@us.ibm.com>
	<20060628021131.GE9089@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060628021131.GE9089@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Fix UML build on i386 Ubuntu Dapper
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On 27.06.2006 [22:11:31 -0400], Jeff Dike wrote:
> On Tue, Jun 27, 2006 at 11:31:28AM -0700, Nishanth Aravamudan wrote:
> > After discovering SUBARCH, I rebuilt my tree as an i386 UML and it
> > successfully completed with this patch. If someone could test a native
> > i386 build as well, just to be sure?
> > 
> > Updated patch follows.
> 
> How updated?  I don't see any difference except for the new comment,
> which I fail to see fixing anything :-)

I added the comment that Blaisorblade asked for, that's it.

I didn't realize anything needed to be fixed? Removing the #undef causes
the build to fail, so it's necessary, hence the comment. If you'd prefer
a more verbose comment to that effect, I can do that, I guess.

Did I miss something?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
