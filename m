Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <520E5F69.8080207@nod.at>
Date: Fri, 16 Aug 2013 19:20:41 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1376668606-32354-1-git-send-email-richard@nod.at> <20130816161229.GI2505@htj.dyndns.org> <520E500B.5000408@nod.at> <20130816162844.GJ2505@htj.dyndns.org> <520E55A2.9080900@nod.at> <20130816164544.GK2505@htj.dyndns.org> <520E58F3.4080309@nod.at>
In-Reply-To: <520E58F3.4080309@nod.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] print_worker_info: Handle pointer with more care
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 16.08.2013 18:53, schrieb Richard Weinberger:
>> Yeah, and that should be fine.  &pwq->wq would be just an offset of wq
> 
> Yep. Now my brain also parsed the C notation correctly.
> Sorry for the completely wrong patch.
> 
>> from NULL which is an invalid pointer but probe_kernel_read() should
>> be able to handle that and probably just return 0 or -1 (all bits
>> set).  I *think* what's necessary is making probe_kernel_read() use
>> mincore() to fine out whether the requested address is mapped (it
>> should return -EFAULT if not) and try to dereference the address iff
>> it's mapped.
> 
> UML needs a custom probe_kernel_read()? Fine. :)

With my own probe_kernel_read() that uses mincore()
it works fine so far. :-)

Thanks,
//richard

