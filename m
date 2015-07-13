Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZEevm-0002b6-8b
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 14:42:06 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEevf-0006yi-VG
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 14:42:06 +0000
Message-ID: <55A3CE2F.5030105@nod.at>
Date: Mon, 13 Jul 2015 16:41:51 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1436794918.3306.5.camel@m3y3r.de>		
	<CAFLxGvwo2hjvrkF_ChR1Ooc6o7OqEGEOKnP=4NAmt8vP07Kd-Q@mail.gmail.com>	
	<1436795884.3306.7.camel@m3y3r.de> <55A3C47B.8040206@nod.at>
	<1436797445.3306.10.camel@m3y3r.de>
In-Reply-To: <1436797445.3306.10.camel@m3y3r.de>
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
Subject: Re: [uml-devel] uml_net zombie processes
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 13.07.2015 um 16:24 schrieb Thomas Meyer:
>> Yeah. And please add a dump_stack() to figure out where it was 
>> called.
> 
> I think calling dump_stack() somehow changed the errno to 25?!

>  
> +extern __attribute__((regparm(0))) void dump_stack(void);

Hmm, maybe the regparm(0) kills your stack.
Anyway, how do you trigger the issue?
I tried here and don't see any zombie processes?
In my setup I run UML as non-root and tap0 is owned by root.
-> UML is unable to setup eth0.
But no zombies here.

Thanks,
//richard

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

