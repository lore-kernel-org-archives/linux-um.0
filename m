Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <martin.partel@gmail.com>) id 1T3Y85-0006Y2-4R
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2012 19:59:17 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T3Y7z-0004WP-Kn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Aug 2012 19:59:17 +0000
Received: by lagv3 with SMTP id v3so3565200lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 20 Aug 2012 12:59:05 -0700 (PDT)
Message-ID: <50329707.1000900@gmail.com>
Date: Mon, 20 Aug 2012 22:59:03 +0300
From: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
MIME-Version: 1.0
References: <alpine.DEB.2.00.1208200947470.9242@cobra.newdream.net>
	<50326B64.7020904@nod.at>
In-Reply-To: <50326B64.7020904@nod.at>
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
Subject: Re: [uml-devel] build error on 3.6-rc1 and later
To: Richard Weinberger <richard@nod.at>
Cc: jdike@addtoit.com, Sage Weil <sage@inktank.com>, user-mode-linux-devel@lists.sourceforge.net

Darn, sorry! I should have tried to compile under different 
configurations. Adding the NULL is the correct fix.

On 08/20/2012 07:52 PM, Richard Weinberger wrote:
> Am 20.08.2012 18:49, schrieb Sage Weil:
>> I'm getting
>>
>> arch/um/os-Linux/time.c: In function 'deliver_alarm':
>> arch/um/os-Linux/time.c:117:3: error: too few arguments to function 'alarm_handler'
>> In file included from arch/um/os-Linux/time.c:13:0:
>> arch/um/os-Linux/internal.h:1:6: note: declared here
>>
>> on 3.6-rc1 and later.  FWIW I blindly added an extra NULL argument and it
>> seems to behave:
>>
>> diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
>> index f602385..0748fe0 100644
>> --- a/arch/um/os-Linux/time.c
>> +++ b/arch/um/os-Linux/time.c
>> @@ -114,7 +114,7 @@ static void deliver_alarm(void)
>>          skew += this_tick - last_tick;
>>
>>          while (skew >= one_tick) {
>> -               alarm_handler(SIGVTALRM, NULL);
>> +               alarm_handler(SIGVTALRM, NULL, NULL);
>>                  skew -= one_tick;
>>          }
>>
>
> Martin,
>
> looks like you've introduced this regression.
> Can you please have a look?
>
> Thanks,
> //richard
>


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

