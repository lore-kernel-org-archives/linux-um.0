Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1VAcMt-0005Kq-Lc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Aug 2013 09:00:19 +0000
Received: from mail-vb0-f43.google.com ([209.85.212.43])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VAcMt-0006iv-0N
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Aug 2013 09:00:19 +0000
Received: by mail-vb0-f43.google.com with SMTP id h11so2152937vbh.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Aug 2013 02:00:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cae15b5bcee216a9879a11d8a219daba@nixia.no>
References: <1376682288-25315-1-git-send-email-richard@nod.at>
	<cae15b5bcee216a9879a11d8a219daba@nixia.no>
Date: Sat, 17 Aug 2013 11:00:13 +0200
Message-ID: <CAFLxGvwzozJF8cf6kGBVc9n5-z+D1qHRdX0ni3Mmugz509cdXA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] um: Implement probe_kernel_read()
To: Stian Skjelstad <stian@nixia.no>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Aug 17, 2013 at 9:44 AM,  <stian@nixia.no> wrote:
> Den 2013-08-16 21:44, skrev Richard Weinberger:
>> +long probe_kernel_read(void *dst, const void *src, size_t size)
>> +{
>> +     void *psrc = (void *)rounddown((u64)src, PAGE_SIZE);
> Should not size be increased if psrc is moved down?
>
> Example:
>   src  = 0x0ffff; // pointed to the very end of a page
>   size = 2;       // big enough to cross two pages
>
>   psrc = 0x0f000; // pointed to the start of the first page
>   size = 2;       // does not include the second page anymore
>
>   second page is not checked
>
> Or is this not a problem?

Good catch, it is of course a problem!
My test cases did all pass because size is always smaller than PAGE_SIZE
and mincore() with at PAGE_SIZE granularity. :-\

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

