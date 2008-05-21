Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jys5E-0004G8-89 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 May 2008 10:26:36 -0700
Received: from fg-out-1718.google.com ([72.14.220.159])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jys59-0002Qn-Nt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 May 2008 10:26:36 -0700
Received: by fg-out-1718.google.com with SMTP id d23so2349125fga.32
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 May 2008 10:26:26 -0700 (PDT)
Message-ID: <48345B31.50904@googlemail.com>
Date: Wed, 21 May 2008 19:26:09 +0200
From: Gabriel C <nix.or.die@googlemail.com>
MIME-Version: 1.0
Subject: [SPAM]  [uml-devel] linux-next: UML build error
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: linux-next@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Hi,

I get the following UML compile error on linux-next-20080521 , 64bit box :

...

  CC      arch/um/sys-x86_64/ksyms.o
arch/um/sys-x86_64/ksyms.c:5: error: '__memcpy' undeclared here (not in a function)
arch/um/sys-x86_64/ksyms.c:5: warning: type defaults to 'int' in declaration of '__memcpy'
make[1]: *** [arch/um/sys-x86_64/ksyms.o] Error 1
make: *** [arch/um/sys-x86_64] Error 2

...

config is UM's defconfig.


Regards,

Gabriel 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
