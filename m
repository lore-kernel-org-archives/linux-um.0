Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BG5oZ-0006lC-Ss for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2004 17:42:11 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BG5oZ-00053o-Dx for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Apr 2004 17:42:11 -0700
Message-ID: <06e701c4273a$64796400$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] compile with allmodconfig !?
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
Date: Wed, 21 Apr 2004 02:48:41 +0200
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

hi !
today i tried to compile a 2.6.4 uml kernel.

this is what i did:

i downloaded 
http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.4.tar.bz2
http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.6.4-1.bz2
and patched the kernel with the uml-patch

after "make menuconfig ARCH=um" all was fine - i got a running kernel.


furthermore, i tought: why selecting manually, which modules to compile?
i would like a uml-kernel with ALL the modules suitable for being loaded
with that kernel.

so i tried:

make allmodconfig ARCH=um
make linux ARCH=um

but after that compiling fails at the very beginning with:

"gcc: -pg and -fomit-frame-pointer are incompatible"

for the stock kernel without the uml-patch applied, compiling with 
allmodconfig works without a problem.

what can i do to get a uml-kernel with all the "uml`able" modules ?
does someone need to dig through the config options to deceide, what modules
are suitable for running inside uml and have no dependency to "real" hardware?

IMHO, allmodconfig should work, when compiling uml.

btw:  i`m on suse 9 with gcc 3.3.1

regards
roland






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
