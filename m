Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyE5j-0000gj-Ol for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 10:58:35 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CyE5e-0000e0-R6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 10:58:35 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Fix compilation of UML after the stack-randomization
	patches
References: <4203CF43.20703@tuxrocks.com>
In-Reply-To: <4203CF43.20703@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502071833.13571.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 7 Feb 2005 18:33:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Frank Sorenson <frank@tuxrocks.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>

On Friday 04 February 2005 20:38, Frank Sorenson wrote:
> The stack randomization patches that went into 2.6.11-rc3-mm1 broke
> compilation of ARCH=um.  This patch fixes compiling by adding
> arch_align_stack back in.
>
> Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
> Acked-By: Jeff Dike <jdike@addtoit.com>

I've just spotted that if the function is arch-dependent it means that for us 
it will be subarch-dependant.

I've the doubt that the addition would better go under sys-i386 or some other 
subarch-dependent directories (in a file compiled against kernelspace 
headers, i.e. not listed in USER_OBJS in the directory it's contained 
inside), and it'd be nice to add also the x86_64 version.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
