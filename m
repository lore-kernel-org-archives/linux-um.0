Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdmQN-0003Wo-6j for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 00:18:51 -0800
Received: from [81.193.166.163] (helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AdmQM-0006cS-Ky for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 00:18:50 -0800
Message-ID: <3FFA6FB9.6060403@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: Resolution (Re: [uml-devel] 2.4.22-[67] problems)
References: <20031220171450.GB10692@ccure.user-mode-linux.org>
	<20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
	<3FFA66B3.501@vgertech.com> <20040106080258.GT28393@alcor.net>
In-Reply-To: <20040106080258.GT28393@alcor.net>
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
Date: Tue, 06 Jan 2004 08:20:09 +0000
To: Matt Zimmerman <mdz@debian.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org



Matt Zimmerman wrote:
> On Tue, Jan 06, 2004 at 07:41:39AM +0000, Nuno Silva wrote:
> 
> 
>>Jeff Dike wrote:
>>
>>>mdz@debian.org said:
>>>Is it your opinion that there's no problem in UML itself?  Having a field
>>>in the sigcontext getting magically munged is somewhat worrying.  I'd be 
>>>happier knowing what exactly was happening so I can be sure this wasn't
>>>exposing some subtle UML bug.
>>>
>>
>>I've been doing some tests and I'd say that the problem is something 
>>regarding the NPTL+TLS+__thread features of recent libc6 (2.3.2 and 
>>2.3.3cvs)... But I'm clueless about the fix :-)
> 
> 
> I suspect that the problem lies in this direction, because it's the only
> relevant news that I've heard from glibc in recent months, but I wouldn't
> expect NPTL to relate directly because I'm running on 2.4 (as are several
> others who have seen the problem).
> 
> This is the issue where i386 support was dropped and i486-specific
> instructions used, right?
> 

Yes, AFAIK nptl requires 486 asm.

I just finished testing debian-unstable with glibc with nptl, tls and 
__thread support in chroot and everything works fine except UML :)

I'm recompiling glibc with profiling to get a usable backtrace right now.

With this setup linux gets a SIGSTOP (automagically) and after SIGCONT 
it just segfaults... In a few moments I'll have a backtrace :-)

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
