Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cz3Dd-00012d-T2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 17:34:09 -0800
Received: from wproxy.gmail.com ([64.233.184.206])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cz3Dc-00047U-Ez for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 17:34:09 -0800
Received: by wproxy.gmail.com with SMTP id 69so42934wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 09 Feb 2005 17:34:00 -0800 (PST)
Message-ID: <d496a7f505020917334199160@mail.gmail.com>
From: McGroarty <mcgroarty@gmail.com>
Reply-To: McGroarty <mcgroarty@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] uml 2.4.27-1um lockup at halt/reboot (strace)
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
Date: Wed, 9 Feb 2005 19:33:59 -0600
To: user-mode-linux-devel@lists.sourceforge.net

One of my machines' guests do not exit properly when "shutdown -h now"
is run from the guest. Instead the guest locks up forever and needs a
kill -9.

The offending machine runs 2.6.8.10-skas3 host, 2.4.27-1um guest, and
is an SMP machine (P4 HT).


xent@um-412:~$ tail -20 dumpy.txt
munmap(0xacbf4000, 4096)                = 0
munmap(0xacbf5000, 4096)                = 0
munmap(0xacbf6000, 4096)                = 0
munmap(0xacbf7000, 4096)                = 0
munmap(0xacbf8000, 4096)                = 0
munmap(0xacbf9000, 4096)                = 0
munmap(0xacbfa000, 4096)                = 0
munmap(0xacbfb000, 4096)                = 0
munmap(0xacbfc000, 4096)                = 0
munmap(0xacbfd000, 4096)                = 0
munmap(0xacbfe000, 4096)                = 0
munmap(0xacbff000, 4096)                = 0
sigreturn()                             = ? (mask now [])
getdents64(16, /* 3 entries */, 4096)   = 72
unlink("/home/xent/.uml/xent/pid")      = 0
getdents64(16, /* 0 entries */, 4096)   = 0
rmdir("/home/xent/.uml/xent")           = 0
kill(1386, SIGKILL)                     = 0
waitpid(1386, NULL, 0)                  = ? ERESTARTSYS (To be restarted)


This was the state of process 1386:

um-412:~# ps ax |grep 1[3]86
 1386 pts/0    T+     0:01 [linux]


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
