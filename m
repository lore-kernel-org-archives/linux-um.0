Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eb4qT-0007Zx-1L for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 15:31:41 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eb4qS-0003sH-Me
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 15:31:41 -0800
From: Rob Landley <rob@landley.net>
References: <200511121656.29445.rob@landley.net>
In-Reply-To: <200511121656.29445.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121731.25982.rob@landley.net>
Subject: [uml-devel] Why did oldconfig's behavior change in 2.6.15-rc1?
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
Date: Sat, 12 Nov 2005 17:31:25 -0600
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Saturday 12 November 2005 16:56, Rob Landley wrote:
> Linus says if we're going to test something, test -rc1, so I did.
>
> It went boing.
>
> I'm still trying to get -skas0 working on x86-64, but this was a standard
> x86 build...
>
> Rob

Very, very strange:

> make ARCH=um allnoconfig
> cat >> .config << EOF
CONFIG_MODE_SKAS=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_SYSCTL=y
CONFIG_STDERR_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_UBD=y
CONFIG_TMPFS=y
CONFIG_SWAP=y
CONFIG_LBD=y
CONFIG_EXT2_FS=y
CONFIG_PROC_FS=y
EOF
> make ARCH=um oldconfig
> grep SKAS .config
# CONFIG_MODE_SKAS is not set

Why did oldconfig switch off CONFIG_MODE_SKAS?  It didn't do that before.  
Hmmm...  Rummage, rummage...  Darn it, it's position dependent.  _And_ 
version dependent.

Ok, now I have to put the new entries at the _beginning_.  Appending them 
doesn't work anymore, it now ignores any symbol it's already seen, so you 
can't easily start with allnoconfig, switch on just what you want, and expect 
oldconfig to do anything intelligent.

That kinda sucks.  Oh well, I can have sed rip out the old symbols before I 
append the new ones.  Here's hoping it's not _that_ position dependent...

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
