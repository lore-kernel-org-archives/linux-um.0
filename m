Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gcsmn-0006Ke-Be for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 17:07:53 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gcsml-0002pN-ML
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 17:07:53 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 26 Oct 2006 02:07:41 +0200
References: <87bqo2ou4z.fsf@inbox.ru>
	<20061025155953.GB4996@ccure.user-mode-linux.org>
In-Reply-To: <20061025155953.GB4996@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610260207.41671.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Is this a known printk bug?
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Damon LaCrosse <arid@inbox.ru>, user-mode-linux-user@lists.sourceforge.net

On Wednesday 25 October 2006 17:59, Jeff Dike wrote:
> On Tue, Oct 24, 2006 at 01:01:00PM +0200, Damon LaCrosse wrote:
> > On certain situations where printk are embedded in spinlock protected
> > regions (i.e. "spin_lock(); for () { printk(); } spin_unlock(); }") I
> > often experience uml lockups like this one:
>
> Yeah, known bug.  We are using spinlocks improperly in the console
> subsystem.

Disable spinlock debugging and this bug will not show up; disabling these two 
ones is sufficient:

CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y

I'm fighting this one very actively and having interesting results (not all 
misuses have been fixed and patches are not yet perfect, but it'll work well 
soon I hope).
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
