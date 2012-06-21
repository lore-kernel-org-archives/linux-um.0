Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1ShnKa-0003T7-KJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 19:46:16 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ShnKY-000226-9G
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 19:46:16 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1ShnKK-0002O6-EM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 21:46:00 +0200
Received: from 173-164-30-65-Nashville.hfc.comcastbusiness.net
	([173.164.30.65]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Jun 2012 21:46:00 +0200
Received: from wad by 173-164-30-65-Nashville.hfc.comcastbusiness.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Jun 2012 21:46:00 +0200
From: Will Drewry <wad@dataspill.org>
Date: Thu, 21 Jun 2012 19:45:50 +0000 (UTC)
Message-ID: <loom.20120621T214420-7@post.gmane.org>
References: <4F3C1B06.7080506@nagafix.co.uk>
	<loom.20120621T174831-991@post.gmane.org>
	<CAFLxGvzcA7RNyJ_Ax94kQxXhsLx5+g8bBAbz8rKkLr0JfU4xVA@mail.gmail.com>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] X11 vfb forward ported to 3.2
To: user-mode-linux-devel@lists.sourceforge.net

richard -rw- weinberger <richard.weinberger <at> gmail.com> writes:

> 
> On Thu, Jun 21, 2012 at 5:56 PM, Will Drewry <wad <at> dataspill.org> wrote:
> > Not sure if anyone still cares, but if I end up getting it more cleaned up, 
I'll
> > post a 3.5 port in a weekend in the near future :)
> 
> Would be great!
> If it works and is clean I'll happily merge it upstream. 


Cool! I'll clean it up.  So far I also found a use-after-free bug which broke 
list traversal (during screen redraw) and moved it from kthread to workqueues.  
There are still a lot of pieces which don't make as much sense to me yet, but 
once it seems not so crazy, I'll definitely post it for consideration.  I'd love 
to see it in!


Cheers,
will





------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

