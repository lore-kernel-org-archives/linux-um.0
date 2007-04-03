Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYasw-0001ym-VV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 21:44:47 -0700
Received: from crown.reflexsecurity.com ([72.54.139.163])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HYasv-0007QV-KE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 21:44:46 -0700
Date: Tue, 3 Apr 2007 00:44:47 -0400
From: Jason Lunz <lunz@falooley.org>
Message-ID: <20070403044447.GB14297@falooley.org>
References: <1712880100@web.de> <200704012108.14597.blaisorblade@yahoo.it>
	<46100EF5.7040802@nagafix.co.uk>
	<20070402020530.GA589@c2.user-mode-linux.org>
	<4610D937.20002@nagafix.co.uk>
	<005601c77567$1ceddb60$eeeea8c0@aldipc>
	<20070402214434.GA10205@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070402214434.GA10205@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [RFC] UML kernel & rootfs bundle with every kernel
	release ?
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
To: Jeff Dike <jdike@addtoit.com>
Cc: roland <devzero@web.de>, Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, Apr 02, 2007 at 05:44:34PM -0400, Jeff Dike wrote:
> There are sites (http://uml.nagafix.co.uk/ being the best one I know
> of) where, with two downloads, two uncompressions, and one command
> line later, you have a booted UML.
> 
> The only way I know of to improve on this, aside from inprovements in
> the booted distro, is to package the filesystem as a rootfs within the
> UML kernel binary.  I've considered this, but haven't done anything
> with it.

I've done the converse: package the uml kernel within the rootfs image,
and use a script that plays the part of bootloader. With ext2 at least,
it's fairly easy to use the debugfs 'cat' command for this.

That way, you simply distribute the fs image with a companion script
that can boot any number of such images.

Jason

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
