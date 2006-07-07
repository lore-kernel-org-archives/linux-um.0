Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeTv-0007jj-Q5 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:46:07 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeTu-0004go-As
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:46:07 -0700
Date: Thu, 6 Jul 2006 20:45:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060707004552.GC8756@ccure.user-mode-linux.org>
References: <006401c69c19$eb9edbd0$d4190a0a@centecnetworks.com>
	<20060630134509.GA3510@ccure.user-mode-linux.org>
	<007401c69ca6$a6e00040$d4190a0a@centecnetworks.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <007401c69ca6$a6e00040$d4190a0a@centecnetworks.com>
Subject: Re: [uml-devel] [uml-user] UML 2.6.17 problems (section mismatch,
	get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP)
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
To: Miao Qingjun <qmiao@centecnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 01, 2006 at 08:38:20AM +0800, Miao Qingjun wrote:
> 082c90c8 <stub_segv_handler>:
...
>  82c9102:       e8 93 ae db ff          call   8083f9a <stub_syscall0>
...
>  82c9120:       e8 57 ae db ff          call   8083f7c <stub_syscall2>

I guess we should consider a no-O2 compilation to be a case of "it
hurts, so don't do it".  

What happened here is that two functions which absolutely have to be
inlined (because this code is mapped into UML processes with no other
UML code, so it must be self-contained) weren't.

It should be possible to detect O2 or greater optimization and fail
the build if it's not there.  But that assumes that we know that
non-O2 won't inline stuff, which may not always be true.  Hmmmm

				Jeff

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
