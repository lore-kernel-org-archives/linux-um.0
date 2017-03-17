Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1covcj-00050d-Qo
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:25:09 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
	helo=www.kot-begemot.co.uk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1covci-00015x-UC
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:25:09 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
	helo=smaug.kot-begemot.co.uk) by www.kot-begemot.co.uk with esmtps
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1covcc-0000aI-Hc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:25:02 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1covcc-0006Zk-Ak
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:25:02 +0000
References: <0fbc8e03-783e-eed6-8e2e-100f8da6d36e@kot-begemot.co.uk>
	<CAFLxGvx0zpqgbp49DxQ_V8bxLGRKw6ziYstqK7hzcqUUvXuajQ@mail.gmail.com>
	<92e57cd0-8ef6-445d-ec61-a79a6f7a6da8@kot-begemot.co.uk>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <e8eb888a-f643-e480-e763-d9a45308ada4@kot-begemot.co.uk>
Date: Fri, 17 Mar 2017 17:25:02 +0000
MIME-Version: 1.0
In-Reply-To: <92e57cd0-8ef6-445d-ec61-a79a6f7a6da8@kot-begemot.co.uk>
Subject: Re: [uml-devel] UML regression with latest RC 4.11-rc2
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
To: user-mode-linux-devel@lists.sourceforge.net

On 17/03/17 17:04, Anton Ivanov wrote:
> On 17/03/17 16:56, Richard Weinberger wrote:
>> Anton,
>>
>> On Fri, Mar 17, 2017 at 8:51 AM, Anton Ivanov
>> <anton.ivanov@kot-begemot.co.uk> wrote:
>>> Hi list, hi Richard
>>>
>>> There is an extra check in mm/mmap.c which now throws a WARN on every
>>> page in making UML unusable with the latest 4.11-rc2
>> Which WARN? Can you find the offending commit?
> mm/mmap.c line 1112
>
> I spent the day polishing the epoll patch so have not had the time to
> look at this.
>
> It works fine with the 3 warns there commented out.

It looks like the culprit is an SMP mmap race fix 
e86f15ee64d8ee46255d964d55f74f5ba9af8c36

A.

>
> A.
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

