Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GaxOu-00056R-1v for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 09:39:16 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GaxOr-0008Ou-JT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 09:39:16 -0700
Date: Fri, 20 Oct 2006 12:37:51 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061020163751.GD5530@ccure.user-mode-linux.org>
References: <7b2fa1820610192302o52213a59uc220df19e6a84fbb@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b2fa1820610192302o52213a59uc220df19e6a84fbb@mail.gmail.com>
Subject: Re: [uml-devel] 2.4.21 insmod problem: unresolved symbol to_virt
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
To: Ian Jiang <ianjiang.ict@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Oct 20, 2006 at 02:02:09PM +0800, Ian Jiang wrote:
> Then I tried the example 4-1 chardev.c at
> http://tldp.org/LDP/lkmpg/2.4/html/x579.html, but I got "unresolved
> symbol to_virt" from insmod. I noted it's the calling for put_user()
> by chardev.c that lead to use of to_virt(). 

Export it in arch/um/kernel/ksyms.c

> However, this symbol has
> already been exported in System.map of UML.

That's not an export table.  The export table is /proc/ksyms.

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
