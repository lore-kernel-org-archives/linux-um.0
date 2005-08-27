Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8ppc-0005Ev-5r	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 18:50:04 -0700
Received: from rgminet04.oracle.com ([148.87.122.33])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1E8ppb-0007xG-2i
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 18:50:04 -0700
Received: from rgmsgw301.us.oracle.com (rgmsgw301.us.oracle.com
	[138.1.186.50])j7R1nqSs031152
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 19:49:52 -0600
Received: from rgmsgw301.us.oracle.com (localhost [127.0.0.1])
	j7R1nqGC021220	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 19:49:52 -0600
Received: from [138.2.230.92] (agraves-lnx.us.oracle.com [138.2.230.92])
	j7R1npTW021213
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2005 19:49:51 -0600
Message-ID: <430FC6BF.2020806@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] gdb ignoring skas breakpoints?
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
Date: Fri, 26 Aug 2005 21:49:51 -0400
To: user-mode-linux-devel@lists.sourceforge.net

Jeff,
I thought i had this thread trace thing several times, but I couldn't 
get gdb to stop on breakpoints, its like it was ignoring them....   it 
thought everything was in thread_info.h.  And it listed the right code, 
and i could do like b 26, and it would set a breakpoint for line 26 of 
the correct function with the correct filename, and then just ignore it. 

(gdb) info b
Num Type           Disp Enb Address    What
1   breakpoint     keep y   0x0806f607 in panic at kernel/panic.c:74
2   breakpoint     keep y   0x0805c254 in switch_to_skas at 
arch/um/kernel/skas/process_kern.c:29
3   breakpoint     keep y   0x081e5ac5 in schedule at thread_info.h:50
4   breakpoint     keep y   0x081e6037 in schedule at kernel/sched.c:2747



Any suggestions?
Allan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
