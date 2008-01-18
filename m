Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFvyf-0005Sm-1l for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 10:30:05 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFvyb-0004D6-3C
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jan 2008 10:30:04 -0800
In-reply-to: <20080118180749.GA7688@c2.user-mode-linux.org> (message from Jeff
	Dike on Fri, 18 Jan 2008 13:07:49 -0500)
References: <E1JFsQo-0000aG-BZ@pomaz-ex.szeredi.hu>
	<20080118180749.GA7688@c2.user-mode-linux.org>
Message-Id: <E1JFvyQ-00014P-Vl@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 18 Jan 2008 19:29:50 +0100
Subject: Re: [uml-devel] UML is leaking memory in arch_dup_mmap
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> On Fri, Jan 18, 2008 at 03:42:54PM +0100, Miklos Szeredi wrote:
> > uml:~#  grep arch_dup_mmap /proc/slab_allocators
> > size-32: 10861 arch_dup_mmap+0x9f/0x130
> 
> Whoops - try the patch below.

Yup, that seems to have solved it.  Thanks.

Miklos

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
