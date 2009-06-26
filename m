Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chkr@plauener.de>) id 1MKBF8-0001To-BU
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 13:13:26 +0000
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MKBEJ-0002Xq-R1
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 13:13:26 +0000
Received: from csn-server.csn.tu-chemnitz.de ([134.109.101.249]
	helo=gondor.middle-earth.priv)
	by jack.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <chkr@plauener.de>) id 1MKAHj-0003lt-HG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 14:12:03 +0200
Message-ID: <4A44BB12.1010605@plauener.de>
Date: Fri, 26 Jun 2009 14:12:02 +0200
From: Christian Krause <chkr@plauener.de>
MIME-Version: 1.0
References: <1244664800.22809.31.camel@localhost>
In-Reply-To: <1244664800.22809.31.camel@localhost>
Subject: Re: [uml-devel] Fedora core 11 and UML kernel compile
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

Vincent Perrier wrote:
> Fedora 11 cannot compile uml kernels (2.6.29.4 and 2.6.30),
> here is the error:
>    . . .
>    . . .
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> /usr/bin/ld:arch/um/kernel/vmlinux.lds:1: ignoring invalid character `#'
> in expression
> 
> I have no knowledge at all of kernel compilation, so I have no idea
> how to get it compiled.

The root cause of the problem is a change in the behavior of the bash.
Fedora 11 uses bash 4 which does not pass environmental variables
containing "." to sub-processes. Since the kernel's Makefiles rely on
this feature, the mentioned error occurs.

Right now there is a discussion on the bash's mailing list whether this
behavior is correct or not:
http://lists.gnu.org/archive/html/bug-bash/2009-06/msg00078.html

So it is unclear right now whether the problem should be fixed in the
bash, in make or in the kernel's Makefiles. Let's see what's the outcome
of the discussion with the bash developers.


Best regards,
Christian

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

