Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1SLuwC-0001aq-6g
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Apr 2012 11:26:40 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SLuwB-00006H-9m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Apr 2012 11:26:40 +0000
Received: by lagw12 with SMTP id w12so10800370lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Apr 2012 04:26:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20120421T191253-852@post.gmane.org>
References: <loom.20120421T191253-852@post.gmane.org>
Date: Sun, 22 Apr 2012 13:21:27 +0200
Message-ID: <CAFLxGvybL7jTMsxD3f7p25Z-8aL9cOtJr-wi1aoO82Ykm98Ong@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] 3.3.2: conflicting types for sys_ni_syscall
To: Osi2897 <osi2897@i2pmail.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 21, 2012 at 7:22 PM, Osi2897 <osi2897@i2pmail.org> wrote:
> Hi,
>
> I tried to compile 3.3.2 UML on an old pentium III system (3.2.12 was no problem
> on this system). With 3.3.2 I get the following error (conflicting types for
> "sys_ni_syscall"):

Can you try building the kernel again after a "make mrproper ARCH=um"?

-- 
Thanks,
//richard

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

