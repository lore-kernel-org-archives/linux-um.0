Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D14zn-0003Yb-A2 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Feb 2005 07:52:15 -0800
Received: from smtp3k.poczta.onet.pl ([213.180.130.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D14zk-00068S-NG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Feb 2005 07:52:15 -0800
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From: adamdabr@poczta.onet.pl
Message-Id: <20050215155130Z2659002-7959+680@kps3.test.onet.pl>
Subject: [uml-devel] problems making UML binary
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
Date: Tue, 15 Feb 2005 16:49:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

Could you please help me with the following problem? 

Here's a problem I've encountered when trying to compile an UML (User Mode Linux) linux binary: 

Details: 

1) I am working with Mandrake 10.1 Official distribution
2) I got 2.4.27 kernel and uml patch 2.4.27-1
3) Applied the patch - worked well
4) Did make xconfig ARCH=um and saved standard configuration
5) Then I've tried make linux ARCH=um but got problems:
	a) with gcc 3.4.1 that I started with (standard Mandrake 10.1 instalation) I've got a lot of errors like: 

"sched.c:839: error: conflicting types for 'sleep_on_timeout' 

/home/adam/work/UML/linux-2.4.27/include/linux/sched.h:598: error: previous declaration of 'sleep_on_timeout' 

was here" 

So I guessed it was a gcc/Mandrake problem..
	b) with gcc 3.3.1-2mdk or gcc 2.96-063mdk I got another problem - make linux ARCH=um runs smooth 

until it gets to linking: here is what I've got:
"ld -r -o unmap_fin.o unmap.o -lc -L/usr/lib
ld: cannot find -lc
make[3]: *** [unmap_fin.o] Error 1
make[3] Leaving directory `/home/adam/work/UML/linux-2.4.27/arch/um/kernel/tt'
..."

Could anybody please help me? My goal is to get UML in order to make some changes to kernel (A patch I've got 

to write), so downloading binary linux with maps&config is no solution - I need to be able to compile this. And I 

guess I need to start with raw UML working :\ 
What should I do?

P.S As you can see, I am not building it in /usr/src/linux

Thank you,
Adam


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
