Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCxnp-00041t-Dq for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 02:37:01 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DCxnm-0005O6-BI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 02:37:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] ptrace_test.c program on PPC
References: <838f7c50050317161548f108@mail.gmail.com>
In-Reply-To: <838f7c50050317161548f108@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503201136.32209.blaisorblade@yahoo.it>
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
Date: Sun, 20 Mar 2005 11:36:31 +0100
To: user-mode-linux-devel@lists.sourceforge.net, ashwin tanugula <ashwin.tanugula@gmail.com>

On Friday 18 March 2005 01:15, ashwin tanugula wrote:
> Hi!
> I tried running ptrace_test.c on my ppc. Initially i initialized
> ORIG_EAX to 20 which is the system call number for getpid on my ppc,
> but it gave out two different pids.
> Then i started playing with the numbers
> Finally i got same pids when i put ORIG_EAX to 0 , which is the system
> call number for  restart_syscall.
> Can somebody tell me if my machine is able to run UML?
Not lookign at the above results, UML used to run on PPC, but there is not a 
current version of UML working... there is some work towards a port (see 
http://www.usermodelinux.org/ news). However nothing for users at the moment.
> Thanks,
> Ashwin.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
