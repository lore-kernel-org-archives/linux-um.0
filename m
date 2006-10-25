Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gckft-00061M-Rv for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 08:28:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gckfr-0003v9-C2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 08:28:13 -0700
Date: Wed, 25 Oct 2006 11:26:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061025152635.GC4323@ccure.user-mode-linux.org>
References: <7b2fa1820610192302o52213a59uc220df19e6a84fbb@mail.gmail.com>
	<20061020163751.GD5530@ccure.user-mode-linux.org>
	<7b2fa1820610221904q53df7d55w522384177fe3d705@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b2fa1820610221904q53df7d55w522384177fe3d705@mail.gmail.com>
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

On Mon, Oct 23, 2006 at 10:04:00AM +0800, Ian Jiang wrote:
> In fact, I used to export the symbol to_virt in um/kernel/physmem.c
> where it was defined. 

There is no to_virt defined in physmem.c in my tree now.

> But this had no effect. What is the difference
> between the ksyms.c and physmem.c while exporting symbols? Could you
> give an explanation? 

There shouldn't be any difference.  physmem.c already exports some stuff,
so there's no reason it can export more.

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
