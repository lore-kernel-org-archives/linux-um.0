Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GbpAZ-0002AY-OD for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Oct 2006 19:04:03 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GbpAY-0006T0-4K
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Oct 2006 19:04:03 -0700
Received: by ug-out-1314.google.com with SMTP id p27so993897ugc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Oct 2006 19:04:00 -0700 (PDT)
Message-ID: <7b2fa1820610221904q53df7d55w522384177fe3d705@mail.gmail.com>
Date: Mon, 23 Oct 2006 10:04:00 +0800
From: "Ian Jiang" <ianjiang.ict@gmail.com>
In-Reply-To: <20061020163751.GD5530@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <7b2fa1820610192302o52213a59uc220df19e6a84fbb@mail.gmail.com>
	<20061020163751.GD5530@ccure.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Jeff!
Thanks for your reply!

On 10/21/06, Jeff Dike <jdike@addtoit.com> wrote:
> On Fri, Oct 20, 2006 at 02:02:09PM +0800, Ian Jiang wrote:
> > Then I tried the example 4-1 chardev.c at
> > http://tldp.org/LDP/lkmpg/2.4/html/x579.html, but I got "unresolved
> > symbol to_virt" from insmod. I noted it's the calling for put_user()
> > by chardev.c that lead to use of to_virt().
>
> Export it in arch/um/kernel/ksyms.c
>

 I tried just as you told and the problem was fixed.

In fact, I used to export the symbol to_virt in um/kernel/physmem.c
where it was defined. But this had no effect. What is the difference
between the ksyms.c and physmem.c while exporting symbols? Could you
give an explanation? Thanks again and best wishes!
-- 
Ian Jiang

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
