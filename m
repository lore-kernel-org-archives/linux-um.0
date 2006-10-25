Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Wed, 25 Oct 2006 11:59:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061025155953.GB4996@ccure.user-mode-linux.org>
References: <87bqo2ou4z.fsf@inbox.ru>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bqo2ou4z.fsf@inbox.ru>
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
To: Damon LaCrosse <arid@inbox.ru>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Tue, Oct 24, 2006 at 01:01:00PM +0200, Damon LaCrosse wrote:
> 
> On certain situations where printk are embedded in spinlock protected regions
> (i.e. "spin_lock(); for () { printk(); } spin_unlock(); }") I often 
> experience uml lockups like this one:

Yeah, known bug.  We are using spinlocks improperly in the console subsystem.

				Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
