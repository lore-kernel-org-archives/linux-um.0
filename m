Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRFto-0005sB-LS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 May 2004 12:41:44 -0700
Received: from zrc2s0jx.nortelnetworks.com ([47.103.122.112])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRFto-000245-88 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 May 2004 12:41:44 -0700
Received: from zsc3c028.us.nortel.com (zsc3c028.us.nortel.com [47.81.138.28])
	by zrc2s0jx.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id i4LJfVC26094
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 May 2004 14:41:31 -0500 (CDT)
Message-ID: <40AE5B69.9030209@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050400070409040108010500"
Subject: [uml-devel] build errors with 2.4.24 + uml-patch-2.4.24-3
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
Date: Fri, 21 May 2004 15:41:29 -0400
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------050400070409040108010500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

tried compiling this combination on  a host that does not have any AIO 
support and the attached build errs.

I tried expanding the scope of the ifdefs on HAVE_AIO_ABI but then humfs 
   was unhappy...not sure if this source plays well when aio is not 
around...or I am doing something just wrong.

regards, Giovanni

--------------050400070409040108010500
Content-Type: text/plain;
 name="build.err"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build.err"

make[2]: Entering directory `/usr/local/builds/linux-2.4.24/arch/um/os-Linux'
gcc    -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -U__i386__ -Ui386 -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE  -I/usr/local/builds/linux-2.4.24/arch/um/include -I/usr/local/builds/linux-2.4.24/arch/um/kernel/tt/include -I/usr/local/builds/linux-2.4.24/arch/um/kernel/skas/include -D_GNU_SOURCE -c -o aio.o aio.c
aio.c: In function `init_aio_26':
aio.c:254: warning: implicit declaration of function `io_setup'
aio.c:254: `ctx' undeclared (first use in this function)
aio.c:254: (Each undeclared identifier is reported only once
aio.c:254: for each function it appears in.)
aio.c:261: `aio_thread' undeclared (first use in this function)
aio.c: In function `submit_aio_26':
aio.c:354: warning: implicit declaration of function `do_aio'
aio.c:354: `ctx' undeclared (first use in this function)
make[2]: *** [aio.o] Error 1
make[2]: Leaving directory `/usr/local/builds/linux-2.4.24/arch/um/os-Linux'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/local/builds/linux-2.4.24/arch/um/os-Linux'
make: *** [_dir_arch/um/os-Linux] Error 2

--------------050400070409040108010500--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
