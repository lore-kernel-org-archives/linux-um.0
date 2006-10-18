Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GaIZz-0008Ha-Po for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 14:03:59 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GaIZz-0006tF-21
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 14:03:59 -0700
Message-ID: <453696AD.8020903@linuxbox.cz>
Date: Thu, 19 Oct 2006 00:03:41 +0300
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
MIME-Version: 1.0
References: <4536495E.7010006@l4x.org>	<20061018190957.GG6566@ccure.user-mode-linux.org>
	<45367D7E.9040609@l4x.org>
In-Reply-To: <45367D7E.9040609@l4x.org>
Subject: Re: [uml-devel] Programs in guest segfault, amd64 host and guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jan Dittmer <jdi@l4x.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

try exporting LD_ASSUME_KERNEL=2.4.1 before executing Your application, 
to see if that works - this disables usage of NPTL
Jan Dittmer wrote:
> Jeff Dike wrote:
>   
>> On Wed, Oct 18, 2006 at 05:33:50PM +0200, Jan Dittmer wrote:
>>     
>>> clone(Process 484 attached
>>> child_stack=0x4244e280, 
>>> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, 
>>> parent_tidptr=0x4244e9f0, tls=0x4244e960, child_tidptr=0x4244e9f0) = 484
>>> [pid   483] rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
>>> [pid   484] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
>>> Process 484 detached
>>> <... rt_sigprocmask resumed> NULL, 8)   = 0
>>> +++ killed by SIGSEGV +++
>>>       
>> I suspect it's due to UML/x86_64 having incomplete NPTL support,
>> although I've had almost no problems with up-to-date Fedora
>> filesystems on x86_64.  The one thing I do see is yum segfaulting
>> occassionally, but I haven't been able to tie that to NPTL.
>>     
>
> This is 100% reproducible here. Perfect test case. How to debug?
>
> Jan
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
