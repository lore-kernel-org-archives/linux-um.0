Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYUO1-0002DP-SL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 14:48:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYUO0-0001fu-4Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 14:48:25 -0700
Date: Mon, 2 Apr 2007 17:44:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070402214434.GA10205@c2.user-mode-linux.org>
References: <1712880100@web.de> <200704012108.14597.blaisorblade@yahoo.it>
	<46100EF5.7040802@nagafix.co.uk>
	<20070402020530.GA589@c2.user-mode-linux.org>
	<4610D937.20002@nagafix.co.uk>
	<005601c77567$1ceddb60$eeeea8c0@aldipc>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <005601c77567$1ceddb60$eeeea8c0@aldipc>
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
To: roland <devzero@web.de>
Cc: Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 02, 2007 at 10:40:10PM +0200, roland wrote:
> btw - i think besides that packaged uml+rootfs, the same thing could be 
> distributed in other formats, i.e. qemu, vmware, M$ virtual pc (add your 
> favourite v12n solution here)

There are sites (http://uml.nagafix.co.uk/ being the best one I know
of) where, with two downloads, two uncompressions, and one command
line later, you have a booted UML.

The only way I know of to improve on this, aside from inprovements in
the booted distro, is to package the filesystem as a rootfs within the
UML kernel binary.  I've considered this, but haven't done anything
with it.

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
