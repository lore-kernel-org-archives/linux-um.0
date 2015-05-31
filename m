Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Yz1Dl-0007gh-AP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 11:16:01 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yz1Dj-0007iV-6N
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 11:16:01 +0000
Message-ID: <556AED66.3030706@nod.at>
Date: Sun, 31 May 2015 13:15:50 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <bbdd39b2-dcac-41c8-bfb4-73645e73c7b7@email.android.com>
In-Reply-To: <bbdd39b2-dcac-41c8-bfb4-73645e73c7b7@email.android.com>
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
Subject: Re: [uml-devel] [PATCH] um: Switch clocksource to hrtimers
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Am 20.05.2015 um 07:26 schrieb Thomas Meyer:
> 
> Am 20.05.2015 12:12 vorm. schrieb Richard Weinberger <richard.weinberger@gmail.com>:
>>
>> On Sun, May 17, 2015 at 11:25 AM, Thomas Meyer <thomas@m3y3r.de> wrote: 
>>> Switch the UML clocksource from interval timers to posix interval timers 
>>> and move to a monotonic timer. 
>>>
>>> This fixes suspend&resume related timer issues and improves network 
>>> performance as TCP state machines are now fed with the correct time; 
>>> also correct QoS and traffic shaping. 
>>>
>>> Signed-off-by: Thomas Meyer <thomas@m3y3r.de> 
>>
>> What tree is this patch against? 
>> It does not clearly apply to Linus' tree. 
>>
> 
> Hi,
> 
> I did tested the patch against 4.1-rc3-something; will update the patch against the latest commit!

Ping.
Would be nice to have this patch for the 4.2 merge window.

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

