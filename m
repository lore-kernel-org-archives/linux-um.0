Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBzoW-0001g6-WE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Aug 2006 13:10:33 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GBzoV-0001r0-BQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Aug 2006 13:10:32 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 12 Aug 2006 22:10:31 +0200
References: <39134b110608100842p5acdf798o807b48801ea9a706@mail.gmail.com>
	<200608122022.42389.blaisorblade@yahoo.it>
In-Reply-To: <200608122022.42389.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608122210.32222.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML hostfs bugs
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
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: wang lianwei <lianwei.wang@gmail.com>

On Saturday 12 August 2006 20:22, Blaisorblade wrote:
> On Thursday 10 August 2006 17:42, wang lianwei wrote:
> > Hi all,
> >
> > There is a bug with UML kernel, some host directory can not be read, for
> > example "ls /mnt/host/usr/lib", this command is dead until you press
> > CTRL+c. I test it with Redhat Enterprise Linux 4.

> I can maybe understand why it could happen. I'd be more interested in
> checking if a simple sequence of readdir() calls (without seekdir()) would
> work (probably write a standalone test program, it will be easier to use
> and debug) and 

> why read_dir needs to do seekdir (I think it's done to 
> handle calls to seekdir by the underlying process, but there should be
> different ways to do it).

I want to propose as an alternative modifying hostfs_dir_fops.llseek to point 
to a wrapper of generic_file_llseek doing what we need (i.e. seeking the 
underlying pointer), and avoiding seekdir and telldir in read_dir.
This should fix the issue (I think).

I'm sorry but I will not have the time to code the patch, so please do it 
yourselves; Wang, you're welcome to code it yourself if you feel like doing 
it.

Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
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
