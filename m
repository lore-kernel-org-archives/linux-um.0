Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dNONF-0006GJ-Gj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jun 2017 18:59:37 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dNONE-0003nm-LT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jun 2017 18:59:37 +0000
From: Richard Weinberger <richard@nod.at>
References: <1497923806.7300.2.camel@m3y3r.de>
	<98803c66-4a36-a95f-5a1b-51a40de7a3e6@nod.at>
	<1497948550.7300.5.camel@m3y3r.de>
	<25066617-df15-6d21-713c-1ede1e953448@nod.at>
	<1497981874.22112.20.camel@test-lenovo>
	<4d431238-28c7-3680-42f2-f7cf32acbc86@nod.at>
Message-ID: <2fc7383c-852a-be3c-f934-b125fe9bdba2@nod.at>
Date: Tue, 20 Jun 2017 20:59:24 +0200
MIME-Version: 1.0
In-Reply-To: <4d431238-28c7-3680-42f2-f7cf32acbc86@nod.at>
Content-Language: en-US
Subject: Re: [uml-devel] um: PTRACE_SETREGSET failure with XSTATE on
 Kabylake CPU
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>, linux-x86_64@vger.kernel.org

Yu-cheng,

Am 20.06.2017 um 20:17 schrieb Richard Weinberger:
> Yu-cheng,
> 
> Am 20.06.2017 um 20:04 schrieb Yu-cheng Yu:
>>>> So to summarize:
>>>>
>>>> - PTRACE_GETREGSET with NT_X86_XSTATE gets 832 and return 832, with no
>>>> error.
>>>>
>>>> - PTRACE_SETREGSET get 832 (sizeof struct _xstate) but wants at least
>>>> 1088, otherwise it will fail with -EFAULT (why not -EINVAL?)
>>>>
>>>> Ideas?
>>
>> We considered allowing a partial XSAVE buffer for PTRACE_SETREGSET, but
>> it was that the XSAVE instruction requires a full-size buffer led to
>> this choice.  Using a smaller buffer for XSAVE causes a fault.
> 
> So, this code is not supposed to work?
> 
> iov.iov_base = fp_regs;
> iov.iov_len = sizeof(struct _xstate);
> ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
> ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov);
> 
> This is what UML does and on Thomas's new Laptop PTRACE_SETREGSET is failing.

Hmm, I think we need to do what gdb does, it uses a buffer of size X86_XSTATE_MAX_SIZE.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

