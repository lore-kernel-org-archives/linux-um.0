Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APpNc-0001mo-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 28 Nov 2003 12:38:20 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1APpNc-00016S-89
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 28 Nov 2003 12:38:20 -0800
Message-ID: <01df01c3b5f0$27898bd0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0311280938340.3315-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: bug in COW? -  Re: [uml-user] uml 2.6.0-test9 crash
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 28 Nov 2003 21:42:34 +0100
To: Henrik Nordstrom <hno@marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

hi!

> bonnie++ is a good one..
thanks - will give it a try. i already were aware of bonnie, but i thought it
was just a benchmark program.

> Maybe, maybe not. What does vmstat on the host report while you run this?
here is the output. 
the i/o stops, but uml still consumes cpu.
regards
roland

 2  1      0 273464  33628 156188    0    0    40  1732 1208 64200 42 58  0  0
 1  0      0 269412  33628 160104    0    0  3916    16 1988 56447 23 28 48  0
 1  0      0 265368  33628 164024    0    0  3920     0 1984 11543  6 12 82  0
 1  0      0 265372  33628 164024    0    0     0     0 1006 43904 38 62  0  0
 2  0      0 262528  33628 166768    0    0  2744     0 1699 71773 42 58  0  0
 1  0      0 255804  33628 173280    0    0  6512     0 2632 73736 40 60  0  0
 1  1      0 249364  33628 179512    0    0  6232     0 2570 102489 46 54  0  0
 1  2      0 246336  33700 182364    0    0  2856  5800 1992 95142 45 55  0  0
 1  2      0 246332  33700 182368    0    0     4  4340 1211 43884 39 60  1  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3      0 246324  33700 182376    0    0     8  6364 1238  4349  4  9 87  0
 0  3      0 246308  33700 182392    0    0    16  7548 1289   294  0  1 99  0
 0  3      0 246304  33700 182396    0    0     4  2104 1293   279  0  1 99  0
 0  3      0 246296  33700 182404    0    0     8  1716 1271   267  0  2 98  0
 1  0      0 243456  33700 185148    0    0  2744    68 1764  3261  7 19 74  0 <---!
 1  0      0 243440  33700 185148    0    0     0     0 1003    56 34 66  0  0
 1  0      0 243440  33700 185148    0    0     0     0 1002    54 33 67  0  0
 1  0      0 243440  33700 185148    0    0     0     0 1002    54 31 69  0  0
 1  0      0 243440  33700 185148    0    0     0     0 1002    52 33 67  0  0
 1  0      0 243440  33700 185148    0    0     0     0 1002    47 29 71  0  0
 1  1      0 243396  33744 185148    0    0     0  3240 1116    75 31 69  0  0
 1  0      0 243396  33744 185148    0    0     0     0 1006    53 34 66  0  0
 1  0      0 243396  33744 185148    0    0     0     0 1003    57 27 73  0  0
 1  0      0 243396  33744 185148    0    0     0     0 1003    52 33 67  0  0
 1  0      0 243396  33744 185148    0    0     0     0 1003    48 32 68  0  0
 1  0      0 243396  33744 185148    0    0     0     0 1003    47 34 66  0  0

----- Original Message ----- 
From: "Henrik Nordstrom" <hno@marasystems.com>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>; "uml-user" <user-mode-linux-user@lists.sourceforge.net>
Sent: Friday, November 28, 2003 9:39 AM
Subject: Re: bug in COW? - Re: [uml-user] uml 2.6.0-test9 crash


> On Fri, 28 Nov 2003, roland wrote:
> 
> > after making the rootfs-clone a cow-filesystem (by adding ubd2=rootfsclone.cow,rootfsclone.img),
> > the freeze happened again when doing some heavy writing. so - am i allowed to assume, that
> > there is a bug in the copy-on-write code?
> 
> Maybe, maybe not. What does vmstat on the host report while you run this?
> 
> > btw: could anybody recommend a general filesystem stresstest-tool which does the worst to
> > filesytems, you can do (besides formatting or overwriting)? :D
> 
> bonnie++ is a good one..
> 
> Regards
> Henrik
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
