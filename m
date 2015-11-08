Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@Brocade.com>) id 1ZvYgp-0005AX-7x
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 22:43:59 +0000
Received: from mx0a-000f0801.pphosted.com ([67.231.144.122])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZvYgo-0000Jf-CQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 22:43:59 +0000
Received: from pps.filterd (m0048193.ppops.net [127.0.0.1])
	by mx0a-000f0801.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
	tA8MMSR7025691 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 8 Nov 2015 14:43:52 -0800
Received: from brmwp-exmb11.corp.brocade.com ([208.47.132.227])
	by mx0a-000f0801.pphosted.com with ESMTP id 1y29p88hnu-1
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 08 Nov 2015 14:43:52 -0800
From: Anton Ivanov <aivanov@Brocade.com>
Date: Sun, 8 Nov 2015 22:43:48 +0000
Message-ID: <563FD01A.3060102@brocade.com>
References: <1446994702-21240-1-git-send-email-aivanov@brocade.com>
	<563F66E2.6060509@brocade.com>
	<CAFLxGvyCpg3yiYdxZYXBn+GwYTjSECK1bxxQinRFQDQk0j4gSw@mail.gmail.com>
In-Reply-To: <CAFLxGvyCpg3yiYdxZYXBn+GwYTjSECK1bxxQinRFQDQk0j4gSw@mail.gmail.com>
Content-Language: en-US
Content-ID: <84289F1E9C711744BC446B5055143EC2@brocade.local>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] [PATCH] Missing includes in start up
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

No worries.

A completely rewritten IRQ controller patch is coming in ~ 15 minutes  
or so. 20% gain across the board for a basic config, up to 100s% gain if 
you register large numbers of devices (in the tens).

Just finishing to run it through its paces :)

It is also a pre-requisite to do multipacket reads/multipacket writes 
which will be next.

A.


On 08/11/15 22:38, Richard Weinberger wrote:
> On Sun, Nov 8, 2015 at 4:18 PM, Anton Ivanov <aivanov@brocade.com> wrote:
>> Hi Richard,
>>
>> This is vs your tree, 4.x master branch in linus repo actually has
>> sys/resource.h
>>
>> Pls ignore the patch.
> Sorry for the trouble!
> I forgot to mention that linux-next is the only valid branch in my tree.
> As UML does not have much patch flood I test them locally and push them directly
> to linux-next.
>

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

