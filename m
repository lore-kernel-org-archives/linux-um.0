Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1covPB-0007m4-Iu
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:11:09 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1covP9-0000fS-L7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:11:09 +0000
References: <0fbc8e03-783e-eed6-8e2e-100f8da6d36e@kot-begemot.co.uk>
	<CAFLxGvx0zpqgbp49DxQ_V8bxLGRKw6ziYstqK7hzcqUUvXuajQ@mail.gmail.com>
	<92e57cd0-8ef6-445d-ec61-a79a6f7a6da8@kot-begemot.co.uk>
From: Richard Weinberger <richard@nod.at>
Message-ID: <8eee2799-2d17-e489-81fb-0d6495cee814@nod.at>
Date: Fri, 17 Mar 2017 18:10:59 +0100
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Anton,

Am 17.03.2017 um 18:04 schrieb Anton Ivanov:
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
> 
> mm/mmap.c line 1112
> 
> I spent the day polishing the epoll patch so have not had the time to look at this.
> 
> It works fine with the 3 warns there commented out.

Hm, it does not trigger here. Can you share your .config?

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

