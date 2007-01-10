Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H4lMa-0006XO-PM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jan 2007 13:52:06 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H4lMX-0005CE-QJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jan 2007 13:52:04 -0800
Date: Wed, 10 Jan 2007 16:46:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070110214620.GB6062@ccure.user-mode-linux.org>
References: <20070110102857.9bzdrhzh8g0s04og@webmail.flonatel.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070110102857.9bzdrhzh8g0s04og@webmail.flonatel.org>
Subject: Re: [uml-devel] Configuration problem with UML in kernel 2.6.19.1
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
To: uml@flonatel.org
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 10, 2007 at 10:28:57AM +0100, uml@flonatel.org wrote:
> Hello!
> 
> I had some problems running linux 2.6.19.1 as client UML.  When  
> starting 'mapping mmap stub failed, errno = -12' is printed - with an  
> additional Kernel panic. In the file arch/um/Kconfig.i386 the  
> definition of STUB_CODE and STUB_DATA depend on the configuration  
> symbol HOST_2G_2G which has gone sometimes in between 2.6.18.6 and  
> 2.6.19.1.
> 
> The applied patch solves the problem for me.

Excellent, thanks for chasing that down.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
