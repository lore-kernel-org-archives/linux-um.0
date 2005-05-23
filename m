Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaGls-0005Ko-F1	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 10:31:20 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DaGln-00048N-FS	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 10:31:20 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
	<4290E1C6.9070709@gmail.com>
In-Reply-To: <4290E1C6.9070709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505231932.48146.blaisorblade@yahoo.it>
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
Date: Mon, 23 May 2005 19:32:47 +0200
To: user-mode-linux-devel@lists.sourceforge.net, eric.begot@gmail.com
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org

On Sunday 22 May 2005 21:47, Eric BEGOT wrote:
> Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for uml.
> At the compilation of init/main.c, it complains because it doens't find
> the 2 constants FIXADDR_USER_START and FIXADDR_USER_END
On mainline it's defined by either include/asm-um/archparam-x86_64.h or 
include/asm-um/elf-i386.h.

Make sure you used a clean tree and a correct command line (make init/main.o 
ARCH=um wouldn't work because it would not create the needed header 
symlinks).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
