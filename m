Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1TrVVn-0006FG-QC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Jan 2013 15:18:15 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TrVVh-0002Z0-KE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Jan 2013 15:18:15 +0000
Received: from [194.164.232.154] (helo=localhost.localnet)
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1TrV7I-0000Bg-G9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Jan 2013 14:52:59 +0000
From: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Message-ID: <1558576.MRf0N3N32R@localhost>
MIME-Version: 1.0
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
Date: Sat, 05 Jan 2013 15:18:17 +0000
Subject: [uml-devel] UML Network Related Crashing
To: user-mode-linux-devel@lists.sourceforge.net


I have problems with UML crashing that I believe are network related, because the crash happens whenever I try to make heavier use of the network connection to rsync more significant amounts of data from the UML.

It may or may not be significant, but when I am rsyncing from one UML to another, it has so far always been the one that is supplying the data that has crashed.

I have this with a UML that is accessed via a tap link and a real network connection, and also between two UMLs on the same host communicating via an 'mcast' connection.

Most of the time the affected UML simply locks up, and I can't do anything with it. Even if I try to drive it with uml_mconsole, that will not communicate with the UML. I sometimes see the ---[cut]--- type of output, but it doesn't get beyond that line. Sometimes I see no output before the thing locks up.

I've been experimenting with two UML instances communicating via mcast on my local machine, and I have experienced this output:

-bash-4.2# /sbin/sshd                                                                                                                                                                                                                                                          
-bash-4.2#                                                                                                                                                                                                                                                                     
EIP: 0023:[<08075749>] CPU: 0 Not tainted ESP: 002b:165fffb8 EFLAGS: 00010206                                                                                                                                                                                                  
    Not tainted                                                                                                                                                                                                                                                                
EAX: 963523cf EBX: 16600638 ECX: 01400002 EDX: 01400000                                                                                                                                                                                                                        
ESI: 0a0d4828 EDI: 00000000 EBP: 165fffbc DS: 002b ES: 002b
0837a750:  [<0806cf3a>] show_regs+0xc0/0xc6
0837a77c:  [<0805cd42>] segv+0x202/0x218
0837a81c:  [<0805cdaa>] segv_handler+0x52/0x5d
0837a848:  [<08068a5f>] sig_handler_common+0x79/0x8c
0837aac8:  [<08068b4d>] sig_handler+0x34/0x43
0837aad4:  [<080687e2>] hard_handler+0x5a/0x88
0837aafc:  [<ffffe410>] 0xffffe410

Kernel panic - not syncing: Kernel mode fault at addr 0x963524a7, ip 0x8075749
0837a744:  [<08249cc3>] dump_stack+0x16/0x1a
0837a758:  [<08249d4d>] panic+0x67/0x149
0837a770:  [<0805cd4e>] segv+0x20e/0x218
0837a81c:  [<0805cdaa>] segv_handler+0x52/0x5d
0837a848:  [<08068a5f>] sig_handler_common+0x79/0x8c
0837aac8:  [<08068b4d>] sig_handler+0x34/0x43
0837aad4:  [<080687e2>] hard_handler+0x5a/0x88
0837aafc:  [<ffffe410>] 0xffffe410


EIP: 0023:[<400010c2>] CPU: 0 Not tainted ESP: 002b:ff5a8674 EFLAGS: 00000212
    Not tainted
EAX: ffffffda EBX: ff5a87f0 ECX: ff5a8790 EDX: 401edff4
ESI: 00000000 EDI: ff5a87f0 EBP: ff5a8790 DS: 002b ES: 002b
0837a6b4:  [<0806cf3a>] show_regs+0xc0/0xc6
0837a6e0:  [<0805cfd3>] panic_exit+0x20/0x36
0837a6f4:  [<08088af7>] notifier_call_chain+0x20/0x4b
0837a71c:  [<08088b39>] __atomic_notifier_call_chain+0x17/0x19
0837a72c:  [<08088b50>] atomic_notifier_call_chain+0x15/0x17
0837a748:  [<08249d65>] panic+0x7f/0x149
0837a770:  [<0805cd4e>] segv+0x20e/0x218
0837a81c:  [<0805cdaa>] segv_handler+0x52/0x5d
0837a848:  [<08068a5f>] sig_handler_common+0x79/0x8c
0837aac8:  [<08068b4d>] sig_handler+0x34/0x43
0837aad4:  [<080687e2>] hard_handler+0x5a/0x88
0837aafc:  [<ffffe410>] 0xffffe410

Terminated
bash-4.1# 

What happened here was that I started two virtually identical UML instances on the same host, communicating with each other via mcast interfaces. I started sshd on one of them and then started to rsync data from it to the other. After a short while I got the above.

I have a UML running on a remote machine that I access via the Internet. I can always crash this when I try to copy data from it, and I assume that the above represents the same fault. I'm happy to do any testing required to try to help fix this.

David Humphreys



------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122912
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

