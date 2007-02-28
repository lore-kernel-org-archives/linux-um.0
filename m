Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMS1R-0005ac-IT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 08:51:21 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMS1P-00085u-Nc
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 08:51:21 -0800
Date: Wed, 28 Feb 2007 11:42:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070228164248.GA18025@ccure.user-mode-linux.org>
References: <c28964800702280527x7c300a39gb6a2cd077e36daaf@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c28964800702280527x7c300a39gb6a2cd077e36daaf@mail.gmail.com>
Subject: Re: [uml-devel] Compilation error with 2.6.18 kernel
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
To: Lakshminarasimhan Naveenam <lsimhan05@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Feb 28, 2007 at 10:27:06PM +0900, Lakshminarasimhan Naveenam wrote:
>  I downloaded the 2.6.18 kernel and did the following
> 
> I got the following error
> $make ARCH=um
> SYMLINK arch/um/include/kern_constants.h
>  SYMLINK arch/um/include/sysdep
>  CHK     arch/um/include/uml-config.h
>  UPD     arch/um/include/uml-config.h
>  CC      arch/um/sys-i386/user-offsets.s
> arch/um/sys-i386/user-offsets.c: In function 'foo':
> arch/um/sys-i386/user-offsets.c:19: warning: implicit declaration of
> function 'offsetof'
> arch/um/sys-i386/user-offsets.c:19: error: expected expression before
> 'struct'

This has been fixed for a while - can you use a more modern UML?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
