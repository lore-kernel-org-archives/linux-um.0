Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQHH5-0002By-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 29 Nov 2003 18:25:27 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AQHH4-00066G-CF
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 29 Nov 2003 18:25:26 -0800
Message-ID: <035a01c3b6e9$cfee1df0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0311282234040.10367-100000@filer.marasystems.com>
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
Date: Sun, 30 Nov 2003 03:29:41 +0100
To: Henrik Nordstrom <hno@marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

hi,
i have 2.6.0-test11-um running - as expected the error is still there.
i compiled a debug version and attached a debugger to the "hanging" uml-process:

linux:/uml/suse9 # gdb linux-2.6.0-test11-um-debug 2234
GNU gdb 5.3.92
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...
Attaching to program: /uml/suse9/linux-2.6.0-test11-um-debug, process 2234
0xa0002091 in munmap ()
(gdb) cont
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0xa002a80b in cowify_req (req=0xa02236e4, dev=0xa022ab40)
    at arch/um/drivers/ubd_kern.c:820
820     arch/um/drivers/ubd_kern.c: No such file or directory.  <- ???
        in arch/um/drivers/ubd_kern.c
(gdb) cont
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0xa002a80b in cowify_req (req=0xa02236e4, dev=0xa022ab40)
    at arch/um/drivers/ubd_kern.c:820
820     in arch/um/drivers/ubd_kern.c
(gdb) cont
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0xa002a80b in cowify_req (req=0xa02236e4, dev=0xa022ab40)
    at arch/um/drivers/ubd_kern.c:820
820     in arch/um/drivers/ubd_kern.c
(gdb) 


so my speculation seems affirmed, that the bug is "somewhere inside COW".

here is the appropriate code snippet from ubd_kern.c :


    790 void cowify_req(struct io_thread_req *req, struct ubd *dev)
    791 {
    792         int i, update_bitmap, sector = req->offset >> 9;
    793
    794         if(req->length > (sizeof(req->sector_mask) * 8) << 9)
    795                 panic("Operation too long");
    796         if(req->op == UBD_READ) {
    797                 for(i = 0; i < req->length >> 9; i++){
    798                         if(ubd_test_bit(sector + i, (unsigned char *)
    799                                         dev->cow.bitmap)){
    800                                 ubd_set_bit(i, (unsigned char *)
    801                                             &req->sector_mask);
    802                         }
    803                 }
    804         }
    805         else {
    806                 update_bitmap = 0;
    807                 for(i = 0; i < req->length >> 9; i++){
    808                         ubd_set_bit(i, (unsigned char *)
    809                                     &req->sector_mask);
    810                         if(!ubd_test_bit(sector + i, (unsigned char *)
    811                                          dev->cow.bitmap))
    812                                 update_bitmap = 1;
    813                         ubd_set_bit(sector + i, (unsigned char *)
    814                                     dev->cow.bitmap);
    815                 }
    816                 if(update_bitmap){
    817                         req->cow_offset = sector / (sizeof(unsigned long) * 8);
    818                         req->bitmap_words[0] =
    819                                 dev->cow.bitmap[req->cow_offset];
    820                         req->bitmap_words[1] =
    821                                 dev->cow.bitmap[req->cow_offset + 1];
    822                         req->cow_offset *= sizeof(unsigned long);
    823                         req->cow_offset += dev->cow.bitmap_offset;
    824                 }
    825         }
    826 }


sorry, i have no real experience in debugging with gdb, nor am i a good c programmer.
does anybody have a clue whats going wrong here ?

regards
roland







----- Original Message ----- 
From: "Henrik Nordstrom" <hno@marasystems.com>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>; "uml-user" <user-mode-linux-user@lists.sourceforge.net>
Sent: Friday, November 28, 2003 10:35 PM
Subject: Re: bug in COW? - Re: [uml-user] uml 2.6.0-test9 crash


> On Fri, 28 Nov 2003, roland wrote:
> 
> > thanks - will give it a try. i already were aware of bonnie, but i thought it
> > was just a benchmark program.
> 
> It is, by trying to stress the I/O as hard as possible in different 
> conditions.
> 
> > here is the output. 
> > the i/o stops, but uml still consumes cpu.
> 
> Then there most likely is a UML problem. Recommended action is to attach a
> debugger an look what the UML kernel is doing.
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
