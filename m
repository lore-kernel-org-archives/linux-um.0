Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FoA3F-0008LY-P5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 19:15:13 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FoA3F-0005r0-KY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 19:15:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FoA3E-0001Yu-VU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 19:15:13 -0700
Date: Wed, 7 Jun 2006 22:15:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060608021525.GB5567@ccure.user-mode-linux.org>
References: <835bb2cb0606060553q6402b169p19e9b37bdec5fa16@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <835bb2cb0606060553q6402b169p19e9b37bdec5fa16@mail.gmail.com>
Subject: Re: [uml-devel] linux-2.6.16 build broken?
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
To: Murali Nagaraj <muralin@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jun 06, 2006 at 05:53:08PM +0500, Murali Nagaraj wrote:
>   CC      arch/um/os-Linux/sys-i386/registers.o
> arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':
> arch/um/os-Linux/sys-i386/registers.c:137: error: 'JB_PC' undeclared
> (first use in this function)

Apply this patch - we are figuring out a real way to fix this:
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc5/patches/jmpbuf

				Jeff


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
