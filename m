Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC59o-0005me-Ni for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 16:16:04 -0800
Received: from wproxy.gmail.com ([64.233.184.206])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DC59n-0007lu-5k for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 16:16:04 -0800
Received: by wproxy.gmail.com with SMTP id 69so332024wri
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Mar 2005 16:15:56 -0800 (PST)
Message-ID: <838f7c50050317161548f108@mail.gmail.com>
From: ashwin tanugula <ashwin.tanugula@gmail.com>
Reply-To: ashwin tanugula <ashwin.tanugula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] ptrace_test.c program on PPC
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
Date: Thu, 17 Mar 2005 19:15:55 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hi!
I tried running ptrace_test.c on my ppc. Initially i initialized
ORIG_EAX to 20 which is the system call number for getpid on my ppc,
but it gave out two different pids.
Then i started playing with the numbers
Finally i got same pids when i put ORIG_EAX to 0 , which is the system
call number for  restart_syscall.
Can somebody tell me if my machine is able to run UML?
Thanks,
Ashwin.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
