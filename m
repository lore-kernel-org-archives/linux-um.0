Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYQLS-0003ZI-MJ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 08:20:26 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYQLQ-00063N-VE	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 08:20:26 -0700
Message-ID: <428B5D30.6080706@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<200505162324.37749.blaisorblade@yahoo.it>
	<3524bf1f0505161709476c4940@mail.gmail.com>
	<200505170217.23138.blaisorblade@yahoo.it>
	<3524bf1f050517105676c6c051@mail.gmail.com>
	<20050517220053.GA10144@ccure.user-mode-linux.org>
	<428B0F2B.3060503@fujitsu-siemens.com>
	<20050518133331.GB3925@ccure.user-mode-linux.org>
In-Reply-To: <20050518133331.GB3925@ccure.user-mode-linux.org>
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
Date: Wed, 18 May 2005 17:20:16 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Young Koh <young.koh@gmail.com>, Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Wed, May 18, 2005 at 11:47:23AM +0200, Bodo Stroesser wrote:
> 
>>I also thought about not saving FP-regs on each kernel entry. But if you do
>>this optimization, you need to save / restore FP-regs on switch_to. Also you
>>need to get the FP-regs when setting up a signal-handler stackframe. And 
>>they
>>have to be restored on sys_(rt_)sigreturn from the values found in the
>>stackframe.
> 
> 
> True, but these are much less frequent than kernel entries/exits.
Yes, so it makes sense to optimize this for i386 and x86_64.

On s390, I'm not sure, what to do. Using s390's PTRACE_PEEK/POKEUSR_AREA
UML can read or write all regs including FP in a single ptrace call.
So, the change would speed up that call a bit, but would that be enough
to pay the cost of additional ptrace calls in switch_to or signal handling?

What do you think?

	Bodo
> 
> 
>>I hope, I didn't miss some other places that would need adaption.
> 
> 
> Offhand, this sounds right.
> 
> 				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
