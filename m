Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+5a26c1d377b2d96a6988+2898+infradead.org+dwmw2@casper.srs.infradead.org>)
	id 1Qnf8W-0000uT-9U for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 23:09:32 +0000
Received: from casper.infradead.org ([85.118.1.10])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qnf8T-0007i2-7p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 23:09:32 +0000
From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 01 Aug 2011 00:09:15 +0100
In-Reply-To: <20110731224834.GC2203@ZenIV.linux.org.uk>
References: <1312066693.22074.50.camel@i7.infradead.org>
	<1312066923.22074.53.camel@i7.infradead.org>
	<CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
	<1312151063.18010.25.camel@i7.infradead.org>
	<20110731224834.GC2203@ZenIV.linux.org.uk>
Message-ID: <1312153757.18010.37.camel@i7.infradead.org>
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
Subject: Re: [uml-devel] [PATCH 1/5] um: Use __i386__ in ifdef for vsyscall
 exports, not SUBARCH_i386
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sun, 2011-07-31 at 23:48 +0100, Al Viro wrote:
> Hell, no.  If you want to do it, do it the right way.  See #x86_merge in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/um-header.git/

 255 files changed, 6848 insertions(+), 7816 deletions(-)

Absolutely, but slightly out of scope for what I was trying to do :)

I just posted a *minimal* set of changes to make the UML build system
cope; fixing the code as you've done is *definitely* the better option.
Is there a reason it didn't go upstream yet?

It just wants this, to make the CONFIG_64BIT option visible when
SUBARCH=x86 and also put it *first*.

diff --git a/arch/um/Kconfig.x86 b/arch/um/Kconfig.x86
index d31ecf3..630db12 100644
--- a/arch/um/Kconfig.x86
+++ b/arch/um/Kconfig.x86
@@ -1,5 +1,19 @@
 mainmenu "User Mode Linux/$SUBARCH $KERNELVERSION Kernel Configuration"
 
+config 64BIT
+	bool "Build 64-bit kernel" if SUBARCH = "x86"
+	default SUBARCH != "i386"
+        ---help---
+          Say yes to build a 64-bit kernel - formerly known as x86_64
+          Say no to build a 32-bit kernel - formerly known as i386
+
+config X86_32
+	def_bool !64BIT
+	select HAVE_AOUT
+
+config X86_64
+	def_bool 64BIT
+
 source "arch/um/Kconfig.common"
 
 menu "UML-specific options"
@@ -18,17 +32,6 @@ config UML_X86
 	def_bool y
 	select GENERIC_FIND_FIRST_BIT
 
-config 64BIT
-	bool
-	default SUBARCH = "x86_64"
-
-config X86_32
-	def_bool !64BIT
-	select HAVE_AOUT
-
-config X86_64
-	def_bool 64BIT
-
 config RWSEM_XCHGADD_ALGORITHM
 	def_bool X86_XADD && 64BIT
 

-- 
dwmw2


------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

