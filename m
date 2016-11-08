Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1c42JH-0001D1-4s
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2016 09:03:15 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92]
	helo=www.kot-begemot.co.uk)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1c42JG-0006lI-4F
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2016 09:03:15 +0000
References: <1475218410-32852-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<ede78dee-1dd5-8d5c-d86b-cf7ae7e54e9a@nod.at>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <4db13914-e866-77c7-4a8d-6cd3bae739bc@kot-begemot.co.uk>
Date: Tue, 8 Nov 2016 08:33:13 +0000
MIME-Version: 1.0
In-Reply-To: <ede78dee-1dd5-8d5c-d86b-cf7ae7e54e9a@nod.at>
Subject: Re: [uml-devel] [PATCH v2] UBD Improvements Phase 1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Daniel Walter <sahne@sigma-star.at>, Anton Ivanov <aivanov@kot-begemot.co.uk>

I will sort out the whitespace and resubmit tonight. Tomorrow morning 
latest.

Apologies (I thought I had the environment set-up so it does not produce 
whitespace issues).

Brgds,

A.

On 07/11/16 22:30, Richard Weinberger wrote:
> Anton,
>
> On 30.09.2016 08:53, anton.ivanov@kot-begemot.co.uk wrote:
>> From: Anton Ivanov <aivanov@kot-begemot.co.uk>
>>
>> UBD at present is extremely slow because it handles only
>> one request at a time in the IO thread and IRQ handler.
>>
>> The single request at a time is replaced by handling multiple
>> requests as well as necessary workarounds for short reads/writes.
>>
>> Resulting performance improvement in disk IO - 30%
>>
>> Signed-off-by: Anton Ivanov <aivanov@kot-begemot.co.uk>
> In general I think we can merge this in 4.10.
> But please run checkpatch.pl and fix all the whitespace issues. :-)
>
> Daniel, can you apply your blk-mq work on top of this patch?
>
> Thanks,
> //richard
>


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

