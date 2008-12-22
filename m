Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miklos@szeredi.hu>) id 1LEpuQ-0006re-Ox
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Dec 2008 18:53:42 +0000
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LEpuK-0000Dm-Ik
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Dec 2008 18:53:42 +0000
In-reply-to: <1229867858.9487.238.camel@twins> (message from Peter Zijlstra on
	Sun, 21 Dec 2008 14:57:38 +0100)
References: <E1LB4QO-0005fk-7g@pomaz-ex.szeredi.hu>
	<1229867858.9487.238.camel@twins>
Message-Id: <E1LEpu5-000627-Dn@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 22 Dec 2008 19:53:21 +0100
Subject: Re: [uml-devel] [regression] uml is very slow on 2.6.28 host
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: peterz@infradead.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, miklos@szeredi.hu

On Sun, 21 Dec 2008, Peter Zijlstra wrote:
> On Fri, 2008-12-12 at 10:35 +0100, Miklos Szeredi wrote:
> > When the UML boot gets to the userspace part it gets really really
> > slow.  It takes about 20 times the normal time to fully boot.  CPU
> > seems to be idle.
> > 
> > Guest version doesn't matter.  Host version 2.6.27 was OK, latest git
> > is not OK.  I'm running 32bit guest on 64bit host.
> 
> Does:
> 
> http://lkml.org/lkml/2008/12/16/40
> 
> help any?

Nope.

Thanks,
Miklos

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
