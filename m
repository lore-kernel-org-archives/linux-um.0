Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8HPR-0000aE-K9 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 03:27:57 -0800
Received: from mxout.hispeed.ch ([62.2.95.247] helo=smtp.hispeed.ch)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B8HPQ-0008Fm-UF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 03:27:57 -0800
Received: from epfl.ch (TVT-CaTV-dhcp-53-157.urbanet.ch [80.238.53.157])
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id
	i2UBRsdN008808 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 30 Mar 2004 13:27:54 +0200
Message-ID: <406958BA.7080109@epfl.ch>
From: Nicolas Blanc <nicolas.blanc@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] skas understanding
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
Date: Tue, 30 Mar 2004 13:23:38 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hello,
I am trying to figure out how does UML run in skas mod (I already red some
papers abouts it and now I d'like to jump into the code),
but I am experiencing some difficulties about things that are done in
function start_uml_skas :

1)  in function start_userspace :

    stack = mmap(...,MAP_ANONYMOUS,...);
    ...
    pid = clone(userspace_tramp, (void *) sp,
            CLONE_FILES | CLONE_VM | SIGCHLD, NULL);
    ...
    munmap(stack,PAGE_SIZE);

I don't understand the purpose of using anonymous mmap.

2) capture_signal_stack() : what is it for ?

3) Where is the kernel thread?

Thanks

Nicolas



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
