Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adlp4-0002AC-N4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 23:40:18 -0800
Received: from [81.193.166.163] (helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Adlp3-00061X-Va for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 23:40:18 -0800
Message-ID: <3FFA66B3.501@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: Resolution (Re: [uml-devel] 2.4.22-[67] problems)
References: <20031220011323.GW18100@alcor.net>
	<20031220171450.GB10692@ccure.user-mode-linux.org>
	<20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
In-Reply-To: <200401060258.i062wWFI023087@ccure.user-mode-linux.org>
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
Date: Tue, 06 Jan 2004 07:41:39 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org

Hi!

Jeff Dike wrote:
> mdz@debian.org said:
> 
>>It turns out that this problem seems to be due to compiler
>>incompatibility. UML had been built with gcc 2.95 due to old breakage,
>>and when built with gcc 3.3 (as glibc is), everything starts working
>>again.  My suspicion is that this is due to certain recent changes in
>>pthreads.
> 
> 
> Is it your opinion that there's no problem in UML itself?  Having a field
> in the sigcontext getting magically munged is somewhat worrying.  I'd be 
> happier knowing what exactly was happening so I can be sure this wasn't
> exposing some subtle UML bug.
> 

I've been doing some tests and I'd say that the problem is something 
regarding the NPTL+TLS+__thread features of recent libc6 (2.3.2 and 
2.3.3cvs)... But I'm clueless about the fix :-)

I'll setup a chroot where I can play around with glibc setups.

OARS, why does linux (the UML executable) doesn't run under 
/lib/ld-linux.so?

Example:
puma:/tmp# ldd /usr/bin/scp
                 libutil.so.1 => /lib/tls/i686/cmov/libutil.so.1 
(0x4002f000)
         libz.so.1 => /usr/lib/libz.so.1 (0x40032000)
         libnsl.so.1 => /lib/tls/i686/cmov/libnsl.so.1 (0x40044000)
         libcrypto.so.0.9.7 => /usr/lib/i686/cmov/libcrypto.so.0.9.7 
(0x40059000)
         libc.so.6 => /lib/tls/i686/cmov/libc.so.6 (0x40156000)
         libdl.so.2 => /lib/tls/i686/cmov/libdl.so.2 (0x4028f000)
         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

puma:/tmp# ldd ./linux
                 libutil.so.1 => /lib/tls/i686/cmov/libutil.so.1 
(0x40018000)
         libc.so.6 => /lib/tls/i686/cmov/libc.so.6 (0x4001b000)
         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
puma:/tmp#

scp has a superset of linux's shared libs and runs ok:
puma:/tmp# /lib/ld-linux.so.2 --library-path /lib:/usr/lib /usr/bin/scp
usage: scp [-pqrvBC1246] [-F config] [-S program] [-P port]
            [-c cipher] [-i identity] [-l limit] [-o option]
            [[user@]host1:]file1 [...] [[user@]host2:]file2
puma:/tmp#


But linux does not run:
puma:/tmp# /lib/ld-linux.so.2 --library-path /lib:/usr/lib /tmp/linux
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Mapping memory: Invalid argument
puma:/tmp#

If linux could run under ld-linux-so helper testing would be easier :)

Regards,
Nuno Silva






-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
