Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1d61IZ-0003Mq-OK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2017 20:54:59 +0000
Received: from mail-io0-f170.google.com ([209.85.223.170])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d61IY-000317-UQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2017 20:54:59 +0000
Received: by mail-io0-f170.google.com with SMTP id p24so20067220ioi.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 May 2017 13:54:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <382a3365-90f8-e813-3ee2-f1e39bab9f45@nod.at>
References: <20170302122200.0b261620@gmail.com>
	<7272a131-6167-6fed-5cdd-1cee80176a09@nod.at>
	<20170302141640.7cc2c691@gmail.com>
	<382a3365-90f8-e813-3ee2-f1e39bab9f45@nod.at>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 3 May 2017 22:54:53 +0200
Message-ID: <CAFLxGvyJYZM=T_+FSF_mEKbnf2DFV67RZd9K3m8xqyryOTx6qA@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH v2] um: Set number of CPUs
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
To: Richard Weinberger <richard@nod.at>
Cc: Nikola Kotur <kotnick@gmail.com>, Jeff Dike <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Mar 3, 2017 at 9:11 AM, Richard Weinberger <richard@nod.at> wrote:
> Nikola,
>
> Am 02.03.2017 um 14:16 schrieb Nikola Kotur:
>> Define NR_CPUS required by the timer subsystem.
>>
>> Fixes this make warning:
>>
>>     scripts/kconfig/conf  --oldconfig arch/x86/um/Kconfig
>>     kernel/time/Kconfig:155:warning: range is invalid
>>
>> Signed-off-by: Nikola Kotur <kotnick@gmail.com>
>
> Looks good!
>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Applied.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

