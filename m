Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aewlp-0000jq-Uz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:33:49 -0800
Received: from adsl-b4-78-221.telepac.pt ([81.193.78.221]
	helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aewlp-0006Hb-Cz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 05:33:49 -0800
Message-ID: <3FFEAE2A.4030700@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled
	glibc problem
References: <3FFE6FE3.8090303@vgertech.com> <3FFEAA6C.8020002@timesys.com>
In-Reply-To: <3FFEAA6C.8020002@timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 09 Jan 2004 13:35:38 +0000
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net



La Monte H.P. Yarroll wrote:
> 
> 
> The calls set_thread_area(2) and get_thread_area(2) are not implemented 
> in UML.
> Both are essential to NPTL.  There may be other problems too...
> 
> Implementing them gets really tricky if you want UML to work with a 
> 2.4.x host.
> I've been trying to steal enough cycles to learn enough to just 
> implement them on a 2.6.0 host.
> 

Hi!

You're talking about running nptl enabled glibc inside UML, aren't you?

I'm talking about the host. Any host with kernel 2.6 and glibc-nptl-tls 
makes the uml executable segfault very early (see the link in my 
previous message for strace and gdb output.

Quick description:

-----
puma:/uml# ./linux
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found

[1]+  Stopped                 ./linux
puma:/uml# fg
./linux
Segmentation fault
puma:/uml# ldd linux
         linux-gate.so.1 =>  (0xffffe000)
         libutil.so.1 => /lib/libutil.so.1 (0x40019000)
         libc.so.6 => /lib/libc.so.6 (0x4001c000)
         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
puma:/uml# uname -a
Linux puma 2.6.0 #2 Mon Jan 5 09:25:45 WET 2004 i686 unknown unknown 
GNU/Linux
-----

Or did I miss anything in your explanation?

Regards,
Nuno Silva



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
